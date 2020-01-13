var result = "";
const pointToLetter = ['A', 'B', 'C'];
// Initialize zone control + flags
for (var i = 0;  i < 3; i++) {
    result += `
    zoneControl[${i}] = null`;
}

// Generate Zone Progress Headers
for (var i = 0; i < 3; i++) {
    result += `
    hudHeader([p for p in getPlayersInRadius(zoneLocations[${i}], zoneSizes[${i}], Team.ALL, LosCheck.OFF) if abs(zone${pointToLetter[i]}Progress) > 0 and huntTimer == 0], "Progress: {}%".format(floor(abs(zone${pointToLetter[i]}Progress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`
}

// Generate Zone Separators
for (var i = 1.5; i < 3; i++) {
    result += `
    hudSubtext(getAllPlayers(), w"-----------", Position.RIGHT, ${i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`
}

result += `
hudHeader([p for p in getAllPlayers() if huntTimer > 0], "The Hunt: {}".format(ceil(huntTimer)), Position.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)`
result;