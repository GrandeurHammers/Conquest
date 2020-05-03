#!disableUnusedVars

#Global variables

# How many points does a team need to win?
# In-game settings must be adjusted to properly display this value
# See CUSTOMIZAION rule
globalvar scoreToWin
# Where are the zones?
globalvar zoneLocations
# How large are the zones? (radius)
globalvar zoneSizes
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
# Is the Hunt active?
globalvar huntActive
# How much time is left in the Hunt?
globalvar huntTimer
# Whether the Hunt can be activated
globalvar activateHunt
# How long the Hunt lasts for
globalvar huntDuration
# Whether Hunt Markers are enabled
globalvar huntMarkers
# Is Overtime in effect?
globalvar overtime

# Stores Zone active hud texts (0 = spec, 1 = Team 1, 2 = Team 2, 3 = Capturing/Contested string)
globalvar zoneAHudText
globalvar zoneBHudText
globalvar zoneCHudText
# Zone Visuals
globalvar zoneAVisuals
globalvar zoneBVisuals
globalvar zoneCVisuals
# Zone Progress
globalvar zoneAProgress
globalvar zoneBProgress
globalvar zoneCProgress
# Skull Markers (The Hunt)
globalvar skullIcons

subroutine declareWinner

# Helper pregen macros (thanks Zez)
#!define generatePointFlags() __script__('generateSetPointFlags.js')
#!define generateInitPointVisuals() __script__('generateInitialPointVisuals.js')
#!define generateChaserRules(point) __script__('generateChaserRules.js')
#!define generateVisualUpdates(point) __script__('generateVisualUpdates.js')
#!define initialize() __script__('initialize.js')
#!define stopAllProgress() __script__('stopAllProgress.js')
#!define generateLockedText() __script__('generateLockedText.js')
#!define triggerPointReset(destroyText) __script__('triggerPointReset.js')
#!define toggleSkulls(create) __script__('toggleSkullIcons.js')
#!define progressBar(zoneProgVar, len) __script__('progressBarHelper.js')


rule "=====CUSTOMIZATION=====":
	@Event global
	@Disabled
    return

rule "activateHunt: Set to True to activate The Hunt when a team caps all 3 points. Default: True":
	@Event global
    activateHunt = true

rule "huntDuration: How long The Hunt lasts for in seconds. Default: 25":
	@Event global
    huntDuration = 25

rule "huntMarkers: Whether the hunted have markers above their head during The Hunt. Default: True":
	@Event global
    huntMarkers = true

rule "scoreToWin: How many points a team must score to win. Default: 100":
	@Event global
    # This does not automatically update the in-game scoreboard. In order for the scoreboard to display properly, the host must change "Settings > Modes > Score to Win" to match this value.
    scoreToWin = 100

rule "=====SETUP=====":
	@Event global
	@Disabled
    return

rule "Initialization":
	@Event global
    disableInspector()
    disableGamemodeCompletion()
    initialize()
    huntActive = false

#!include "maps.opy"

rule "Once Zones are defined, create visuals":
	@Event global
	@Condition len(zoneLocations) == 3 and len(zoneSizes) == 3
    generateInitPointVisuals()

rule "=====GAMEPLAY=====":
	@Event global
	@Disabled
    return

rule "Disable Self Respawn for 5 seconds":
	@Event playerDied
    victim.disallowButton(Button.JUMP)
    wait(5, Wait.IGNORE_CONDITION)
    victim.allowButton(Button.JUMP)

rule "Reset on Game Start (Waiting for Players)":
	@Event global
	@Condition isGameInProgress()
    stopAllProgress()
    triggerPointReset(false)
    setTeamScore(Team.1, 0)
    setTeamScore(Team.2, 0)

rule "Upon earning a kill, award additional points for zones controlled":
	@Event playerDealtFinalBlow
	@Condition len([control for control in zoneControl if control == attacker.getTeam()]) >= 2
    addToTeamScore(attacker.getTeam(), len([control for control in zoneControl if control == attacker.getTeam()]) - 1)
    smallMessage(attacker, "+{} for Zone Control".format(len([control for control in zoneControl if control == attacker.getTeam()]) - 1))

rule "Declare Winner if a team has requisite number of points":
	@Event global
	@Condition isGameInProgress() and not overtime and (teamScore(Team.1) >= scoreToWin or teamScore(Team.2) >= scoreToWin) and teamScore(Team.1) != teamScore(Team.2)
    declareWinner()

rule "Game End Handler: Trigger Overtime or Declare Victory":
	@Event global
	@Condition isGameInProgress() and getMatchTime() == 0
    if teamScore(Team.1) == teamScore(Team.2):
        setObjectiveDescription(getAllPlayers(), l"Overtime", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getAllPlayers(), "Overtime")
        setMatchTime(0.032)
        overtime = true
        wait(0.016)
        pauseMatchTime()
    else:
        declareWinner()

rule "Overtime End Handler":
	@Event global
	@Condition overtime and teamScore(Team.1) != teamScore(Team.2)
    declareWinner()

def declareWinner():
    @Name "SUB: Declare Winner"
    if teamScore(Team.1) == teamScore(Team.2):
        return
    if teamScore(Team.1) > teamScore(Team.2):
        declareTeamVictory(Team.1)
    else:
        declareTeamVictory(Team.2)

rule "# Keep track of point flags":
	@Event global
	@Disabled
    return

generatePointFlags()

#!include "normalPointControl.opy"

rule "=====THE HUNT=====":
	@Event global
	@Disabled
    return

#!include "theHunt.opy"

#!include "debug.opy"
