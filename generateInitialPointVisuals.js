var result = "";
var conditions = [
    {
        "control": "null",
        "color": "WHITE",
        "team1altcolor": "TEAM_1",
        "team2altcolor": "TEAM_2"
    },
    {
        "control": "Team.1",
        "color": "TEAM_1",
        "capturealtcolor": "TEAM_2"
    },
    {
        "control": "Team.2",
        "color": "TEAM_2",
        "capturealtcolor": "TEAM_1"
    }
];
// FIXME
var pointToLetter = ['A', 'B', 'C'];
for (var i = 0; i < pointToLetter.length; i++) {
    conditions.forEach(function (condition) {
        result += `
    # Zone ${pointToLetter[i]} Visuals - Ring on ground
    createEffect([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control}], Effect.RING, Color.${condition.color}, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY)
    # Zone ${pointToLetter[i]} Visuals - Zone identifier (normal play)
    createInWorldText([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control} and not powerPlayActive],
    (" ${pointToLetter[i]}\r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress))) if abs(zone${pointToLetter[i]}Progress) < 10 else "  ${pointToLetter[i]}\r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress)))) if abs(zone${pointToLetter[i]}Progress) > 0 else "${pointToLetter[i]}\r ", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.${condition.color}, SpecVisibility.DEFAULT)
    # Zone ${pointToLetter[i]} Visuals - Locked zone indicator (power play)
    createInWorldText([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control} and powerPlayActive], "{0}".format(iconString(Icon.NO)), zoneLocations[${i}] + 2 * Vector.UP, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE, SpecVisibility.DEFAULT)`;
    });
}

result;