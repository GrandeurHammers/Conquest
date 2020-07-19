var result = "";
var teams = [
    {
        "constant": "Team.1",
        "name": "Team 1",
        "variable": "numTeam1"
    },
    {
        "constant": "Team.2",
        "name": "Team 2",
        "variable": "numTeam2"
    }
];
var pointToLetter = ["A", "B", "C"];
for (var point = 0; point < 3; point++) {
    teams.forEach(function (team) {
        let varName = `${team.variable}${pointToLetter[point]}`;
        let numPlayers = `[p for p in getPlayers(${team.constant}) if p.hasSpawned() and p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1()) and distance(vect(p.getPosition().x, zoneLocations[${point}].y, p.getPosition().z), zoneLocations[${point}]) < zoneSizes[${point}] and p.getPosition().y - zoneLocations[${point}].y >= -0.5 and p.getPosition().y - zoneLocations[${point}].y < zoneHeights[${point}]]`;
        result += 
`rule "Keep track of the number of ${team.name} players on Zone ${pointToLetter[point]}":
    @Event global
    # If the number of players from ${team.name} is not equal to the tracker variable...
    @Condition len(${numPlayers}) != ${varName}
    # ...update the tracker variable
    ${varName} = len(${numPlayers})
    # Sleep until next tick
    wait()
    # Sometimes we must loop because the updated value is no longer accurate, but the condition will not refire the rule for us
    if RULE_CONDITION:
        goto RULE_START
`;
    })
}
result;