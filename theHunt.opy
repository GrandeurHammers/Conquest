#!mainFile "owib.opy"

@Rule "If a Team controls all 3 points, activate the Hunt"
@Event global
if activateHunt and (all([control == Team.1 for control in zoneControl]) or all([control == Team.2 for control in zoneControl])):
    huntTimer = huntDuration
    stopAllProgress()
    generateLockedText()
    setSlowMotion(10)
    bigMessage(getAllPlayers(), "{0} is on The Hunt".format(zoneControl[0]))
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[0], 200)
    wait(0.5, Wait.IGNORE_CONDITION)
    setSlowMotion(100)
    chase(huntTimer, 0, rate=1, ChaseReeval.NONE)

@Rule "At end of Hunt, reset points"
@Event global
if huntTimer <= 0.016 and huntTimer > 0:
    triggerPointReset()