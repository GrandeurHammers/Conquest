#!disableUnusedVars

#Global variables

# Where are the zones?
#!declareGlobal zoneLocations
# How large are the zones? (radius)
#!declareGlobal zoneSizes
# Who controls the zone?
#!declareGlobal zoneControl
# Is Team 1 on the zone?
#!declareGlobal isTeam1
# Is Team 2 on the zone?
#!declareGlobal isTeam2
# How much time is left in the Hunt?
#!declareGlobal huntTimer
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

# Helper pregen macros (thanks Zez)
#!define generatePointFlags() __script__('generateSetPointFlags.js')
#!define generateInitPointVisuals() __script__('generateInitialPointVisuals.js')
#!define generateChaserRules(point) __script__('generateChaserRules.js')
#!define generateVisualUpdates(point) __script__('generateVisualUpdates.js')
#!define generateInitialHUD() __script__('generateInitialHUD.js')


@Rule "=====SETUP====="
@Event global
return

@Rule "Initialization"
@Event global
# TODO: Initialize variables
# Capture Progress HUDs
hudHeader([p for p in getPlayersInRadius(zoneLocations[0], zoneSizes[0], Team.ALL, LosCheck.OFF) if abs(zoneAProgress) > 0], "Progress: {}%".format(floor(abs(zoneAProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
hudHeader([p for p in getPlayersInRadius(zoneLocations[1], zoneSizes[1], Team.ALL, LosCheck.OFF) if abs(zoneBProgress) > 0], "Progress: {}%".format(floor(abs(zoneBProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
hudHeader([p for p in getPlayersInRadius(zoneLocations[2], zoneSizes[2], Team.ALL, LosCheck.OFF) if abs(zoneCProgress) > 0], "Progress: {}%".format(floor(abs(zoneCProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

import "maps.opy"

@Rule "Once Zones are defined, create visuals"
@Event global
if len(zoneLocations) == 3 and len(zoneSizes) == 3:
    generateInitPointVisuals()

@Rule "=====GAMEPLAY====="
@Event global
return

@Rule "# Keep track of point flags"
@Event global
return

generatePointFlags()

import "normalPointControl.opy"