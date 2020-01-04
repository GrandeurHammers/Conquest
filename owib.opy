#!disableUnusedVars

#Global variables

#!declareGlobal zoneLocations
#!declareGlobal zoneSizes
#!declareGlobal zoneLetterMarkers
#!declareGlobal zoneControl
#!declareGlobal huntTimer
#!declareGlobal rebuildSpecHud
# activeHudIndicies[spec/Team A/Team B][Zone A/Zone B/Zone C]
#!declareGlobal activeHudIndicies
# Progress: (0,100] = Team 1, [-100, 0) = Team 2
#!declareGlobal zoneAProgress
#!declareGlobal zoneBProgress
#!declareGlobal zoneCProgress
#!declareGlobal zoneAVisuals
#!declareGlobal zoneBVisuals
#!declareGlobal zoneCVisuals
#!declareGlobal zoneAHudText
#!declareGlobal zoneBHudText
#!declareGlobal zoneCHudText


@Rule "=====SETUP====="
@Event global
return


"""@Rule "DEV: Create Coord Hud"
@Event eachPlayer
hudHeader(eventPlayer, "X: {0} | Y: {1} | Z: {2}".format(eventPlayer.getPosition().x, eventPlayer.getPosition().y, eventPlayer.getPosition().z), Position.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
"""


@Rule "Mode and Variable Setup"
@Event global
disableScoring()
zoneControl[0] = null
zoneControl[1] = null
zoneControl[2] = null


@Rule "Setup Zones: Lijang Tower"
@Event global
if (getCurrentMap() == Map.LIJIANG_CONTROL_CENTER or getCurrentMap() == Map.LIJIANG_GARDEN or getCurrentMap() == Map.LIJIANG_NIGHT_MARKET or getCurrentMap() == Map.LIJIANG_CONTROL_CENTER_LNY or getCurrentMap() == Map.LIJIANG_GARDEN_LNY or getCurrentMap() == Map.LIJIANG_NIGHT_MARKET_LNY):
    switch getCurrentMap():
        # FIXME: Change Control Center points
        case Map.LIJIANG_CONTROL_CENTER:
        case Map.LIJIANG_CONTROL_CENTER_LNY:
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            return
        case Map.LIJIANG_GARDEN:
        case Map.LIJIANG_GARDEN_LNY:
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            return
        # FIXME: Change Night Market points
        case Map.LIJIANG_NIGHT_MARKET:
        case Map.LIJIANG_NIGHT_MARKET_LNY:
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            return

# TODO: Add more maps

@Rule "Create Info HUD 1"
@Event global
hudSubtext(getPlayers(Team.1), w"{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.1]), len([obj for obj in zoneControl if obj == Team.2])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
hudSubtext(getPlayers(Team.2), w"{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.2]), len([obj for obj in zoneControl if obj == Team.1])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
# Spacers
hudSubtext(getAllPlayers(), w"-------", Position.RIGHT, 1.5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
hudSubtext(getAllPlayers(), w"-------", Position.RIGHT, 2.5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
# Spectator: Create Original Hud
activeHudIndicies[0] = 0
activeHudIndicies[1] = 0
activeHudIndicies[2] = 0
hudText(null, "Zone A", "Neutral: 0%", "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
zoneAHudText[0] = getLastCreatedText()
hudText(null, "Zone B", "Neutral: 0%", "Unlocked", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
zoneBHudText[0] = getLastCreatedText()
hudText(null, "Zone C", "Neutral: 0%", "Unlocked", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
zoneCHudText[0] = getLastCreatedText()
# Team 1
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 0], "Zone A", "Neutral: 0%", "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[1] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 1], "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[2] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 2], "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[3] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 3], "Zone A", "Enemy: 0%", "Defend Zone", Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[4] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 4], "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Defend Zone", Position.RIGHT, 1, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[5] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 5], "Zone A", "Ally: 0%", "Capture Zone", Position.RIGHT, 1, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[6] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[0] == 6], "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[7] = getLastCreatedText()
# Team 2
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 0], "Zone A", "Neutral: 0%", "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[8] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 1], "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[9] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 2], "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[10] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 3], "Zone A", "Ally: 0%", "Capture Zone", Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[11] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 4], "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Capture Zone", Position.RIGHT, 1, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[12] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 5], "Zone A", "Enemy: 0%", "Defend Zone", Position.RIGHT, 1, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[13] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[0] == 6], "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Defend Zone", Position.RIGHT, 1, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[14] = getLastCreatedText()

@Rule "Create Info HUD 2"
@Event global
# Team 1
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 0], "Zone B", "Neutral: 0%", "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[1] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 1], "Zone B", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[2] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 2], "Zone B", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[3] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 3], "Zone B", "Enemy: 0%", "Defend Zone", Position.RIGHT, 2, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[4] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 4], "Zone B", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Defend Zone", Position.RIGHT, 2, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[5] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 5], "Zone B", "Ally: 0%", "Capture Zone", Position.RIGHT, 2, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[6] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[1] == 6], "Zone B", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[7] = getLastCreatedText()
# Team 2
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 0], "Zone B", "Neutral: 0%", "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[8] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 1], "Zone B", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[9] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 2], "Zone B", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[10] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 3], "Zone B", "Ally: 0%", "Capture Zone", Position.RIGHT, 2, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[11] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 4], "Zone B", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 2, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[12] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 5], "Zone B", "Enemy: 0%", "Defend Zone", Position.RIGHT, 2, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[13] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[1] == 6], "Zone B", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Defend Zone", Position.RIGHT, 2, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[14] = getLastCreatedText()

@Rule "Create Info HUD 3"
@Event global
# Team 1
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 0], "Zone C", "Neutral: 0%", "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[1] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 1], "Zone C", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[2] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 2], "Zone C", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[3] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 3], "Zone C", "Enemy: 0%", "Defend Zone", Position.RIGHT, 3, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[4] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 4], "Zone C", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Defend Zone", Position.RIGHT, 3, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[5] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 5], "Zone C", "Ally: 0%", "Capture Zone", Position.RIGHT, 3, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[6] = getLastCreatedText()
hudText([p for p in getPlayers(Team.1) if activeHudIndicies[2] == 6], "Zone C", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[7] = getLastCreatedText()
# Team 2
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 0], "Zone C", "Neutral: 0%", "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[8] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 1], "Zone C", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[9] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 2], "Zone C", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[10] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 3], "Zone C", "Ally: 0%", "Capture Zone", Position.RIGHT, 3, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[11] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 4], "Zone C", "Ally: {}%".format(floor(abs(zoneBProgress))), "Capture Zone", Position.RIGHT, 3, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[12] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 5], "Zone C", "Enemy: 0%", "Defend Zone", Position.RIGHT, 3, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[13] = getLastCreatedText()
hudText([p for p in getPlayers(Team.2) if activeHudIndicies[2] == 6], "Zone C", "Enemy: {}%".format(floor(abs(zoneBProgress))), "Defend Zone", Position.RIGHT, 3, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[14] = getLastCreatedText()

@Rule "Once Zones are defined, create visuals"
@Event global
if len(zoneLocations) == 3 and len(zoneSizes) == 3:
    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneAProgress))), zoneLocations[0] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneAVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[0], zoneSizes[0], EffectReeval.VISIBILITY)
    zoneAVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "A", zoneLocations[0] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneLetterMarkers.append(getLastCreatedText())

    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneBProgress))), zoneLocations[1] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneBVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[1], zoneSizes[1], EffectReeval.VISIBILITY)
    zoneBVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "B", zoneLocations[1] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneLetterMarkers.append(getLastCreatedText())

    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneCProgress))), zoneLocations[2] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneCVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[2], zoneSizes[2], EffectReeval.VISIBILITY)
    zoneCVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "C", zoneLocations[2] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneLetterMarkers.append(getLastCreatedText())


@Rule "=====GAMEPLAY====="
@Event global
return


@Rule "Change Objective Description at start of game"
@Event global
if isGameInProgress():
    setObjectiveDescription(getAllPlayers(), "Capture Zones", HudReeval.VISIBILITY_AND_STRING)


@Rule "Award points based on zones captured on kill"
@Event playerDealtFinalBlow
addToTeamScore(attacker.getTeam(), max(1, len([obj for obj in zoneControl if obj == attacker.getTeam()])))

@Rule "If a team controls all 3 zones, activate the Hunt"
@Event global
if len([obj for obj in zoneControl if obj == Team.1]) == 3 or len([obj for obj in zoneControl if obj == Team.2]) == 3:
    zoneAProgress = 0
    zoneBProgress = 0
    zoneCProgress = 0
    if any([obj == Team.2 for obj in zoneControl]):
        goto hunt_1
    huntTimer = 25
    chase(huntTimer, 0, rate=1, ChaseReeval.NONE)
    hunt_1:
    rebuildSpecHud[0] = true
    rebuildSpecHud[1] = true
    rebuildSpecHud[2] = true


@Rule "Helper A: Rebuild Spec HUD"
@Event global
if rebuildSpecHud[0]:
    destroyHudText(zoneAHudText[0])
    switch activeHudIndicies[0]:
        case 0:
            hudText(null, "Zone A", "Neutral: 0%", "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 1:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.1, floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 2:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.2, floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 3:
            hudText(null, "Zone A", "{0}: 0%".format(Team.2), "{}".format(Team.1), Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 4:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.2, floor(abs(zoneAProgress))), "{}".format(Team.1), Position.RIGHT, 1, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 5:
            hudText(null, "Zone A", "{0}: 0%".format(Team.1), "{}".format(Team.2), Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 6:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.1, floor(abs(zoneAProgress))), "{}".format(Team.2), Position.RIGHT, 1, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
    zoneAHudText[0] = getLastCreatedText()
    rebuildSpecHud[0] = false


@Rule "Zone A Capturing (Uncaptured)"
@Event global
if zoneControl[0] == null and huntTimer == 0 and ((any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]))):
    zoneAProgress = 0
    if any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]):
        goto lbl_1
    chase(zoneAProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 1
    goto lbl_2
    lbl_1:
    chase(zoneAProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 2
    lbl_2:
    rebuildSpecHud[0] = true

@Rule "Zone A Capturing (Captured)"
@Event global
if zoneControl[0] != null and huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(getOppositeTeam(zoneControl[0]))]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(zoneControl[0])]):
    if zoneControl[0] == Team.1:
        goto lbl_3
    chase(zoneAProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 6
    goto lbl_4
    lbl_3:
    chase(zoneAProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 4
    lbl_4:

@Rule "Zone A Contested"
@Event global
if huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]):
    stopChasingVariable(zoneAProgress)
    smallMessage([player for player in getAllPlayers() if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]], "Contested!")

@Rule "Zone A Uncapture Slow"
@Event global
if not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.ALL)]):
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zoneAProgress, 0, rate=25, ChaseReeval.NONE)

@Rule "Zone A Instant Uncapture"
@Event global
if zoneControl[0] != null and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(zoneControl[0])]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(getOppositeTeam(zoneControl[0]))]):
    stopChasingVariable(zoneAProgress)
    zoneAProgress = 0


@Rule "Zone A Capture"
@Event global
if abs(zoneAProgress) == 100:
    destroyEffect(zoneAVisuals[1])
    destroyInWorldText(zoneAVisuals[2])
    if zoneAProgress == -100:
        goto lbl_5
    zoneControl[0] = Team.1
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, zoneLocations[0], 2 * zoneSizes[0])
    createEffect(getAllPlayers(), Effect.RING, Color.TEAM_1, zoneLocations[0], zoneSizes[0], EffectReeval.VISIBILITY)
    zoneAVisuals[1] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), "A", zoneLocations[0] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_1, SpecVisibility.ALWAYS)
    zoneAVisuals[2] = getLastCreatedText()
    goto lbl_6
    lbl_5:
    zoneControl[0] = Team.2
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_2, zoneLocations[0], 2 * zoneSizes[0])
    createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, zoneLocations[0], zoneSizes[0], EffectReeval.VISIBILITY)
    zoneAVisuals[1] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), "A", zoneLocations[0] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_2, SpecVisibility.ALWAYS)
    zoneAVisuals[2] = getLastCreatedText()
    lbl_6:
    zoneAProgress = 0
    addToTeamScore(zoneControl[0], 1)
    smallMessage(getPlayers(zoneControl[0]), "Zone A Captured")
    smallMessage(getPlayers(getOppositeTeam(zoneControl[0])), "Zone A Lost")


@Rule "Listener for Zone A hitting 0%"
@Event global
if zoneAProgress == 0:
    switch zoneControl[0]:
        case null:
            activeHudIndicies[0] = 0
            break
        case Team.1:
            activeHudIndicies[0] = 3
            break
        case Team.2:
            activeHudIndicies[0] = 5
            break
    rebuildSpecHud[0] = true


@Rule "Helper B: Rebuild Spec HUD"
@Event global
if rebuildSpecHud[1]:
    destroyHudText(zoneBHudText[0])
    switch activeHudIndicies[1]:
        case 0:
            hudText(null, "Zone B", "Neutral: 0%", "Unlocked", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 1:
            hudText(null, "Zone B", "{0}: {1}%".format(Team.1, floor(abs(zoneBProgress))), "Unlocked", Position.RIGHT, 2, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 2:
            hudText(null, "Zone B", "{0}: {1}%".format(Team.2, floor(abs(zoneBProgress))), "Unlocked", Position.RIGHT, 2, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 3:
            hudText(null, "Zone B", "{0}: 0%".format(Team.2), "{}".format(Team.1), Position.RIGHT, 2, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 4:
            hudText(null, "Zone B", "{0}: {1}%".format(Team.2, floor(abs(zoneBProgress))), "{}".format(Team.1), Position.RIGHT, 2, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 5:
            hudText(null, "Zone B", "{0}: 0%".format(Team.1), "{}".format(Team.2), Position.RIGHT, 2, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 6:
            hudText(null, "Zone B", "{0}: {1}%".format(Team.1, floor(abs(zoneBProgress))), "{}".format(Team.2), Position.RIGHT, 2, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
    zoneBHudText[0] = getLastCreatedText()
    rebuildSpecHud[1] = false


@Rule "Zone B Capturing (Uncaptured)"
@Event global
if zoneControl[1] == null and huntTimer == 0 and ((any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]))):
    zoneBProgress = 0
    if any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]):
        chase(zoneBProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 1
    else:
        chase(zoneBProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 2
    rebuildSpecHud[1] = true

@Rule "Zone B Capturing (Captured)"
@Event global
if zoneControl[1] != null and huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(getOppositeTeam(zoneControl[1]))]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(zoneControl[1])]):
    if zoneControl[1] == Team.2:
        chase(zoneBProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 6
    else:
        chase(zoneBProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 4

@Rule "Zone B Contested"
@Event global
if huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)]):
    stopChasingVariable(zoneBProgress)
    smallMessage([player for player in getAllPlayers() if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]], "Contested!")

@Rule "Zone B Uncapture Slow"
@Event global
if not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.ALL)]):
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zoneBProgress, 0, rate=25, ChaseReeval.NONE)

@Rule "Zone B Instant Uncapture"
@Event global
if zoneControl[1] != null and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(zoneControl[1])]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(getOppositeTeam(zoneControl[1]))]):
    stopChasingVariable(zoneBProgress)
    zoneBProgress = 0


@Rule "Zone B Capture"
@Event global
if abs(zoneBProgress) == 100:
    destroyEffect(zoneBVisuals[1])
    destroyInWorldText(zoneBVisuals[2])
    if zoneBProgress == 100:
        zoneControl[1] = Team.1
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, zoneLocations[1], 2 * zoneSizes[1])
        createEffect(getAllPlayers(), Effect.RING, Color.TEAM_1, zoneLocations[1], zoneSizes[1], EffectReeval.VISIBILITY)
        zoneBVisuals[1] = getLastCreatedEntity()
        createInWorldText(getAllPlayers(), "B", zoneLocations[1] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_1, SpecVisibility.ALWAYS)
        zoneBVisuals[2] = getLastCreatedText()
    else:
        zoneControl[1] = Team.2
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_2, zoneLocations[1], 2 * zoneSizes[1])
        createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, zoneLocations[1], zoneSizes[1], EffectReeval.VISIBILITY)
        zoneBVisuals[1] = getLastCreatedEntity()
        createInWorldText(getAllPlayers(), "B", zoneLocations[1] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_2, SpecVisibility.ALWAYS)
        zoneBVisuals[2] = getLastCreatedText()
    zoneBProgress = 0
    addToTeamScore(zoneControl[1], 1)
    smallMessage(getPlayers(zoneControl[1]), "Zone B Captured")
    smallMessage(getPlayers(getOppositeTeam(zoneControl[1])), "Zone B Lost")


@Rule "Listener for Zone B hitting 0%"
@Event global
if zoneBProgress == 0:
    switch zoneControl[1]:
        case null:
            activeHudIndicies[1] = 0
            break
        case Team.1:
            activeHudIndicies[1] = 3
            break
        case Team.2:
            activeHudIndicies[1] = 5
            break
    rebuildSpecHud[1] = true