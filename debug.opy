#!mainFile "owib.opy"

rule "=====DEBUG=====":
	@Event global
	@Disabled
	return

rule "DEBUG: Show CPU":
	@Event global
	@Disabled
	hudSubtext(getAllPlayers(), "Server Load: {0}".format(getServerLoad()), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudSubtext(getAllPlayers(), "Server Avg: {0}".format(getAverageServerLoad()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudSubtext(getAllPlayers(), "Server Peak: {0}".format(getPeakServerLoad()), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

rule "DEBUG: Show Player Position":
	@Event eachPlayer
	@Disabled
	hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.LEFT, -1, Color.YELLOW, HudReeval.STRING, SpecVisibility.NEVER)

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