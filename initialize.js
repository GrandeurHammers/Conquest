var result = "";
var numPoints = 3;
const pointToLetter = ['A', 'B', 'C'];
// Initialize vars
result += `
    #Set up all points to have neither team controlling
    zoneControl = [null, null, null]
    #Initialize HUD IDs for each point`;
for (var i = 0; i < numPoints; i++) {
    result += `
    zone${pointToLetter[i]}HudText = [-1, -1, -1,"Capturing"]`;
}
for (var i = 0;  i < numPoints; i++) {
    // Generate Zone Progress Headers
    var visTo = `p for p in getLivingPlayers(Team.ALL) if (abs(zone${pointToLetter[i]}Progress) > 0 and %CONTEST%) and not powerPlayActive and distance(vect(p.getPosition().x, zoneLocations[${i}].y, p.getPosition().z), zoneLocations[${i}]) < zoneSizes[${i}] and p.getPosition().y - zoneLocations[${i}].y >= -0.5 and p.getPosition().y - zoneLocations[${i}].y < zoneHeights[${i}]`;
    var visToProgress = visTo.replace('%CONTEST%', `not (numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0)`);
    var visToContested = visTo.replace('%CONTEST%', `(numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0)`);
    // Generate Progress Bar
    result += `
    #Progress Bars for Zone ${pointToLetter[i]} - Visible to all living players within the radius during normal play when point has progress on it. First one is for non-contested, second one is for contested.
    ${progressBarHelper(i, visToProgress, false)}
    ${progressBarHelper(i, visToContested, true)}`;
    // Add Capturing/Contested undertext
    result += `
    hudSubtext([${visTo.replace('%CONTEST%', 'true')}], "{0} - {1}%".format(zone${pointToLetter[i]}HudText[3], floor(abs(zone${pointToLetter[i]}Progress))), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
}

result += `
    #HUD Separator Lines`;

// Generate Zone Separators
for (var i = 1; i <= 2; i++) {
    result += `
    hudSubtext(getAllPlayers(), w"-----------", HudPosition.RIGHT, ${-i - 0.5}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`
}

result += `
    #Add spacer for big messages
    hudSubtext(getAllPlayers(), " \r\r", HudPosition.TOP, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Score multiplier under scoreboard
    scoreMultipliers = [1, 1]
    #Team 1 score multiplier
    hudHeader(getPlayers(Team.1), "{0}  |  Multiplier  |  {1}".format(scoreMultipliers[0], scoreMultipliers[1]), HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    #Team 2 score multiplier
    hudHeader(getPlayers(Team.2), "{0}  |  Multiplier  |  {1}".format(scoreMultipliers[1], scoreMultipliers[0]), HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    #Power Play Timer - Visible when power play is active
    hudHeader([p for p in getAllPlayers() if powerPlayActive], "Power Play: {0}".format(ceil(powerPlayTimer)), HudPosition.TOP, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)`
console.log(result);
result;

function progressBarHelper(i, visTo, isContested) {
    // i: numerical index of zone
    // visTo: visibility conditions
    // isContested: whether to generate a contested header or not
    var len = 18;
    var emptyChar = "　";
    var fullChar = "▒";
    result = `hudHeader([${visTo}], [`;

    for (var bar = 0; bar <= len; bar++) {
        result += `"`;
        for (var place = 0; place < len; place++) {
            if (place < bar) {
                result += fullChar;
            } else {
                result += emptyChar;
            }
        }
        result += `"`;
        if (bar != len) {
            result += `, `;
        }
    }
    
    result += `][round(abs(zone${pointToLetter[i]}Progress) * ${len} / 100)], HudPosition.TOP, 4, Color.${isContested ? 'YELLOW' : 'LIME_GREEN'}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
    return result;
}