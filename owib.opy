#!disableUnusedVars

#Global variables

#!declareGlobal zoneLocations
#!declareGlobal zoneSizes
# Progress: (0,100] = Team 1, [-100, 0) = Team 2
#!declareGlobal zoneAProgress
#!declareGlobal zoneBProgress
#!declareGlobal zoneCProgress
#!declareGlobal zoneControl
#!declareGlobal zoneAVisuals
#!declareGlobal zoneBVisuals
#!declareGlobal zoneCVisuals
#!declareGlobal zoneLetterMarkers
#!declareGlobal zoneHudText


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
    if getCurrentMap() != Map.LIJIANG_GARDEN and getCurrentMap() != Map.LIJIANG_GARDEN_LNY:
        goto lbl_0
    zoneLocations[0] = vect(43, 95, 150)
    zoneSizes[0] = 5
    zoneLocations[1] = vect(0, 94, 130)
    zoneSizes[1] = 7
    zoneLocations[2] = vect(-43, 95, 150)
    zoneSizes[2] = 5
    lbl_0:


"""@Rule "DEV: Create Coord Hud"
@Event eachPlayer
hudHeader(eventPlayer, "X: {0} | Y: {1} | Z: {2}".format(eventPlayer.getPosition().x, eventPlayer.getPosition().y, eventPlayer.getPosition().z), Position.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
"""


@Rule "Create Info HUD"
@Event global
hudSubtext(getPlayers(Team.1), "{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.1]), len([obj for obj in zoneControl if obj == Team.2])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
hudSubtext(getPlayers(Team.2), "{0} | Zones | {1}".format(len([obj for obj in zoneControl if obj == Team.2]), len([obj for obj in zoneControl if obj == Team.1])), Position.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
hudHeader(getAllPlayers(), "Zone A", Position.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
zoneHudText[0] = getLastCreatedText()
hudHeader(getAllPlayers(), "Zone B", Position.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)


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


@Rule "Award points based on zones captured on kill"
@Event playerDealtFinalBlow
addToTeamScore(attacker.getTeam(), max(1, len([obj for obj in zoneControl if obj == attacker.getTeam()])))


@Rule "Zone A Capturing (Uncaptured)"
@Event global
if zoneControl[0] == null and ((any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)])) or (any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]))):
    zoneAProgress = 0
    if any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]):
        goto lbl_1
    chase(zoneAProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    goto lbl_2
    lbl_1:
    chase(zoneAProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    lbl_2:

@Rule "Zone A Capturing (Captured)"
@Event global
if zoneControl[0] != null and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(getOppositeTeam(zoneControl[0]))]) and not any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(zoneControl[0])]):
    if zoneControl[0] == Team.1:
        goto lbl_3
    chase(zoneAProgress, 100, rate=10 * (len([player for player in getLivingPlayers(Team.1) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    goto lbl_4
    lbl_3:
    chase(zoneAProgress, -100, rate=10 * (len([player for player in getLivingPlayers(Team.2) if distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0]])), ChaseReeval.DESTINATION_AND_RATE)
    lbl_4:

@Rule "Zone A Contested"
@Event global
if any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.1)]) and any([distance(player.getPosition(), zoneLocations[0]) <= zoneSizes[0] for player in getLivingPlayers(Team.2)]):
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
    bigMessage(getPlayers(zoneControl[0]), "Zone A Captured")
    bigMessage(getPlayers(getOppositeTeam(zoneControl[0])), "Zone A Lost")