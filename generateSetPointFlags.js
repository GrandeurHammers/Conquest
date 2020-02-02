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
        var numPlayers = `[p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], ${team.constant}, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())]`;
        result += 
`@Rule "Point ${pointToLetter[point]}: Set ${team.variable}${pointToLetter[point]}"
@Event global
if len(${numPlayers}) != ${team.variable}${pointToLetter[point]}:
    ${team.variable}${pointToLetter[point]} = len(${numPlayers})
`;
    })
}
result;