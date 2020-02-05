var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = `
@Rule "Point ${pointToLetter[point]}: Fast Reset"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] == Team.1 and numTeam1${pointToLetter[point]} > 0 and numTeam2${pointToLetter[point]} == 0) or \
(zoneControl[${point}] == Team.2 and numTeam2${pointToLetter[point]} > 0 and numTeam1${pointToLetter[point]} == 0)):
    wait(1, Wait.ABORT_WHEN_FALSE)
    ${zoneProgress} =  0
    
@Rule "Point ${pointToLetter[point]}: Gradual Reset Trigger"
@Event global
if huntTimer == 0 and \
abs(${zoneProgress}) > 0 and numTeam1${pointToLetter[point]} == 0 and numTeam2${pointToLetter[point]} == 0:
    wait(3, Wait.ABORT_WHEN_FALSE)
    zoneLoopControl[${point}] = -1

@Rule "Point ${pointToLetter[point]}: Gradual Reset Loop"
@Event global
if zoneLoopControl[${point}] == -1:
    do:
        ${zoneProgress} = ${zoneProgress} - ${zoneProgress}/abs(${zoneProgress})
        wait(1/25, Wait.ABORT_WHEN_FALSE)
    while RULE_CONDITION

@Rule "Point ${pointToLetter[point]}: Contesting"
@Event global
if huntTimer == 0 and \
numTeam1${pointToLetter[point]} > 0 and \
numTeam2${pointToLetter[point]} > 0:
    zoneLoopControl[${point}] = 0
    smallMessage([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], Team.ALL, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())], "Contesting!")

@Rule "Point ${pointToLetter[point]}: Capturing"
@Event global
if huntTimer == 0 and \
((zoneControl[${point}] != Team.1 and numTeam1${pointToLetter[point]} > 0 and numTeam2${pointToLetter[point]} == 0) or \
(zoneControl[${point}] != Team.2 and numTeam2${pointToLetter[point]} > 0 and numTeam1${pointToLetter[point]} == 0)):
    do:
        if numTeam1${pointToLetter[point]} > 0:
            if ${zoneProgress} < 0:
                ${zoneProgress} = 0
            ${zoneProgress} = ${zoneProgress} + numTeam1${pointToLetter[point]}
        else:
            if ${zoneProgress} > 0:
                ${zoneProgress} = 0
            ${zoneProgress} = ${zoneProgress} - numTeam2${pointToLetter[point]}
        wait(0.2, Wait.ABORT_WHEN_FALSE)
    while RULE_CONDITION

@Rule "Point ${pointToLetter[point]}: Listen for Capture"
@Event global
if abs(${zoneProgress}) == 100:
    if ${zoneProgress} == 100:
        ${zoneProgress} = 0
        zoneControl[${point}] = Team.1
        addToTeamScore(Team.1, 1)
        smallMessage(getPlayers(Team.1), "Zone ${pointToLetter[point]} Captured")
        smallMessage(getPlayers(Team.2), "Zone ${pointToLetter[point]} Lost")
        wait(0.016, Wait.IGNORE_CONDITION)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, zoneLocations[${point}], zoneSizes[${point}] * 2)
    else:
        ${zoneProgress} = 0
        zoneControl[${point}] = Team.2
        addToTeamScore(Team.2, 1)
        smallMessage(getPlayers(Team.1), "Zone ${pointToLetter[point]} Lost")
        smallMessage(getPlayers(Team.2), "Zone ${pointToLetter[point]} Captured")
        wait(0.016, Wait.IGNORE_CONDITION)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_2, zoneLocations[${point}], zoneSizes[${point}] * 2)
`;
result;