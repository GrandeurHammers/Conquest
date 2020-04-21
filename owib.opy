#!disableUnusedVars

#Global variables

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

# Stores Zone active hud texts (0 = spec, 1 = Team 1, 2 = Team 2)
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
hudSubtext(getAllPlayers(), "Server Load: {0}".format(getServerLoad()), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
hudSubtext(getAllPlayers(), "Server Avg: {0}".format(getAverageServerLoad()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
hudSubtext(getAllPlayers(), "Server Peak: {0}".format(getPeakServerLoad()), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

@Rule "DEBUG: Show Player Position"
@Event eachPlayer
hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.LEFT, -1, Color.YELLOW, HudReeval.STRING, SpecVisibility.NEVER)

@Rule "DEBUG: Shorten assemble heroes"
@Event global
@Disabled
if isAssemblingHeroes():
    setMatchTime(10)

@Rule "Initialization"
@Event global
initialize()
huntActive = false
disableInspector()

#!include "maps.opy"

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

#!include "normalPointControl.opy"

@Rule "=====THE HUNT====="
@Event global
@Disabled
return

#!include "theHunt.opy"