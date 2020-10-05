#!mainFile "conquest.opy"

rule "DEBUG: Show CPU":
	@Event global
	@Disabled
	hudSubtext(getAllPlayers(), "Server Load: {0}".format(getServerLoad()), HudPosition.LEFT, -100, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudSubtext(getAllPlayers(), "Server Avg: {0}".format(getAverageServerLoad()), HudPosition.LEFT, -99, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudSubtext(getAllPlayers(), "Server Peak: {0}".format(getPeakServerLoad()), HudPosition.LEFT, -98, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

rule "DEBUG: Show Player Position":
	@Event eachPlayer
	@Disabled
	hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.LEFT, -0.5, Color.YELLOW, HudReeval.STRING, SpecVisibility.NEVER)

rule "DEBUG: Shorten assemble heroes":
	@Event global
	@Disabled
	@Condition isAssemblingHeroes()
    setMatchTime(10)

rule "DEBUG: Shorten match to 10 seconds":
	@Event global
	@Disabled
	@Condition isGameInProgress()
    setMatchTime(10)

rule "DEBUG: Summon Dummy Bot on Player upon Melee + Interact":
	@Event eachPlayer
	@Disabled
	@Condition eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.isHoldingButton(Button.MELEE)
	createDummy(Hero.ASHE, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getPosition(), vect(0,0,0))

rule "DEBUG: Summon Dummy Bot from each team in a zone 3 seconds after start":
	@Disabled
	@Condition isGameInProgress()
	wait(3)
	createDummy(random.choice(getAllHeroes()), Team.1, -1, zoneLocations[0], vect(0,0,0))
	getLastCreatedEntity().startForcingPosition(zoneLocations[0], true)
	createDummy(random.choice(getAllHeroes()), Team.2, -1, zoneLocations[1], vect(0,0,0))
	getLastCreatedEntity().startForcingPosition(zoneLocations[1], true)
	createDummy(random.choice(getAllHeroes()), Team.1, -1, zoneLocations[2], vect(0,0,0))
	getLastCreatedEntity().startForcingPosition(zoneLocations[2], true)
	
rule "DEBUG: Trigger Power Play after holding Interact for 3 seconds (crouch for enemy, default friendly)":
	@Event eachPlayer
	@Disabled
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
	wait(0.5, Wait.ABORT_WHEN_FALSE)
	smallMessage(getAllPlayers(), "Forcing Power Play in 3")
	wait(1, Wait.ABORT_WHEN_FALSE)
	smallMessage(getAllPlayers(), "Forcing Power Play in 2")
	wait(1, Wait.ABORT_WHEN_FALSE)
	smallMessage(getAllPlayers(), "Forcing Power Play in 1")
	wait(1, Wait.ABORT_WHEN_FALSE)
	smallMessage(getAllPlayers(), "Forcing Power Play!")
	if eventPlayer.isHoldingButton(Button.CROUCH):
		zoneControl[0] = getOppositeTeam(eventPlayer.getTeam())
		zoneControl[1] = getOppositeTeam(eventPlayer.getTeam())
		zoneControl[2] = getOppositeTeam(eventPlayer.getTeam())
	else:
		zoneControl[0] = eventPlayer.getTeam()
		zoneControl[1] = eventPlayer.getTeam()
		zoneControl[2] = eventPlayer.getTeam()