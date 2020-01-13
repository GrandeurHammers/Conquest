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
var indToLetter = ['A', 'B', 'C'];
for (var point = 0; point < 3; point++) {
    teams.forEach(function (team) {
        result += 
`@Rule "Point ${indToLetter[point]}: Set ${team.variable}"
@Event global
if len([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], ${team.constant}, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())]) != ${team.variable}[${point}]:
    ${team.variable}[${point}] = len([p for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], ${team.constant}, LosCheck.OFF) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1())])
`;
    })
}
result;