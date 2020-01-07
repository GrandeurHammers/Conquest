#!disableUnusedVars

#Global variables

#!declareGlobal zoneLocations
#!declareGlobal zoneSizes
#!declareGlobal zoneLetterMarkers
#!declareGlobal zoneControl
#!declareGlobal huntTimer
#!declareGlobal rebuildHud
#!declareGlobal rebuildOverrideFlag
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

#!define buildPointHud(point, state) __script__("hud-builder.js")


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
rebuildOverrideFlag[0] = false
rebuildOverrideFlag[1] = false
rebuildOverrideFlag[2] = false
zoneAVisuals = []
zoneBVisuals = []
zoneCVisuals = []


import "maps.opy"


@Rule "Create Info HUD 1"
@Event global
hudSubtext(getPlayers(Team.1), w"{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.1]), len([obj for obj in zoneControl if obj == Team.2])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
hudSubtext(getPlayers(Team.2), w"{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.2]), len([obj for obj in zoneControl if obj == Team.1])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
# Hunt Timer
hudHeader([p for p in getAllPlayers() if huntTimer > 0], "The Hunt: {}s".format(ceil(huntTimer)), Position.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
# Capture Progress HUDs
hudHeader([p for p in getPlayersInRadius(zoneLocations[0], zoneSizes[0], Team.ALL, LosCheck.OFF) if abs(zoneAProgress) > 0], "Progress: {}%".format(floor(abs(zoneAProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
hudHeader([p for p in getPlayersInRadius(zoneLocations[1], zoneSizes[1], Team.ALL, LosCheck.OFF) if abs(zoneBProgress) > 0], "Progress: {}%".format(floor(abs(zoneBProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
hudHeader([p for p in getPlayersInRadius(zoneLocations[2], zoneSizes[2], Team.ALL, LosCheck.OFF) if abs(zoneCProgress) > 0], "Progress: {}%".format(floor(abs(zoneCProgress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
# Spacers
hudSubtext(getAllPlayers(), w"-----------", Position.RIGHT, 1.5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
hudSubtext(getAllPlayers(), w"-----------", Position.RIGHT, 2.5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
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
# Zone A
# Team 1
hudText(getPlayers(Team.1), "Zone A", "Neutral: 0%", "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[1] = getLastCreatedText()
# Team 2
hudText(getPlayers(Team.2), "Zone A", "Neutral: 0%", "Capture Zone", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneAHudText[2] = getLastCreatedText()

# Zone B
# Team 1
hudText(getPlayers(Team.1), "Zone B", "Neutral: 0%", "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[1] = getLastCreatedText()
# Team 2
hudText(getPlayers(Team.2), "Zone B", "Neutral: 0%", "Capture Zone", Position.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneBHudText[2] = getLastCreatedText()

# Zone C
# Team 1
hudText(getPlayers(Team.1), "Zone C", "Neutral: 0%", "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[1] = getLastCreatedText()
# Team 2
hudText(getPlayers(Team.2), "Zone C", "Neutral: 0%", "Capture Zone", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
zoneCHudText[2] = getLastCreatedText()

@Rule "Once Zones are defined, create visuals"
@Event global
if len(zoneLocations) == 3 and len(zoneSizes) == 3:
    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneAProgress))), zoneLocations[0] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneAVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[0], zoneSizes[0], EffectReeval.VISIBILITY)
    zoneAVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "A", zoneLocations[0] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneAVisuals.append(getLastCreatedText())

    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneBProgress))), zoneLocations[1] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneBVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[1], zoneSizes[1], EffectReeval.VISIBILITY)
    zoneBVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "B", zoneLocations[1] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneBVisuals.append(getLastCreatedText())

    createInWorldText(getAllPlayers(), l"{}%".format(floor(abs(zoneCProgress))), zoneLocations[2] + 0.4 * Vector.UP, 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneCVisuals.append(getLastCreatedText())
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[2], zoneSizes[2], EffectReeval.VISIBILITY)
    zoneCVisuals.append(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "C", zoneLocations[2] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    zoneCVisuals.append(getLastCreatedText())


@Rule "=====GAMEPLAY====="
@Event global
return


@Rule "Reset Objectives and Team Score at start of game"
@Event global
if not isWaitingForPlayers():
    zoneControl[0] = null
    zoneControl[1] = null
    zoneControl[2] = null
    zoneAProgress = 0
    zoneBProgress = 0
    zoneCProgress = 0
    activeHudIndicies[0] = 0
    activeHudIndicies[1] = 0
    activeHudIndicies[2] = 0


@Rule "Change Objective Description at start of game"
@Event global
if isGameInProgress():
    wait(1, Wait.IGNORE_CONDITION)
    setObjectiveDescription(getAllPlayers(), "Fight and Capture Zones", HudReeval.VISIBILITY_AND_STRING)


@Rule "Award points based on zones captured on kill"
@Event playerDealtFinalBlow
addToTeamScore(attacker.getTeam(), max(1, len([obj for obj in zoneControl if obj == attacker.getTeam()])))

@Rule "If a team controls all 3 zones, activate the Hunt"
@Event global
if len([obj for obj in zoneControl if obj == Team.1]) == 3 or len([obj for obj in zoneControl if obj == Team.2]) == 3:
    stopChasingVariable(zoneAProgress)
    stopChasingVariable(zoneBProgress)
    stopChasingVariable(zoneCProgress)
    zoneAProgress = 0
    zoneBProgress = 0
    zoneCProgress = 0
    setSlowMotion(10)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[0], 200)
    if any([obj == Team.1 for obj in zoneControl]):
        activeHudIndicies[0] = 7
        activeHudIndicies[1] = 7
        activeHudIndicies[2] = 7
        bigMessage(getAllPlayers(), "{} IS ON THE HUNT".format(Team.1))
        setObjectiveDescription(getPlayers(Team.1), "The Hunt is On", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getPlayers(Team.1), "The Hunt is On")
        setObjectiveDescription(getPlayers(Team.2), "Survive the Hunt", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getPlayers(Team.2), "Survive the Hunt")
    else:
        activeHudIndicies[0] = 8
        activeHudIndicies[1] = 8
        activeHudIndicies[2] = 8
        bigMessage(getAllPlayers(), "{} IS ON THE HUNT".format(Team.2))
        setObjectiveDescription(getPlayers(Team.2), "The Hunt is On", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getPlayers(Team.2), "The Hunt is On")
        setObjectiveDescription(getPlayers(Team.1), "Survive the Hunt", HudReeval.VISIBILITY_AND_STRING)
        bigMessage(getPlayers(Team.1), "Survive the Hunt")
    huntTimer = 25
    wait(0.5)
    chase(huntTimer, 0, rate=1, ChaseReeval.NONE)
    setSlowMotion(100)


@Rule "Listen for end of Hunt"
@Event global
if huntTimer == 0:
    stopChasingVariable(huntTimer)
    bigMessage(getAllPlayers(), "The Hunt Has Ended")
    setObjectiveDescription(getAllPlayers(), "Fight and Capture Zones", HudReeval.VISIBILITY_AND_STRING)
    zoneControl[0] = null
    zoneControl[1] = null
    zoneControl[2] = null
    rebuildHud[0] = true
    rebuildHud[1] = true
    rebuildHud[2] = true


@Rule "Helper A: Rebuild HUD"
@Event global
if rebuildHud[0]:
    destroyHudText(zoneAHudText[0])
    destroyHudText(zoneAHudText[1])
    destroyHudText(zoneAHudText[2])
    switch activeHudIndicies[0]:
        case 0:
            hudText(getAllPlayers(), "Zone A", "Neutral: 0%", "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            zoneAHudText[0] = getLastCreatedText()
            zoneAHudText[1] = getLastCreatedText()
            zoneAHudText[2] = getLastCreatedText()
            break
        case 1:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.1, floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            zoneAHudText[0] = getLastCreatedText()
            hudText(getPlayers(Team.1), "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
            zoneAHudText[1] = getLastCreatedText()
            hudText(getPlayers(Team.2), "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
            zoneAHudText[2] = getLastCreatedText()
            break
        case 2:
            hudText(null, "Zone A", "{0}: {1}%".format(Team.2, floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            zoneAHudText[0] = getLastCreatedText()
            hudText(getPlayers(Team.1), "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
            zoneAHudText[1] = getLastCreatedText()
            hudText(getPlayers(Team.1), "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
            zoneAHudText[2] = getLastCreatedText()
            break
        case 3:
            hudText(null, "Zone A", "{0}: 0%".format(Team.2), "{}".format(Team.1), Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            zoneAHudText[0] = getLastCreatedText()
            hudText(getPlayers(Team.1), "Zone A", "Enemy: 0%", "Defend Zone", Position.RIGHT, 1, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
            zoneAHudText[1] = getLastCreatedText()
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
        case 7:
        case 8:
            return
    rebuildHud[0] = false


@Rule "Zone A Capturing (Uncaptured)"
@Event global
if zoneControl[0] == null and huntTimer == 0 and ((any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]))):
    if any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]):
        if zoneAProgress < 0:
            zoneAProgress = 0
            rebuildOverrideFlag[0] = true
        chase(zoneAProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
        hudText(getPlayers(Team.1), "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
        zoneAHudText[1] = getLastCreatedText()
        hudText(getPlayers(Team.2), "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
        zoneAHudText[2] = getLastCreatedText()
    else:
        if zoneAProgress > 0:
            zoneAProgress = 0
            rebuildOverrideFlag[0] = true
        chase(zoneAProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[0] = 2
        hudText(getPlayers(Team.1), "Zone A", "Enemy: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
        zoneAHudText[1] = getLastCreatedText()
        hudText(getPlayers(Team.2), "Zone A", "Ally: {}%".format(floor(abs(zoneAProgress))), "Unlocked", Position.RIGHT, 1, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
        zoneAHudText[2] = getLastCreatedText()
    rebuildHud[0] = true

@Rule "Zone A Capturing (Captured)"
@Event global
if zoneControl[0] != null and huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(getOppositeTeam(zoneControl[0]))]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(zoneControl[0])]):
    if zoneControl[0] == Team.1:
        goto lbl_3
    chase(zoneAProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 6
    goto lbl_4
    lbl_3:
    chase(zoneAProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    activeHudIndicies[0] = 4
    lbl_4:

@Rule "Zone A Contested"
@Event global
if huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]):
    stopChasingVariable(zoneAProgress)
    smallMessage([player for player in getAllPlayers() if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]], "Contested!")

@Rule "Zone A Uncapture Slow"
@Event global
if huntTimer == 0 and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.ALL)]):
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zoneAProgress, 0, rate=25, ChaseReeval.NONE)

@Rule "Zone A Instant Uncapture"
@Event global
if huntTimer == 0 and zoneControl[0] != null and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(zoneControl[0])]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(getOppositeTeam(zoneControl[0]))]):
    stopChasingVariable(zoneAProgress)
    zoneAProgress = 0


@Rule "Zone A Capture"
@Event global
if abs(zoneAProgress) == 100:
    stopChasingVariable(zoneAProgress)
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
    if huntTimer != 0:
        return
    switch zoneControl[0]:
        case null:
            if rebuildOverrideFlag[0]:
                rebuildOverrideFlag[0] = false
                break
            activeHudIndicies[0] = 0
            break
        case Team.1:
            activeHudIndicies[0] = 3
            break
        case Team.2:
            activeHudIndicies[0] = 5
            break
    rebuildHud[0] = true


@Rule "Helper B: Rebuild Spec HUD"
@Event global
if rebuildHud[1]:
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
        case 7:
        case 8:
            return
    zoneBHudText[0] = getLastCreatedText()
    rebuildHud[1] = false


@Rule "Zone B Capturing (Uncaptured)"
@Event global
if zoneControl[1] == null and huntTimer == 0 and ((any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]))):
    if any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]):
        if zoneBProgress < 0:
            zoneBProgress = 0
            rebuildOverrideFlag[1] = true
        chase(zoneBProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 1
    else:
        if zoneBProgress > 0:
            zoneBProgress = 0
            rebuildOverrideFlag[1] = true
        chase(zoneBProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 2
    rebuildHud[1] = true


@Rule "Zone B Capturing (Captured)"
@Event global
if zoneControl[1] != null and huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(getOppositeTeam(zoneControl[1]))]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(zoneControl[1])]):
    if zoneControl[1] == Team.2:
        chase(zoneBProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 6
    else:
        chase(zoneBProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[1] = 4


@Rule "Zone B Contested"
@Event global
if huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.2)]):
    stopChasingVariable(zoneBProgress)
    smallMessage([player for player in getAllPlayers() if distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1]], "Contested!")

@Rule "Zone B Uncapture Slow"
@Event global
if huntTimer == 0 and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(Team.ALL)]):
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zoneBProgress, 0, rate=25, ChaseReeval.NONE)

@Rule "Zone B Instant Uncapture"
@Event global
if huntTimer == 0 and zoneControl[1] != null and any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(zoneControl[1])]) and not any([distance(player.getPosition(), zoneLocations[1]) <= zoneSizes[1] for player in getLivingPlayers(getOppositeTeam(zoneControl[1]))]):
    stopChasingVariable(zoneBProgress)
    zoneBProgress = 0


@Rule "Zone B Capture"
@Event global
if abs(zoneBProgress) == 100:
    stopChasingVariable(zoneBProgress)
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
    if huntTimer != 0:
        return
    switch zoneControl[1]:
        case null:
            if rebuildOverrideFlag[1]:
                rebuildOverrideFlag[1] = false
                break
            activeHudIndicies[1] = 0
            break
        case Team.1:
            activeHudIndicies[1] = 3
            break
        case Team.2:
            activeHudIndicies[1] = 5
            break
    rebuildHud[1] = true

@Rule "Helper C: Rebuild Spec HUD"
@Event global
if rebuildHud[2]:
    destroyHudText(zoneCHudText[0])
    switch activeHudIndicies[2]:
        case 0:
            hudText(null, "Zone C", "Neutral: 0%", "Unlocked", Position.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 1:
            hudText(null, "Zone C", "{0}: {1}%".format(Team.1, floor(abs(zoneCProgress))), "Unlocked", Position.RIGHT, 3, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 2:
            hudText(null, "Zone C", "{0}: {1}%".format(Team.2, floor(abs(zoneCProgress))), "Unlocked", Position.RIGHT, 3, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 3:
            hudText(null, "Zone C", "{0}: 0%".format(Team.2), "{}".format(Team.1), Position.RIGHT, 3, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 4:
            hudText(null, "Zone C", "{0}: {1}%".format(Team.2, floor(abs(zoneCProgress))), "{}".format(Team.1), Position.RIGHT, 3, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 5:
            hudText(null, "Zone C", "{0}: 0%".format(Team.1), "{}".format(Team.2), Position.RIGHT, 3, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 6:
            hudText(null, "Zone C", "{0}: {1}%".format(Team.1, floor(abs(zoneCProgress))), "{}".format(Team.2), Position.RIGHT, 3, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            break
        case 7:
        case 8:
            return
    zoneCHudText[0] = getLastCreatedText()
    rebuildHud[2] = false


@Rule "Zone C Capturing (Uncaptured)"
@Event global
if zoneControl[2] == null and huntTimer == 0 and ((any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.1)]))):
    if any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.1)]):
        if zoneCProgress < 0:
            zoneCProgress = 0
            rebuildOverrideFlag[2] = true
        chase(zoneCProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[2] = 1
    else:
        if zoneCProgress > 0:
            zoneCProgress = 0
            rebuildOverrideFlag[2] = true
        chase(zoneCProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[2] = 2
    rebuildHud[2] = true

@Rule "Zone C Capturing (Captured)"
@Event global
if zoneControl[2] != null and huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(getOppositeTeam(zoneControl[2]))]) and not any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(zoneControl[2])]):
    if zoneControl[2] == Team.2:
        chase(zoneCProgress, 100, rate=5 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[2] = 6
    else:
        chase(zoneCProgress, -100, rate=5 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2]])), ChaseReeval.DESTINATION_AND_RATE)
        activeHudIndicies[2] = 4

@Rule "Zone C Contested"
@Event global
if huntTimer == 0 and any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.2)]):
    stopChasingVariable(zoneCProgress)
    smallMessage([player for player in getAllPlayers() if distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2]], "Contested!")

@Rule "Zone C Uncapture Slow"
@Event global
if huntTimer == 0 and not any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(Team.ALL)]):
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zoneCProgress, 0, rate=25, ChaseReeval.NONE)

@Rule "Zone C Instant Uncapture"
@Event global
if huntTimer == 0 and zoneControl[2] != null and any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(zoneControl[2])]) and not any([distance(player.getPosition(), zoneLocations[2]) <= zoneSizes[2] for player in getLivingPlayers(getOppositeTeam(zoneControl[2]))]):
    stopChasingVariable(zoneCProgress)
    zoneCProgress = 0


@Rule "Zone C Capture"
@Event global
if abs(zoneCProgress) == 100:
    stopChasingVariable(zoneCProgress)
    destroyEffect(zoneCVisuals[1])
    destroyInWorldText(zoneCVisuals[2])
    if zoneCProgress == 100:
        zoneControl[2] = Team.1
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, zoneLocations[2], 2 * zoneSizes[2])
        createEffect(getAllPlayers(), Effect.RING, Color.TEAM_1, zoneLocations[2], zoneSizes[2], EffectReeval.VISIBILITY)
        zoneCVisuals[1] = getLastCreatedEntity()
        createInWorldText(getAllPlayers(), "C", zoneLocations[2] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_1, SpecVisibility.ALWAYS)
        zoneCVisuals[2] = getLastCreatedText()
    else:
        zoneControl[2] = Team.2
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_2, zoneLocations[2], 2 * zoneSizes[2])
        createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, zoneLocations[2], zoneSizes[2], EffectReeval.VISIBILITY)
        zoneCVisuals[1] = getLastCreatedEntity()
        createInWorldText(getAllPlayers(), "C", zoneLocations[2] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TEAM_2, SpecVisibility.ALWAYS)
        zoneCVisuals[2] = getLastCreatedText()
    zoneCProgress = 0
    addToTeamScore(zoneControl[2], 1)
    smallMessage(getPlayers(zoneControl[2]), "Zone C Captured")
    smallMessage(getPlayers(getOppositeTeam(zoneControl[2])), "Zone C Lost")


@Rule "Listener for Zone C hitting 0%"
@Event global
if zoneCProgress == 0:
    if huntTimer != 0:
        return
    switch zoneControl[2]:
        case null:
            if rebuildOverrideFlag[2]:
                rebuildOverrideFlag[2] = false
                break
            activeHudIndicies[2] = 0
            break
        case Team.1:
            activeHudIndicies[2] = 3
            break
        case Team.2:
            activeHudIndicies[2] = 5
            break
    rebuildHud[2] = true
