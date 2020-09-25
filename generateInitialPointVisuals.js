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
var pointToLetter = ['A', 'B', 'C'];
for (var i = 0; i < pointToLetter.length; i++) {
    conditions.forEach(function (condition) {
        result += `
    # Zone ${pointToLetter[i]} Visuals - Ring on ground
    createEffect([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control}], Effect.RING, Color.${condition.color}, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY)
    # Zone ${pointToLetter[i]} Visuals - Locked zone indicator (power play)
    createInWorldText([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control} and powerPlayActive], "{0}".format(iconString(Icon.NO)), zoneLocations[${i}] + 2 * Vector.UP, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE, SpecVisibility.DEFAULT)`;
        let templateWorldText = `createInWorldText([p for p in getAllPlayers() if zoneControl[${i}] == ${condition.control} and not powerPlayActive and (%COND%)], (" ${pointToLetter[i]}\r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress))) if abs(zone${pointToLetter[i]}Progress) < 10 else "  ${pointToLetter[i]}\r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress)))) if abs(zone${pointToLetter[i]}Progress) > 0 else "${pointToLetter[i]}\r ", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.%COLOR%, SpecVisibility.DEFAULT)`;
        if ("team1altcolor" in condition && "team2altcolor" in condition) {
            result += `
    # Zone ${pointToLetter[i]} Visuals - Zone identifier (normal play | neutral control neutral color)
    ${templateWorldText.replace("%COND%", `not altColorControl[${i}] or zone${pointToLetter[i]}Progress == 0`).replace("%COLOR%", `${condition.color}`)}`;
            result += `
    # Zone ${pointToLetter[i]} Visuals - Zone identifier (normal play | neutral control team 1 color)
    ${templateWorldText.replace("%COND%", `altColorControl[${i}] and zone${pointToLetter[i]}Progress > 0`).replace("%COLOR%", `${condition.team1altcolor}`)}`;
            result += `
    # Zone ${pointToLetter[i]} Visuals - Zone identifier (normal play | neutral control team 2 color)
    ${templateWorldText.replace("%COND%", `altColorControl[${i}] and zone${pointToLetter[i]}Progress < 0`).replace("%COLOR%", `${condition.team2altcolor}`)}`;
        } else if ("capturealtcolor" in condition) {
            result += `
    # Zone ${pointToLetter} Visuals - Zone identifier (normal play | ${condition.control.replace(".", " ")} control default color)
    ${templateWorldText.replace("%COND%", `not altColorControl[${i}] or zone${pointToLetter[i]}Progress == 0`).replace("%COLOR%", `${condition.color}`)}`;
            result += `
    # Zone ${pointToLetter} Visuals - Zone identifier (normal play | ${condition.control.replace(".", " ")} control capturing color)
    ${templateWorldText.replace("%COND%", `altColorControl[${i}] or abs(zone${pointToLetter[i]}Progress) > 0`).replace("%COLOR%", `${condition.capturealtcolor}`)}`;
        } else {
            result += `
    # Zone ${pointToLetter[i]} Visuals - Zone identifier (normal play)
    ${templateWorldText.replace("%COND%", "true").replace("%COLOR%", `${condition.color}`)}`;
        }
    });
}
console.log(result);
result;