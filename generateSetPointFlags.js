var result = "";
var teams = [
    {
        "constant": "Team.1",
        "name": "Team 1",
        "variable": "isTeam1"
    },
    {
        "constant": "Team.2",
        "name": "Team 2",
        "variable": "isTeam2"
    }
];
var indToLetter = ['A', 'B', 'C'];
for (var point = 0; point < 3; point++) {
    teams.forEach(function (team) {
        result += 
`@Rule "Point ${indToLetter[point]}: Set ${team.variable} True"
@Event global
if any([p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1()) for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], ${team.constant}, LosCheck.OFF)]):
    ${team.variable}[${point}] = true


@Rule "Point ${indToLetter[point]}: Set ${team.variable} False"
@Event global
if not(any([p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1()) for p in getPlayersInRadius(zoneLocations[${point}], zoneSizes[${point}], ${team.constant}, LosCheck.OFF)])):
    ${team.variable}[${point}] = false
`;
    })
}
result;