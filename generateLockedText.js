var result = "";
var pointToLetter = ["A", "B", "C"];
for (var point = 0; point < 3; point++) {
    // Destroy all zone HUD texts
    for (var i = 0; i < 3; i++) {
        result += `
destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
    }
    // Create new zone HUD texts
    result += `
if all([control == Team.1 for control in zoneControl]):
    hudText(getAllPlayers(), "Zone ${pointToLetter[point]}", "", "Locked", Position.RIGHT, ${point + 1}, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
else:
    hudText(getAllPlayers(), "Zone ${pointToLetter[point]}", "", "Locked", Position.RIGHT, ${point + 1}, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`;
        result += `
zone${pointToLetter[point]}HudText[0] = getLastCreatedText()
wait(0.033, Wait.IGNORE_CONDITION)`;
}

result;