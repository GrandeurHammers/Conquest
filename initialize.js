var result = "";
var numPoints = 3;
const pointToLetter = ['A', 'B', 'C'];
for (var i = 0;  i < numPoints; i++) {
    // Initialize zone control + flags
    // Generate Zone Progress Headers
    result += `
    zoneControl[${i}] = null
    hudHeader([p for p in getPlayersInRadius(zoneLocations[${i}], zoneSizes[${i}], Team.ALL, LosCheck.OFF) if abs(zone${pointToLetter[i]}Progress) > 0 and not huntActive], "Progress: {}%".format(floor(abs(zone${pointToLetter[i]}Progress))), HudPosition.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
}

// Generate Zone Separators
for (var i = 1.5; i < 3; i++) {
    result += `
    hudSubtext(getAllPlayers(), w"-----------", HudPosition.RIGHT, ${i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`
}

result += `
hudHeader([p for p in getAllPlayers() if huntActive], "The Hunt: {}".format(ceil(huntTimer)), HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)`
result;