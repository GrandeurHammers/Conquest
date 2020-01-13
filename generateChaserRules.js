var indToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${indToLetter[point]}Progress`;
var result = `
@Rule "Point ${indToLetter[point]}: Fast Reset"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] == Team.1 and numTeam1[${point}] > 0 and numTeam2[${point}] == 0) or \
(zoneControl[${point}] == Team.2 and numTeam2[${point}] > 0 and numTeam1[${point}] == 0)):
    wait(1, Wait.ABORT_WHEN_FALSE)
    zone${indToLetter[point]}Progress =  0
    
@Rule "Point ${indToLetter[point]}: Gradual Reset"
@Event global
if huntTimer == 0 and \
abs(zone${indToLetter[point]}Progress) > 0 and numTeam1[${point}] == 0 and numTeam2[${point}] == 0:
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zone${indToLetter[point]}Progress, 0, rate=25, ChaseReeval.NONE)

@Rule "Point ${indToLetter[point]}: Contesting"
@Event global
if huntTimer == 0 and numTeam1[${point}] > 0 and numTeam2[${point}] > 0:
    stopChasingVariable(zone${indToLetter[point]}Progress)
    smallMessage([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.ALL, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())], "Contesting!")

@Rule "Point ${indToLetter[point]}: Capturing"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] != Team.1 and numTeam1[${point}] > 0 and numTeam2[${point}] == 0) or \
(zoneControl[${point}] != Team.2 and numTeam2[${point}] > 0 and numTeam1[${point}] == 0)):
    if numTeam1[${point}] > 0:
        if zone${indToLetter[point]}Progress < 0:
            zone${indToLetter[point]}Progress = 0
        chase(zone${indToLetter[point]}Progress, 100, rate=5*numTeam1[${point}], ChaseReeval.DESTINATION_AND_RATE)
    else:
        if zone${indToLetter[point]}Progress > 0:
            zone${indToLetter[point]}Progress = 0
        chase(zone${indToLetter[point]}Progress, -100, rate=5*numTeam2[${point}], ChaseReeval.DESTINATION_AND_RATE)

@Rule "Point ${indToLetter[point]}: Listen for Capture"
@Event global
if abs(${zoneProgress}) == 100:
    stopChasingVariable(${zoneProgress})
    if ${zoneProgress} == 100:
        zoneControl[${point}] = Team.1
    else:
        zoneControl[${point}] = Team.2
    ${zoneProgress} = 0
    addToTeamScore(zoneControl[${point}], 1)
`;
result;