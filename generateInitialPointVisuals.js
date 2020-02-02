var result = "";
var conditions = [
    {
        "control": "null",
        "color": "WHITE"
    },
    {
        "control": "Team.1",
        "color": "TEAM_1"
    },
    {
        "control": "Team.2",
        "color": "TEAM_2"
    }
];
var pointToLetter = ['A', 'B', 'C'];
for (var i = 0; i < pointToLetter.length; i++) {
    conditions.forEach(function (condition) {
        result += `
        createEffect([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control}], Effect.RING, Color.${condition.color}, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY)
        createInWorldText([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control}], "${pointToLetter[i]}", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.${condition.color}, SpecVisibility.DEFAULT)`;
    });
}

result;