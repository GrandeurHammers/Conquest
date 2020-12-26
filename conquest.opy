#Global variables

# How many points does a team need to win?
# In-game settings must be adjusted to properly display this value
# See CUSTOMIZATION rule
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
# Where are the spawns corresponding to each zone?
globalvar zoneSpawns
# What is the radius of each spawn area?
globalvar zoneSpawnRadii

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
# Where does each team spawn? Index 0 for Team 1, Index 1 for Team 2 (0 = Zone A, 1 = Zone B, 2 = Zone C)
globalvar currTeamSpawns
# Whether shifting spawns are enabled
globalvar shiftSpawns
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
# Zone Progress (100 = full cap for Team 1, -100 = full cap for Team 2)
globalvar zoneAProgress
globalvar zoneBProgress
globalvar zoneCProgress
# Skull Markers (Power Play)
globalvar skullIcons
# Current score comparison (<0 if team 1 < team 2, 0 if team 1 == team 2, >0 if team 1 > team 2)
globalvar currScoreComp
# Array of booleans that control whether the main or alternate color is shown
globalvar altColorControl
# Array of booleans that determine whether a zone should flash alt colors
globalvar altColorLoop

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
#!define generatePointFlags() __script__('macros/generateSetPointFlags.js')
#!define generateInitPointVisuals() __script__('macros/generateInitialPointVisuals.js')
#!define generateChaserRules(point) __script__('macros/generateChaserRules.js')
#!define generateVisualUpdates(point) __script__('macros/generateVisualUpdates.js')
#!define initializeHelper() __script__('macros/initialize.js')
#!define stopAllProgress() __script__('macros/stopAllProgress.js')
#!define generateLockedText() __script__('macros/generateLockedText.js')
#!define triggerPointReset(destroyText) __script__('macros/triggerPointReset.js')
#!define toggleSkulls(create) __script__('macros/toggleSkullIcons.js')
#!define generatePlayerHUDSpacer() __script__('macros/generatePlayerHUDSpacer.js')
#!define generatePlayerHUD() __script__('macros/generatePlayerHUD.js')
#!define colorFlashControl(point) __script__('macros/colorFlashControl.js')

#!define getUnusedSpawn() 3 - currTeamSpawns[0] - currTeamSpawns[1]
#!define isMapInitialized() len(zoneLocations) == 3 and len(zoneSizes) == 3
#!define isWithinZoneBounds(player, zoneIndex) distance(vect(player.getPosition().x, zoneLocations[zoneIndex].y, player.getPosition().z), zoneLocations[zoneIndex]) < zoneSizes[zoneIndex] and player.getPosition().y - zoneLocations[zoneIndex].y >= -1 and player.getPosition().y - zoneLocations[zoneIndex].y < zoneHeights[zoneIndex]

settings "settings.opy.json"

rule "=====CUSTOMIZATION=====":
	@Event global
    @Disabled
    @Delimiter

#!include "customize.opy"

rule "=====SETUP=====":
	@Event global
	@Disabled
    @Delimiter

rule "Global Initialization - includes center zone HUD elements":
    @Event global
    # Mostly for debugging purposes
    if not createWorkshopSetting(bool, "Debug", "Inspector Enabled", false):
        disableInspector()
    # Log which map is being played
    printLog("Current Map: {0}".format(getCurrentMap()))
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

#!include "maps/maps.opy"

rule "Generate initial in-world zone visuals":
	@Event global
	@Condition isMapInitialized()
    generateInitPointVisuals()

rule "=====GAMEPLAY=====":
	@Event global
	@Disabled
    @Delimiter

#!include "businessLogic.opy"

rule "Prevent assemble heroes from getting out of sync":
    @Condition isAssemblingHeroes()
    do:
        setMatchTime(getMatchTime())
        waitUntil(not isAssemblingHeroes(), 1)
    while RULE_CONDITION

rule "# Keep track of number of people from one team on one zone per rule":
	@Event global
    @Disabled
    @Delimiter

generatePointFlags()

#!include "normalPointControl.opy"

rule "=====POWER PLAY=====":
	@Event global
	@Disabled
    @Delimiter

#!include "powerPlay.opy"

rule "=====DEBUG=====":
	@Event global
	@Disabled
	@Delimiter

#!include "debug.opy"
