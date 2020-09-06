#Global variables

# How many points does a team need to win?
# In-game settings must be adjusted to properly display this value
# See CUSTOMIZAION rule
globalvar scoreToWin
# Minimum respawn time (secs)
globalvar minRespawnTime
# Maximum respawn time (secs)
globalvar maxRespawnTime

# Where are the zones?
globalvar zoneLocations
# How large are the zones? (radius)
globalvar zoneSizes
# How tall are the zones? (height)
globalvar zoneHeights

# Capture rate = ax + b (x = num players)
# Base Capture Rate = b
globalvar baseCaptureRate
# Capture Rate Increase per player = a
globalvar captureRatePerPlayer
# Maximum number of players capturing before capture rate hard cap
globalvar maxPlayerRate
# Will the game use adaptive capture rates for different sized teams?
globalvar adaptiveCaptureRate

# Who controls the zone?
globalvar zoneControl
# How many members of Team 1 are on the zone?
globalvar numTeam1A
globalvar numTeam1B
globalvar numTeam1C
# How many members of Team 2 are on the zone?
globalvar numTeam2A
globalvar numTeam2B
globalvar numTeam2C
# Is Power Play active?
globalvar powerPlayActive
# How much time is left in Power Play?
globalvar powerPlayTimer
# Helper variable to trigger Power Play sound
globalvar powerPlaySoundTrigger
# Whether Power Play can be activated
globalvar powerPlayEnabled
# How long Power Play lasts for
globalvar powerPlayDuration
# Whether Power Play Markers are enabled
globalvar powerPlayMarkers
# Store match time to set when Power Play ends
globalvar resumeMatchTime

# Whether Overtime is enabled
globalvar overtimeEnabled
# Is Overtime in effect?
globalvar overtime

# Stores Zone active hud texts (0 = spec, 1 = Team 1, 2 = Team 2, 3 = Capturing/Contested string)
globalvar zoneAHudText
globalvar zoneBHudText
globalvar zoneCHudText
# Zone Progress
globalvar zoneAProgress
globalvar zoneBProgress
globalvar zoneCProgress
# Skull Markers (Power Play)
globalvar skullIcons
# Current score comparison (<0 if team 1 < team 2, 0 if team 1 == team 2, >0 if team 1 > team 2)
globalvar currScoreComp
# TODO: add disable scoring switch to aid in buffer time

#Player variables
# Whether a respawn input can be buffered
playervar respawnBlocked
# Tracker for buffered respawn input
playervar respawnBuffered
# Current message to display to player
playervar playerMessage
# HUD text ID for playerMessage
playervar msgTextID
# Time to available respawn
playervar timeToRespawn
# Mark as valid for alerting elims
playervar validElimTarget

#Subroutines
subroutine playElimSounds
subroutine declareWinner

# Helper pregen macros (thanks Zez)
#!define generatePointFlags() __script__('generateSetPointFlags.js')
#!define generateInitPointVisuals() __script__('generateInitialPointVisuals.js')
#!define generateChaserRules(point) __script__('generateChaserRules.js')
#!define generateVisualUpdates(point) __script__('generateVisualUpdates.js')
#!define initializeHelper() __script__('initialize.js')
#!define stopAllProgress() __script__('stopAllProgress.js')
#!define generateLockedText() __script__('generateLockedText.js')
#!define triggerPointReset(destroyText) __script__('triggerPointReset.js')
#!define toggleSkulls(create) __script__('toggleSkullIcons.js')
#!define generatePlayerHUDSpacer() __script__('generatePlayerHUDSpacer.js')
#!define generatePlayerHUD() __script__('generatePlayerHUD.js')

#!include "lobbySettings.opy"

rule "=====CUSTOMIZATION=====":
	@Event global
    @Disabled
    currScoreComp = false

#!include "customize.opy"

rule "=====SETUP=====":
	@Event global
	@Disabled
    currScoreComp = false

rule "Global Initialization - includes center zone HUD elements":
    @Event global
    # Mostly for debugging purposes
    if not createWorkshopSetting(bool, "Debug", "Inspector Enabled", false):
        disableInspector()
    # We use our own custom gamemode completion
    disableGamemodeCompletion()
    initializeHelper()
    # Push player-specific HUD down to crosshair level
    generatePlayerHUDSpacer()
    powerPlayActive = false

rule "Player Initialization":
    @Event eachPlayer
    generatePlayerHUD()
    # Stop normal respawn logic
    eventPlayer.disableRespawn()
    # Store the text ID for destruction on exit
    eventPlayer.msgTextID = getLastCreatedText()

rule "Player Cleanup":
    @Event playerLeft
    # Cleanup the player-specific HUD
    destroyHudText(eventPlayer.msgTextID)

#!include "maps.opy"

rule "Generate initial in-world zone visuals":
	@Event global
	@Condition len(zoneLocations) == 3 and len(zoneSizes) == 3
    generateInitPointVisuals()

rule "=====GAMEPLAY=====":
	@Event global
	@Disabled
    currScoreComp = false

rule "Remove respawn buffered marker on respawn (necessary because hero swap respawn is faster)":
    @Event eachPlayer
    @Condition eventPlayer.isAlive()
    # Reset for next death
    eventPlayer.respawnBuffered = false
    eventPlayer.respawnBlocked = false

rule "Main Respawn handler":
    @Event playerDied
    # Prevent manual respawn for 5 seconds
    victim.respawnBlocked = true
    # If currently power play, force respawn buffer
    if powerPlayActive:
        victim.respawnBuffered = true
    # Track time until respawn
    victim.timeToRespawn = minRespawnTime
    chase(victim.timeToRespawn, 0, rate=1, ChaseReeval.NONE)
    wait(minRespawnTime, Wait.RESTART_WHEN_TRUE)
    # Allow manual respawn
    victim.respawnBlocked = false
    # Respawn if they pressed jump while blocked
    if victim.respawnBuffered:
        victim.respawn()
    # Wait until max time before respawn
    wait(maxRespawnTime - minRespawnTime, Wait.RESTART_WHEN_TRUE)
    if victim.isDead():
        victim.respawn()

rule "If player attempts to respawn while blocked, mark them to respawn":
    @Event eachPlayer
    @Condition eventPlayer.isDead()
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
    if eventPlayer.respawnBlocked:
        eventPlayer.respawnBuffered = true
        return
    eventPlayer.respawn()

rule "Reset on Game Start (Waiting for Players)":
	@Event global
    @Condition isGameInProgress()
    # Stop all zone progress
    stopAllProgress()
    # Reset Zones
    triggerPointReset(false)
    # Reset Scores
    setTeamScore(Team.1, 0)
    setTeamScore(Team.2, 0)

rule "Upon earning a kill, award additional points for zones controlled":
	@Event playerDealtFinalBlow
    @Condition len([control for control in zoneControl if control == attacker.getTeam()]) >= 2
    # Award bonus points
    addToTeamScore(attacker.getTeam(), len([control for control in zoneControl if control == attacker.getTeam()]) - 1)
    # Mark as valid target for feedback
    victim.validElimTarget = true

rule "Provide feedback on valid elimination":
    @Event playerEarnedElimination
    @Condition victim.validElimTarget
    # Provide visual feedback for bonus points
    smallMessage(attacker, "+{} for Zone Control".format(len([control for control in zoneControl if control == attacker.getTeam()]) - 1))
    # Provide audio feedback for bonus points
    async(playElimSounds, AsyncBehavior.NOOP)

def playElimSounds():
    @Name "SUB: Play sounds for earning elims with zone advantage"
    switch len([control for control in zoneControl if control == attacker.getTeam()]):
        case 3:
            wait(0.5)
            playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
        default:
            wait(0.5)
            playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)

rule "Remove validElim marker":
    @Event eachPlayer
    @Condition eventPlayer.validElimTarget
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    eventPlayer.validElimTarget = false

rule "Declare Winner if a team has requisite number of points":
	@Event global
    @Condition isGameInProgress()
    # During overtime, teams do not necessarily need more than scoreToWin points, so we have a separate rule to handle overtime
    @Condition not overtime
    @Condition (teamScore(Team.1) >= scoreToWin or teamScore(Team.2) >= scoreToWin)
    @Condition teamScore(Team.1) != teamScore(Team.2)
    currScoreComp = teamScore(Team.1) - teamScore(Team.2)
    declareWinner()

rule "Regulation Time End Handler: Trigger Overtime or Declare Victory when regulation time runs out":
	@Event global
    @Condition isGameInProgress()
    @Condition getMatchTime() == 0
    @Condition not powerPlayActive
    @Condition not overtime
    # Cache result before buffer wait
    currScoreComp = teamScore(Team.1) - teamScore(Team.2)
    # Wait for two frames to alleviate potential race conditions
    wait(0.032, Wait.ABORT_WHEN_FALSE)
    # If teams are tied, initiate overtime (or declare draw if overtime not enabled)
    if currScoreComp == 0:
        if not overtimeEnabled:
            declareDraw()
            return
        setObjectiveDescription(getAllPlayers(), l"Overtime", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getAllPlayers(), l"Overtime")
        setMatchTime(0.032)
        overtime = true
        wait(0.016)
        pauseMatchTime()
    # Otherwise, declare a winner
    else:
        declareWinner()

rule "Maintain Overtime Music":
    @Event global
    @Condition isGameInProgress()
    @Condition overtime
    # The end-of-round music only lasts 30 seconds, so we must retrigger it every thirty seconds
    while overtime:
        wait(30, Wait.ABORT_WHEN_FALSE)
        setMatchTime(0)
        wait(0.016)
        setMatchTime(0.032)
        wait(0.016)
        pauseMatchTime()

rule "Overtime End Handler":
	@Event global
    @Condition overtime
    @Condition teamScore(Team.1) != teamScore(Team.2)
    declareWinner()

def declareWinner():
    @Name "SUB: Declare Winner | UPDATE currScoreComp BEFORE CALLING THIS SUBROUTINE"
    if currScoreComp == 0:
        return
    if currScoreComp > 0:
        # Allow adequate time to process end of game
        wait(0.5)
        declareTeamVictory(Team.1)
    else:
        # Allow adequate time to process end of game
        wait(0.5)
        declareTeamVictory(Team.2)

rule "# Keep track of number of people from one team on one zone per rule":
	@Event global
    @Disabled
    currScoreComp = false

generatePointFlags()

#!include "normalPointControl.opy"

rule "=====POWER PLAY=====":
	@Event global
	@Disabled
    currScoreComp = false

#!include "powerPlay.opy"

rule "=====DEBUG=====":
	@Event global
	@Disabled
	currScoreComp = false

#!include "debug.opy"
