var result = "";
var pointToLetter = ['A', 'B', 'C'];
for (var i = 0; i < pointToLetter.length; i++) {
    // Ring on ground
    result += `\n\t# Zone ${pointToLetter[i]} Visuals - Ring Effect`;
    result += `\n\tcreateEffect(getAllPlayers(), Effect.RING, zone${pointToLetter[i]}MainColor, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY_AND_COLOR)`;
    // Power play locked icon
    result += `\n\t# Zone ${pointToLetter[i]} Visuals - Locked zone indicator (power play)`;
    result += `\n\tcreateInWorldText(getAllPlayers() if powerPlayActive else null, "{0}\r".format(iconString(Icon.NO)), zoneLocations[${i}], 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE, SpecVisibility.DEFAULT)`;
    // Normal zone lettering
    result += `\n\tcreateInWorldText(getAllPlayers() if not powerPlayActive else null, "${pointToLetter[i]}\r", zoneLocations[${i}] + vect(0,2,0), 3, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, zone${pointToLetter[i]}MainColor, SpecVisibility.DEFAULT)`;
    // Normal percentage indicator
    result += `\n\tcreateInWorldText(getAllPlayers() if not powerPlayActive else null, " \r{0}%".format(floor(abs(zone${pointToLetter[i]}Progress))) if abs(zone${pointToLetter[i]}Progress) > 0 else "", zoneLocations[${i}] + vect(0,2,0), 3, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, zone${pointToLetter[i]}AltColor, SpecVisibility.DEFAULT)`;
    // Warning signs
    result += `\n\t# Team 1 specific prompts`;
    result += `\n\tcreateIcon([p for p in getPlayers(Team.1) if distance(p, zoneLocations[${i}]) > zoneSizes[${i}]] if zone${pointToLetter[i]}Progress < 0 and not powerPlayActive else null, zoneLocations[${i}], Icon.WARNING, IconReeval.VISIBILITY, Color.RED, true)`;
    result += `\n\t# Team 2 specific prompts`;
    result += `\n\tcreateIcon([p for p in getPlayers(Team.2) if distance(p, zoneLocations[${i}]) > zoneSizes[${i}]] if zone${pointToLetter[i]}Progress > 0 and not powerPlayActive else null, zoneLocations[${i}], Icon.WARNING, IconReeval.VISIBILITY, Color.RED, true)`;
}
console.log(result);
result;
