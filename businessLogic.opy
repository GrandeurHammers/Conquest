#!mainFile "conquest.opy"

rule "Remove respawn buffered marker on respawn (necessary because hero swap respawn is faster)":
    @Event eachPlayer
    @Condition eventPlayer.isAlive()
    # Reset for next death
    eventPlayer.respawnBuffered = false
    eventPlayer.respawnBlocked = false

rule "Main Respawn handler":
    @Event playerDied
    # Prevent manual respawn for 5 seconds
    victim.respawnBlocked = true
    # If currently power play, force respawn buffer
    if powerPlayActive:
        victim.respawnBuffered = true
    # Track time until respawn
    victim.timeToRespawn = minRespawnTime
    chase(victim.timeToRespawn, 0, rate=1, ChaseReeval.NONE)
    wait(minRespawnTime, Wait.RESTART_WHEN_TRUE)
    # Allow manual respawn
    victim.respawnBlocked = false
    # Respawn if they pressed jump while blocked
    if victim.respawnBuffered:
        victim.respawn()
    # Wait until max time before respawn
    wait(maxRespawnTime - minRespawnTime, Wait.RESTART_WHEN_TRUE)
    if victim.isDead():
        victim.respawn()

rule "If player attempts to respawn while blocked, mark them to respawn":
    @Event eachPlayer
    @Condition eventPlayer.isDead()
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
    if eventPlayer.respawnBlocked:
        eventPlayer.respawnBuffered = true
        return
    eventPlayer.respawn()

rule "Reset on Game Start (Waiting for Players)":
	@Event global
    @Condition isGameInProgress()
    # Stop all zone progress
    stopAllProgress()
    # Reset Zones
    triggerPointReset(false)
    # Reset Scores
    setTeamScore(Team.1, 0)
    setTeamScore(Team.2, 0)

rule "Upon earning a kill, award additional points for zones controlled":
	@Event playerDealtFinalBlow
    @Condition len([control for control in zoneControl if control == attacker.getTeam()]) >= 2
    # Award bonus points
    addToTeamScore(attacker.getTeam(), len([control for control in zoneControl if control == attacker.getTeam()]) - 1)
    # Mark as valid target for feedback
    victim.validElimTarget = true

rule "Provide feedback on valid elimination":
    @Event playerEarnedElimination
    @Condition victim.validElimTarget
    # Provide visual feedback for bonus points
    smallMessage(attacker, "+{} for Zone Control".format(len([control for control in zoneControl if control == attacker.getTeam()]) - 1))
    # Provide audio feedback for bonus points
    async(playElimSounds, AsyncBehavior.NOOP)

def playElimSounds():
    @Name "SUB: Play sounds for earning elims with zone advantage"
    switch len([control for control in zoneControl if control == attacker.getTeam()]):
        case 3:
            wait(0.5)
            playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
        default:
            wait(0.5)
            playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)

rule "Remove validElim marker":
    @Event eachPlayer
    @Condition eventPlayer.validElimTarget
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    eventPlayer.validElimTarget = false

rule "Declare Winner if a team has requisite number of points":
	@Event global
    @Condition isGameInProgress()
    # During overtime, teams do not necessarily need more than scoreToWin points, so we have a separate rule to handle overtime
    @Condition not overtime
    @Condition (teamScore(Team.1) >= scoreToWin or teamScore(Team.2) >= scoreToWin)
    @Condition teamScore(Team.1) != teamScore(Team.2)
    currScoreComp = teamScore(Team.1) - teamScore(Team.2)
    declareWinner()

rule "Regulation Time End Handler: Trigger Overtime or Declare Victory when regulation time runs out":
	@Event global
    @Condition isGameInProgress()
    @Condition getMatchTime() == 0
    @Condition not powerPlayActive
    @Condition not overtime
    # Cache result before buffer wait
    currScoreComp = teamScore(Team.1) - teamScore(Team.2)
    # Wait for two frames to alleviate potential race conditions
    wait(0.032, Wait.ABORT_WHEN_FALSE)
    # If teams are tied, initiate overtime (or declare draw if overtime not enabled)
    if currScoreComp == 0:
        if not overtimeEnabled:
            declareDraw()
            return
        bigMessage(getAllPlayers(), l"Overtime")
        setMatchTime(0.032)
        overtime = true
        wait(0.016)
        pauseMatchTime()
        setObjectiveDescription(getAllPlayers(), l"Overtime", HudReeval.VISIBILITY_AND_STRING)
    # Otherwise, declare a winner
    else:
        declareWinner()

rule "Maintain Overtime Music":
    @Event global
    @Condition isGameInProgress()
    @Condition overtime
    # The end-of-round music only lasts 30 seconds, so we must retrigger it every thirty seconds
    while overtime:
        wait(30, Wait.ABORT_WHEN_FALSE)
        setMatchTime(0)
        wait(0.016)
        setMatchTime(0.032)
        wait(0.016)
        pauseMatchTime()

rule "Overtime End Handler":
	@Event global
    @Condition overtime
    @Condition teamScore(Team.1) != teamScore(Team.2)
    declareWinner()

def declareWinner():
    @Name "SUB: Declare Winner | UPDATE currScoreComp BEFORE CALLING THIS SUBROUTINE"
    if currScoreComp == 0:
        return
    if currScoreComp > 0:
        # Allow adequate time to process end of game
        wait(0.5)
        declareTeamVictory(Team.1)
    else:
        # Allow adequate time to process end of game
        wait(0.5)
        declareTeamVictory(Team.2)