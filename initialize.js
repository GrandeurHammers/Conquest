var result = "";
var numPoints = 3;
const pointToLetter = ['A', 'B', 'C'];
for (var i = 0;  i < numPoints; i++) {
    // Initialize zone control + flags
    // Generate Zone Progress Headers
    result += `
    zoneControl[${i}] = null
    hudHeader([p for p in getAllPlayers() if abs(zone${pointToLetter[i]}Progress) > 0 and not huntActive and distance(vect(p.getPosition().x, zoneLocations[${i}].y, p.getPosition().z), zoneLocations[${i}]) < zoneSizes[${i}] and p.getPosition().y - zoneLocations[${i}].y >= -0.5 and p.getPosition().y - zoneLocations[${i}].y < zoneSizes[${i}]], "Progress: {}%".format(floor(abs(zone${pointToLetter[i]}Progress))), HudPosition.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
}

// Generate Zone Separators
for (var i = 1.5; i < 3; i++) {
    result += `
    hudSubtext(getAllPlayers(), w"-----------", HudPosition.RIGHT, ${i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`
}

result += `
hudHeader([p for p in getAllPlayers() if huntActive], "The Hunt: {}".format(ceil(huntTimer)), HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)`
result;