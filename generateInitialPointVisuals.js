var result = "";
var indToLetter = ['A', 'B', 'C'];
for (var i = 0; i < indToLetter.length; i++) {
    result += `
createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[${i}], zoneSizes[${i}], EffectReeval.VISIBILITY)
zone${indToLetter[i]}Visuals[0] = getLastCreatedEntity()
createInWorldText(getAllPlayers(), "${indToLetter[i]}", zoneLocations[${i}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
zone${indToLetter[i]}Visuals[1] = getLastCreatedText()`;
}

result;