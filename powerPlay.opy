#!mainFile "conquest.opy"

subroutine playSoundForAll

def playSoundForAll():
    for i in range(0,getNumberOfPlayers(Team.ALL)):
        playEffect(getAllPlayers()[i], DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, getAllPlayers()[i], 200)

rule "If a Team controls all 3 points, activate Power Play":
	@Event global
    @Condition powerPlayEnabled
    @Condition zoneControl[0] == Team.1 or zoneControl[0] == Team.2
    @Condition all([c == zoneControl[0] for c in zoneControl])
    # If a team is about to win, don't trigger a power play
    if teamScore(Team.1) >= scoreToWin or teamScore(Team.2) >= scoreToWin:
        playSoundForAll()
        return
    powerPlayActive = true
    powerPlayTimer = powerPlayDuration if overtime else min(powerPlayDuration, getMatchTime())
    stopAllProgress()
    setSlowMotion(10)
    getAllPlayers().setAimSpeed(50)
    setObjectiveDescription(getAllPlayers(), "Power Play", HudReeval.VISIBILITY)
    resumeMatchTime = max(getMatchTime() - powerPlayTimer, 0)
    setMatchTime(powerPlayDuration + 0.016)
    bigMessage(getAllPlayers(), "Power Play")
    bigMessage(getAllPlayers(), "Zones Locked")
    if powerPlayMarkers:
        toggleSkulls(true)
    playSoundForAll()
    getPlayers(getOppositeTeam(zoneControl[0])).setStatusEffect(null, Status.BURNING, powerPlayDuration + 0.5)
    pauseMatchTime()
    wait(0.5, Wait.IGNORE_CONDITION)
    setSlowMotion(100)
    getAllPlayers().setAimSpeed(100)
    unpauseMatchTime()
    chase(powerPlayTimer, 0, rate=1, ChaseReeval.NONE)

rule "Reapply burning effect if not burning":
    @Event eachPlayer
    @Condition powerPlayActive
    @Condition eventPlayer.getTeam() == getOppositeTeam(zoneControl[0])
    @Condition not eventPlayer.hasStatusEffect(Status.BURNING)
    eventPlayer.setStatusEffect(null, Status.BURNING, powerPlayTimer)

rule "At end of Power Play, reset points":
	@Event global
	@Condition powerPlayActive and powerPlayTimer == 0
    stopChasingVariable(powerPlayTimer)
    if powerPlayMarkers:
        toggleSkulls(false)
    if overtime:
        setObjectiveDescription(getAllPlayers(), "Overtime", HudReeval.VISIBILITY)
    else:
        setObjectiveDescription(getAllPlayers(), "Fight", HudReeval.VISIBILITY)
    bigMessage(getAllPlayers(), "Power Play Ended")
    setMatchTime(resumeMatchTime)
    triggerPointReset()
    playSoundForAll()
    # Use different sides from the previous Power Play
    swapSides = not swapSides
    # Reset spawns
    if swapSides:
        currTeamSpawns = [2,0]
    else:
        currTeamSpawns = [0,2]
