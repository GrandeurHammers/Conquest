var result = "";
var numPoints = 3;
const pointToLetter = ['A', 'B', 'C'];
for (var i = 0;  i < numPoints; i++) {
    // Initialize zone control + flags
    // Generate Zone Progress Headers
    result += `
zoneControl[${i}] = null
${progressBarHelper(i)}`;
}

// Generate Zone Separators
for (var i = 1.5; i < 3; i++) {
    result += `
hudSubtext(getAllPlayers(), w"-----------", HudPosition.RIGHT, ${i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`
}

result += `
hudHeader([p for p in getAllPlayers() if huntActive], "The Hunt: {}".format(ceil(huntTimer)), HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)`
console.log(result);
result;

function progressBarHelper(i) {
    // i = numerical index of zone
    var len = 18;
    var emptyChar = "□";
    var fullChar = "■";
    result = `hudHeader([p for p in getAllPlayers() if abs(zone${pointToLetter[i]}Progress) > 0 and not huntActive and distance(vect(p.getPosition().x, zoneLocations[${i}].y, p.getPosition().z), zoneLocations[${i}]) < zoneSizes[${i}] and p.getPosition().y - zoneLocations[${i}].y >= -0.5 and p.getPosition().y - zoneLocations[${i}].y < zoneSizes[${i}]], `;

    for (var bar = 0; bar <= len; bar++) {
        if (bar != 0) {
            result += `.append(`;
        }
        result += `"`;
        for (var place = 0; place < len; place++) {
            if (place < bar) {
                result += fullChar;
            } else {
                result += emptyChar;
            }
        }
        result += `"`;
        if (bar != 0) {
            result += `)`;
        }
    }
    
    result += `[round(abs(zone${pointToLetter[i]}Progress) * ${len} / 100)], HudPosition.TOP, 2, Color.LIME_GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
    return result;
}