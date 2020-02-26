#!disableUnusedVars

#Global variables

# Where are the zones?
#!declareGlobal zoneLocations
# How large are the zones? (radius)
#!declareGlobal zoneSizes
# Who controls the zone?
#!declareGlobal zoneControl
# How many members of Team 1 are on the zone?
#!declareGlobal numTeam1A
#!declareGlobal numTeam1B
#!declareGlobal numTeam1C
# How many members of Team 2 are on the zone?
#!declareGlobal numTeam2A
#!declareGlobal numTeam2B
#!declareGlobal numTeam2C
# Is the Hunt active?
#!declareGlobal huntActive
# How much time is left in the Hunt?
#!declareGlobal huntTimer
# Whether the Hunt can be activated
#!declareGlobal activateHunt
# How long the Hunt lasts for
#!declareGlobal huntDuration
# Whether Hunt Markers are enabled
#!declareGlobal huntMarkers

# Stores Zone active hud texts (0 = spec, 1 = Team 1, 2 = Team 2)
#!declareGlobal zoneAHudText
#!declareGlobal zoneBHudText
#!declareGlobal zoneCHudText
# Zone Visuals
#!declareGlobal zoneAVisuals
#!declareGlobal zoneBVisuals
#!declareGlobal zoneCVisuals
# Zone Progress
#!declareGlobal zoneAProgress
#!declareGlobal zoneBProgress
#!declareGlobal zoneCProgress
# Skull Markers (The Hunt)
#!declareGlobal skullIcons

# Helper pregen macros (thanks Zez)
#!define generatePointFlags() __script__('generateSetPointFlags.js')
#!define generateInitPointVisuals() __script__('generateInitialPointVisuals.js')
#!define generateChaserRules(point) __script__('generateChaserRules.js')
#!define generateVisualUpdates(point) __script__('generateVisualUpdates.js')
#!define initialize() __script__('initialize.js')
#!define stopAllProgress() __script__('stopAllProgress.js')
#!define generateLockedText() __script__('generateLockedText.js')
#!define triggerPointReset(destroyText) __script__('triggerPointReset.js')

#!define normalObjDesc "Fight and Capture Zones"

@Rule "=====CUSTOMIZATION====="
@Event global
@Disabled
return

@Rule "activateHunt: Set to True to activate The Hunt when a team caps all 3 points. Default: True"
@Event global
activateHunt = true

@Rule "huntDuration: How long The Hunt lasts for in seconds. Default: 25"
@Event global
huntDuration = 25

@Rule "huntMarkers: Whether the hunted have markers above their head during The Hunt. Default: True"
@Event global
huntMarkers = true

@Rule "=====SETUP====="
@Event global
@Disabled
return

@Rule "DEBUG: Show CPU"
@Event global
@Disabled
hudHeader(getAllPlayers(), "Server Load: {0}/{1}/{2}".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), Position.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

@Rule "DEBUG: Shorten assemble heroes"
@Event global
@Disabled
if isAssemblingHeroes():
    setMatchTime(10)

@Rule "Initialization"
@Event global
initialize()
huntActive = false

import "maps.opy"

@Rule "Once Zones are defined, create visuals"
@Event global
if len(zoneLocations) == 3 and len(zoneSizes) == 3:
    generateInitPointVisuals()

@Rule "=====GAMEPLAY====="
@Event global
@Disabled
return

@Rule "Disable Self Respawn for 5 seconds"
@Event playerDied
victim.disallowButton(Button.JUMP)
wait(5, Wait.IGNORE_CONDITION)
victim.allowButton(Button.JUMP)

@Rule "Reset on Game Start (Waiting for Players)"
@Event global
if isGameInProgress():
    stopAllProgress()
    triggerPointReset(false)
    setTeamScore(Team.1, 0)
    setTeamScore(Team.2, 0)
    wait(1, Wait.IGNORE_CONDITION)
    setObjectiveDescription(getAllPlayers(), normalObjDesc, HudReeval.VISIBILITY_AND_STRING)

@Rule "Upon earning a kill, award additional points for zones controlled"
@Event playerDealtFinalBlow
if len([control for control in zoneControl if control == attacker.getTeam()]) >= 2:
    addToTeamScore(attacker.getTeam(), len([control for control in zoneControl if control == attacker.getTeam()]) - 1)

@Rule "# Keep track of point flags"
@Event global
return

generatePointFlags()

import "normalPointControl.opy"

@Rule "=====THE HUNT====="
@Event global
@Disabled
return

import "theHunt.opy"