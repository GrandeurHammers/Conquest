var result = "";
var pointToLetter = ['A', 'B', 'C'];
for (var i = 0; i < pointToLetter.length; i++) {
    // Ring on ground
    result += `\n\t# Zone ${pointToLetter[i]} Visuals - Ring Effect`;
    result += `\n\tcreateEffect(getAllPlayers(), Effect.RING, zone${pointToLetter[i]}MainColor, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY_AND_COLOR)`;
    // Power play locked icon
    result += `\n\t# Zone ${pointToLetter[i]} Visuals - Locked zone indicator (power play)`;
    result += `\n\tcreateInWorldText(getAllPlayers() if powerPlayActive else null, "{0}".format(iconString(Icon.NO)), zoneLocations[${i}] + 2 * Vector.UP, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE, SpecVisibility.DEFAULT)`;
    // Normal zone lettering
    result += `\n\tcreateInWorldText(getAllPlayers() if not powerPlayActive else null, "${pointToLetter[i]}\r", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, zoneAMainColor, SpecVisibility.DEFAULT)`;
    // Normal percentage indicator
    result += `\n\tcreateInWorldText(getAllPlayers() if not powerPlayActive else null, " \r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress))) if abs(zone${pointToLetter[i]}Progress) > 0 else " \r ", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, zoneAAltColor, SpecVisibility.DEFAULT)`;
    // Warning signs
    result += `\n\t# Team 1 specific prompts`;
    result += `\n\tcreateInWorldText(getPlayers(Team.1), "{0}\r\r\r".format(iconString(Icon.WARNING)) if zone${pointToLetter[i]}Progress < 0 and not powerPlayActive else " \r\r\r", zoneLocations[${i}] + 2 * Vector.UP, 2, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.RED, SpecVisibility.NEVER)`;
    result += `\n\t# Team 2 specific prompts`;
    result += `\n\tcreateInWorldText(getPlayers(Team.2), "{0}\r\r\r".format(iconString(Icon.WARNING)) if zone${pointToLetter[i]}Progress > 0 and not powerPlayActive else " \r\r\r", zoneLocations[${i}] + 2 * Vector.UP, 2, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.RED, SpecVisibility.NEVER)`;
}
console.log(result);
result;