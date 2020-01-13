var result = "";
var pointToLetter = ["A", "B", "C"];
for (var point = 0; point < 3; point++) {
    result += `
destroyHudText(zone${pointToLetter[point]}HudText[0])
zoneControl[${point}] = null
zone${pointToLetter[point]}Progress = null`;
}
result += `
wait(0.016, Wait.IGNORE_CONDITION)`;
for (var point = 0; point < 3; point++) {
    result += `
zone${pointToLetter[point]}Progress = 0`;
}
for (var point = 0; point < 3; point++) {
    result += `
createEffect(getAllPlayers(), Effect.RING, Color.WHITE, zoneLocations[${point}], zoneSizes[${point}], EffectReeval.VISIBILITY)
zone${pointToLetter[point]}Visuals[0] = getLastCreatedEntity()
wait(0.016, Wait.IGNORE_CONDITION)`;
}
for (var point = 0; point < 3; point++) {
    result += `
createInWorldText(getAllPlayers(), "${pointToLetter[point]}", zoneLocations[${point}] + 2 * Vector.UP, 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
zone${pointToLetter[point]}Visuals[1] = getLastCreatedText()
wait(0.016, Wait.IGNORE_CONDITION)`;
}
result;