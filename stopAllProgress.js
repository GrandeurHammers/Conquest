var result = "";
var pointToLetter = ["A", "B", "C"];
for (var i = 0; i < 3; i++) {
    result += `
stopChasingVariable(zone${pointToLetter[i]}Progress)`;
}
result;