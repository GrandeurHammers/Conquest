var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = `
rule "Zone ${pointToLetter[point]}: Fast Reset":
	@Event global
    @Condition not powerPlayActive
    # If the current zone is controlled by a team, and that team is alone on the zone
    @Condition ((zoneControl[${point}] == Team.1 and numTeam1${pointToLetter[point]} > 0 and numTeam2${pointToLetter[point]} == 0) or (zoneControl[${point}] == Team.2 and numTeam2${pointToLetter[point]} > 0 and numTeam1${pointToLetter[point]} == 0))
    wait(1, Wait.ABORT_WHEN_FALSE)
    # Reset capture progress immediately
    zone${pointToLetter[point]}Progress = 0
    zone${pointToLetter[point]}HudText[3] = "Capturing"
    
rule "Zone ${pointToLetter[point]}: Gradual Reset":
	@Event global
    @Condition powerPlayTimer == 0
    @Condition abs(zone${pointToLetter[point]}Progress) > 0
    @Condition zoneControl[${point}] == Team.1 or numTeam1${pointToLetter[point]} == 0
    @Condition zoneControl[${point}] == Team.2 or numTeam2${pointToLetter[point]} == 0
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zone${pointToLetter[point]}Progress, 0, rate=25, ChaseReeval.NONE)
    zone${pointToLetter[point]}HudText[3] = "Capturing"

rule "Zone ${pointToLetter[point]}: Contesting":
	@Event global
    @Condition powerPlayTimer == 0
    @Condition numTeam1${pointToLetter[point]} > 0
    @Condition numTeam2${pointToLetter[point]} > 0
    stopChasingVariable(zone${pointToLetter[point]}Progress)
    zone${pointToLetter[point]}HudText[3] = "Contested"
    smallMessage([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.ALL, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())], "Contested!")

rule "Zone ${pointToLetter[point]}: Capturing for Team 1":
	@Event global
    @Condition not powerPlayActive
    #If Team 1 alone on zone and does not own zone
    @Condition zoneControl[${point}] != Team.1
    @Condition numTeam1${pointToLetter[point]} > 0
    @Condition numTeam2${pointToLetter[point]} == 0
    if zone${pointToLetter[point]}Progress < 0:
        wait(1, Wait.ABORT_WHEN_FALSE)
        zone${pointToLetter[point]}Progress = 0
    chase(zone${pointToLetter[point]}Progress, 100, rate=(captureRatePerPlayer*min(numTeam1${pointToLetter[point]}, maxPlayerRate)*(6/len(getPlayers(Team.1)) if adaptiveCaptureRate else 1) + baseCaptureRate if numTeam1${pointToLetter[point]} > 0 else 0), ChaseReeval.DESTINATION_AND_RATE)
    zone${pointToLetter[point]}HudText[3] = "Capturing"

rule "Zone ${pointToLetter[point]}: Capturing for Team 2":
	@Event global
    @Condition not powerPlayActive
    #If Team 2 alone on zone and does not own zone
    @Condition zoneControl[${point}] != Team.2
    @Condition numTeam2${pointToLetter[point]} > 0
    @Condition numTeam1${pointToLetter[point]} == 0
    if zone${pointToLetter[point]}Progress > 0:
        wait(1, Wait.ABORT_WHEN_FALSE)
        zone${pointToLetter[point]}Progress = 0
    chase(zone${pointToLetter[point]}Progress, -100, rate=(captureRatePerPlayer*min(numTeam2${pointToLetter[point]}, maxPlayerRate)*(6/len(getPlayers(Team.2)) if adaptiveCaptureRate else 1) + baseCaptureRate if numTeam2${pointToLetter[point]} > 0 else 0), ChaseReeval.DESTINATION_AND_RATE)
    zone${pointToLetter[point]}HudText[3] = "Capturing"

rule "Zone ${pointToLetter[point]}: Listen for Capture":
	@Event global
    @Condition abs(${zoneProgress}) == 100
    stopChasingVariable(${zoneProgress})
    zone${pointToLetter[point]}HudText[3] = "Capturing"
    if ${zoneProgress} == 100:
        ${zoneProgress} = 0
        zoneControl[${point}] = Team.1
        addToTeamScore(Team.1, 1)
        smallMessage(getPlayers(Team.1), "Zone ${pointToLetter[point]} Captured")
        smallMessage(getPlayers(Team.2), "Zone ${pointToLetter[point]} Lost")
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, zoneLocations[${point}], zoneSizes[${point}] * 2)
    else:
        ${zoneProgress} = 0
        zoneControl[${point}] = Team.2
        addToTeamScore(Team.2, 1)
        smallMessage(getPlayers(Team.1), "Zone ${pointToLetter[point]} Lost")
        smallMessage(getPlayers(Team.2), "Zone ${pointToLetter[point]} Captured")
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_2, zoneLocations[${point}], zoneSizes[${point}] * 2)`;
result;