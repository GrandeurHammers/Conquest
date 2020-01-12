var result = "";
const pointToLetter = ['A', 'B', 'C'];
// Initialize zone control + flags
for (var i = 0;  i < 3; i++) {
    result += `
    zoneControl[${i}] = null
    isTeam1[${i}] = false
    isTeam2[${i}] = false`
}

// Generate Point Progress Headers
for (var i = 0; i < 3; i++) {
    result += `
    hudHeader([p for p in getPlayersInRadius(zoneLocations[${i}], zoneSizes[${i}], Team.ALL, LosCheck.OFF) if abs(zone${pointToLetter[i]}Progress) > 0], "Progress: {}%".format(floor(abs(zone${pointToLetter[i]}Progress))), Position.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`
}
result;