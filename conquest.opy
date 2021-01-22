#Global variables

# How many points does a team need to win?
# In-game settings must be adjusted to properly display this value
# See CUSTOMIZATION rule
globalvar scoreToWin
# Minimum respawn time (secs)
globalvar minRespawnTime
# Maximum respawn time (secs)
globalvar maxRespawnTime
# Should regulation time ending early require a Power Play
globalvar endRequiresPowerPlay

# Where are the zones?
globalvar zoneLocations
# How large are the zones? (radius)
globalvar zoneSizes
# How tall are the zones? (height)
globalvar zoneHeights
# Where are the spawns corresponding to each zone?
globalvar zoneSpawns
# Remaining ticket spots for each area
globalvar team1SpawnTix
globalvar team2SpawnTix
# BUG WORKAROUND: Change HUD toggle for about-to-win
globalvar teamAboutToWin

#!define bugWorkaround() __script__('macros/tempBugWorkaround.js')

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
# Whether teams should swap sides after the next power play
globalvar swapSides
# How should player respawning behave? Options: Random, Static, Dynamic
globalvar spawnBehavior
# How should respawn timings behave? Options: STATIC, WAVES
globalvar spawnTimings
# Team 1's respawn wave timer
globalvar team1RespawnTimer
# Team 2's respawn wave timer
globalvar team2RespawnTimer

# Is Power Play active?
globalvar powerPlayActive
# How much time is left in Power Play?
globalvar powerPlayTimer
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

# Color controls
globalvar zoneAMainColor
globalvar zoneAAltColor
globalvar zoneBMainColor
globalvar zoneBAltColor
globalvar zoneCMainColor
globalvar zoneCAltColor

# Text IDs for spectators
globalvar specTextIds

# Zone Progress (100 = full cap for Team 1, -100 = full cap for Team 2)
globalvar zoneAProgress
globalvar zoneBProgress
globalvar zoneCProgress
# Skull Markers (Power Play)
globalvar skullIcons
# Current score comparison (<0 if team 1 < team 2, 0 if team 1 == team 2, >0 if team 1 > team 2)
globalvar currScoreComp

globalvar i
globalvar j

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
#!define generateZoneHud() __script__('macros/generateZoneHUD.js')
#!define generateHudUpdates(point) __script__('macros/generateHudUpdates.js')
#!define generateChaserRules(point) __script__('macros/generateChaserRules.js')
#!define initializeHelper() __script__('macros/initialize.js')
#!define stopAllProgress() __script__('macros/stopAllProgress.js')
#!define triggerPointReset() __script__('macros/triggerPointReset.js')
#!define toggleSkulls(create) __script__('macros/toggleSkullIcons.js')
#!define generatePlayerHUDSpacer() __script__('macros/generatePlayerHUDSpacer.js')
#!define generatePlayerHUD() __script__('macros/generatePlayerHUD.js')
#!define generateSpecHUD() __script__('macros/generateSpecHUD.js')

#!define getUnusedSpawn() 3 - currTeamSpawns[0] - currTeamSpawns[1]
#!define isMapInitialized() (len(zoneLocations) == 3 and len(zoneSizes) == 3)
#!define isWithinZoneBounds(player, zoneIndex) distance(vect(player.getPosition().x, zoneLocations[zoneIndex].y, player.getPosition().z), zoneLocations[zoneIndex]) < zoneSizes[zoneIndex] and player.getPosition().y - zoneLocations[zoneIndex].y >= -1 and player.getPosition().y - zoneLocations[zoneIndex].y < zoneHeights[zoneIndex]

settings "settings.opy.json"

enum RespawnLocations:
    RANDOM,
    STATIC,
    DYNAMIC

enum RespawnTimings:
    STATIC,
    WAVES

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
    # We use custom scoring
    disableScoring()
    initializeHelper()
    # Push player-specific HUD down to crosshair level
    generatePlayerHUDSpacer()
    powerPlayActive = false

bugWorkaround()

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

generateSpecHUD()

#!include "maps/maps.opy"

rule "If the map is not intialized, create a warning HUD":
    @Condition not isMapInitialized()

    hudHeader(getAllPlayers(), "ERROR: THIS MAP IS NOT YET SUPPORTED", HudPosition.TOP, -1, Color.RED, HudReeval.VISIBILITY, SpecVisibility.ALWAYS)

rule "Generate zone visuals and HUD":
	@Event global
	@Condition isMapInitialized()
    generateInitPointVisuals()
    generateZoneHud()

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
