#!mainFile "owib.opy"

@Rule "If a Team controls all 3 points, activate the Hunt"
@Event global
if activateHunt and (all([control == Team.1 for control in zoneControl]) or all([control == Team.2 for control in zoneControl])):
    huntTimer = huntDuration
    stopAllProgress()
    generateLockedText()
    setSlowMotion(10)
    bigMessage(getAllPlayers(), "{0} is on The Hunt".format(zoneControl[0]))
    setObjectiveDescription(getAllPlayers(), "The Hunt is On", HudReeval.VISIBILITY_AND_STRING)
    bigMessage(getPlayers(zoneControl[0]), "Hunt Them Down")
    setObjectiveDescription(getPlayers(getOppositeTeam(zoneControl[0])), "Survive The Hunt", HudReeval.VISIBILITY_AND_STRING)
    bigMessage(getPlayers(getOppositeTeam(zoneControl[0])), "Survive The Hunt")
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[1], 200)
    wait(0.5, Wait.IGNORE_CONDITION)
    setSlowMotion(100)
    chase(huntTimer, 0, rate=1, ChaseReeval.NONE)

@Rule "At end of Hunt, reset points"
@Event global
if huntTimer <= 0.016 and huntTimer > 0:
    stopChasingVariable(huntTimer)
    setObjectiveDescription(getAllPlayers(), normalObjDesc, HudReeval.VISIBILITY_AND_STRING)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, zoneLocations[1], 200)
    bigMessage(getAllPlayers(), "The Hunt has Ended")
    triggerPointReset(true)