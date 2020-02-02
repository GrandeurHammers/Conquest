var result = "";
var pointToLetter = ["A", "B", "C"];
for (var point = 0; point < 3; point++) {
    result += `
destroyHudText(zone${pointToLetter[point]}HudText[0])
zoneControl[${point}] = null
zone${pointToLetter[point]}Progress = 0
wait(0.033, Wait.IGNORE_CONDITION)`;
}

result;