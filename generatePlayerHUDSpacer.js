let linesDown = 10;
var result = "hudSubtext(getDeadPlayers(Team.ALL), \" ";
result += "\r".repeat(linesDown - 4);
result += "\" if powerPlayActive else \" ";
result += "\r".repeat(linesDown);
result += "\", HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)"
console.log(result);
result;
