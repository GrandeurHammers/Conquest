#!mainFile "conquest.opy"

rule "If a Team controls all 3 points, activate Power Play":
	@Event global
	@Condition powerPlayEnabled and (all([control == Team.1 for control in zoneControl]) or all([control == Team.2 for control in zoneControl]))
    powerPlayActive = true
    powerPlayTimer = powerPlayDuration
    stopAllProgress()
    generateLockedText()
    setSlowMotion(10)
    getAllPlayers().setAimSpeed(50)
    setObjectiveDescription(getAllPlayers(), "Power Play", HudReeval.VISIBILITY)
    bigMessage(getAllPlayers(), "Power Play")
    bigMessage(getAllPlayers(), "Zones Locked")
    if powerPlayMarkers:
        toggleSkulls(true)
    powerPlaySoundTrigger = true
    wait(0.5, Wait.IGNORE_CONDITION)
    powerPlaySoundTrigger = false
    setSlowMotion(100)
    getAllPlayers().setAimSpeed(100)
    chase(powerPlayTimer, 0, rate=1, ChaseReeval.NONE)

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
    triggerPointReset(true)
    powerPlayActive = false
    powerPlaySoundTrigger = true
    wait(0.016, Wait.IGNORE_CONDITION)
    powerPlaySoundTrigger = false

rule "HELPER: Play Power Play Sound at Player Position":
    @Event eachPlayer
    @Condition powerPlaySoundTrigger
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)