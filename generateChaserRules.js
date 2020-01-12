var indToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${indToLetter[point]}Progress`;
var result = `
@Rule "Point ${indToLetter[point]}: Instant Reset"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] == Team.1 and isTeam1[${point}] and not isTeam2[${point}]) or \
(zoneControl[${point}] == Team.2 and isTeam2[${point}] and not isTeam1[${point}])):
    zone${indToLetter[point]}Progress =  0
    
@Rule "Point ${indToLetter[point]}: Gradual Reset"
@Event global
if huntTimer == 0 and \
abs(zone${indToLetter[point]}Progress) > 0 and not isTeam1[${point}] and not isTeam2[${point}]:
    wait(3, Wait.ABORT_WHEN_FALSE)
    chase(zone${indToLetter[point]}Progress, 0, rate=25, ChaseReeval.NONE)

@Rule "Point ${indToLetter[point]}: Contesting"
@Event global
if huntTimer == 0 and isTeam1[${point}] and isTeam2[${point}]:
    stopChasingVariable(zone${indToLetter[point]}Progress)
    smallMessage([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.ALL, LosCheck.OFF) if p.isAlive()], "Contesting!")

@Rule "Point ${indToLetter[point]}: Capturing"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] != Team.1 and isTeam1[${point}] and not isTeam2[${point}]) or \
(zoneControl[${point}] != Team.2 and isTeam2[${point}] and not isTeam1[${point}])):
    if isTeam1[${point}]:
        if zone${indToLetter[point]}Progress < 0:
            zone${indToLetter[point]}Progress = 0
        chase(zone${indToLetter[point]}Progress, 100, rate=5*len([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.1, LosCheck.OFF) if p.isAlive()]), ChaseReeval.DESTINATION_AND_RATE)
    else:
        if zone${indToLetter[point]}Progress > 0:
            zone${indToLetter[point]}Progress = 0
        chase(zone${indToLetter[point]}Progress, -100, rate=5*len([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.2, LosCheck.OFF) if p.isAlive()]), ChaseReeval.DESTINATION_AND_RATE)

@Rule "Point ${indToLetter[point]}: Listen for Capture"
@Event global
if abs(${zoneProgress}) == 100:
    stopChasingVariable(${zoneProgress})
    if ${zoneProgress} == 100:
        zoneControl[${point}] = Team.1
    else:
        zoneControl[${point}] = Team.2
    ${zoneProgress} = 0
`;
result;