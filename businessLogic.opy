#!mainFile "conquest.opy"

subroutine customRespawn
subroutine shiftTeamSpawns

def customRespawn():
    @Name "SUB: Custom Respawn Logic"
    if eventPlayer.isDead():
        eventPlayer.respawn()
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 2)
    # Wait so we can actually affect the player
    wait()
    eventPlayer.teleport(nearestWalkablePosition(zoneSpawns[currTeamSpawns[0 if eventPlayer.getTeam() == Team.1 else 1]] + vect(random.uniform(0,zoneSpawnRadii[currTeamSpawns[0 if eventPlayer.getTeam() == Team.1 else 1]]), 0, random.uniform(0,zoneSpawnRadii[currTeamSpawns[0 if eventPlayer.getTeam() == Team.1 else 1]]))))
    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), zoneLocations[currTeamSpawns[0 if eventPlayer.getTeam() == Team.1 else 1]]) * vect(1,0,1), Relativity.TO_WORLD)
    wait(0.25)

rule "Remove respawn buffered marker on respawn and trigger custom respawn logic":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isAlive()
    # Reset for next death
    eventPlayer.respawnBuffered = false
    eventPlayer.respawnBlocked = false
    if not eventPlayer.isDummy():
        customRespawn()

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
    switch len([control for control in zoneControl if control == eventPlayer.getTeam()]):
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
    # Update currScoreComp as needed by declare winner
    currScoreComp = teamScore(Team.1) - teamScore(Team.2)
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

def shiftTeamSpawns():
    @Name "SUB: Shift where teams spawn if necessary"
    # Don't shift spawns if shifting spawns are disabled
    if not shiftSpawns:
        return
    # Team spawns swap if the swap would result in a more favorable zone control spawn for both teams
    if (zoneControl[currTeamSpawns[0]] == Team.2 and zoneControl[currTeamSpawns[1]] != Team.2) or (zoneControl[currTeamSpawns[0]] == null and zoneControl[currTeamSpawns[1]] == Team.1):
        # These three actions swap the team spawns by moving Team 1 spawn to the open zone, moving Team 2 to the zone Team 1 just vacated, and moving Team 1 to the zone Team 2 just vacated.
        currTeamSpawns[0] = getUnusedSpawn()
        currTeamSpawns[1] = getUnusedSpawn()
        currTeamSpawns[0] = getUnusedSpawn()
    # Team 1 spawn shifts to the unused spawn under any of the following conditions:
    # - Current Team 1 spawn controlled by Team 2 and the unused spawn is not controlled by Team 2
    # - Current Team 1 spawn is Neutral and the unused spawn is controlled by Team 1
    if (zoneControl[currTeamSpawns[0]] == Team.2 and zoneControl[getUnusedSpawn()] != Team.2) or (zoneControl[currTeamSpawns[0]] == null and zoneControl[getUnusedSpawn()] == Team.1):
        currTeamSpawns[0] = getUnusedSpawn()
    # Team 2 spawn shifts to the unused spawn under any of the following conditions:
    # - Current Team 2 spawn controlled by Team 1 and the unused spawn is not controlled by Team 1
    # - Current Team 2 spawn is Neutral and the unused spawn is controlled by Team 2
    # Note that we only want Team 1 or Team 2 spawns to shift at any one time, never both.
    elif (zoneControl[currTeamSpawns[1]] == Team.1 and zoneControl[getUnusedSpawn()] != Team.1) or (zoneControl[currTeamSpawns[1]] == null and zoneControl[getUnusedSpawn()] == Team.2):
        currTeamSpawns[1] = getUnusedSpawn()
