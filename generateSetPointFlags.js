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
        var numPlayers = `[p for p in getPlayers(${team.constant}) if p.isAlive() and not (p.getCurrentHero() == Hero.SOMBRA and p.isUsingAbility1()) and distance(vect(p.getPosition().x, zoneLocations[${point}].y, p.getPosition().z), zoneLocations[${point}]) < zoneSizes[${point}] and p.getPosition().y - zoneLocations[${point}].y >= -0.5 and p.getPosition().y - zoneLocations[${point}].y < zoneSizes[${point}]]`;
        result += 
`rule "Point ${pointToLetter[point]}: Set ${team.variable}${pointToLetter[point]}":
	@Event global
    if len(${numPlayers}) != ${team.variable}${pointToLetter[point]}:
        ${team.variable}${pointToLetter[point]} = len(${numPlayers})
`;
    })
}
result;