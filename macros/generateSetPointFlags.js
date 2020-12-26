var result = "";
let teams = [
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
let disallowedHeroAbilityCombos = [
    {
        "hero": "SOMBRA",
        "ability": "Ability1"
    },
    {
        "hero": "DOOMFIST",
        "ability": "Ultimate"
    },
    {
        "hero": "MEI",
        "ability": "Ability1"
    }
];
let heroConditions = [];
disallowedHeroAbilityCombos.forEach(function (combo) {
    heroConditions.push(`not (p.getCurrentHero() == Hero.${combo.hero} and p.isUsing${combo.ability}())`);
});
let heroCondition = heroConditions.join(" and ")
let pointToLetter = ["A", "B", "C"];
for (let point = 0; point < 3; point++) {
    teams.forEach(function (team) {
        let varName = `${team.variable}${pointToLetter[point]}`;
        let numPlayers = `[p for p in getPlayers(${team.constant}) if p.hasSpawned() and p.isAlive() and ${heroCondition} and isWithinZoneBounds(p, ${point})]`;
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
console.log(result);
result;