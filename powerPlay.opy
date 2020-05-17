#!mainFile "owib.opy"

rule "If a Team controls all 3 points, activate Power Play":
	@Event global
	@Condition powerPlayEnabled and (all([control == Team.1 for control in zoneControl]) or all([control == Team.2 for control in zoneControl]))
    powerPlayActive = true
    powerPlayTimer = powerPlayDuration
    stopAllProgress()
    generateLockedText()
    setSlowMotion(10)
    getAllPlayers().setAimSpeed(50)
    bigMessage(getAllPlayers(), "Power Play")
    bigMessage(getAllPlayers(), "Zones Locked")
    if powerPlayMarkers:
        toggleSkulls(true)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[1], 200)
    wait(0.5, Wait.IGNORE_CONDITION)
    setSlowMotion(100)
    getAllPlayers().setAimSpeed(100)
    chase(powerPlayTimer, 0, rate=1, ChaseReeval.NONE)

rule "At end of Power Play, reset points":
	@Event global
	@Condition powerPlayActive and powerPlayTimer == 0
    stopChasingVariable(powerPlayTimer)
    if powerPlayMarkers:
        toggleSkulls(false)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[1], 200)
    bigMessage(getAllPlayers(), "Power Play has Ended")
    triggerPointReset(true)
    powerPlayActive = false