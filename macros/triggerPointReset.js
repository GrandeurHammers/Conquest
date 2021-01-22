var result = "";
var pointToLetter = ["A", "B", "C"];
for (var point = 0; point < 3; point++) {
    result += `
zoneControl[${point}] = null
zone${pointToLetter[point]}Progress = 0`;
}

result;