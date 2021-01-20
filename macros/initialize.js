var result = "";
var numPoints = 3;
const pointToLetter = ['A', 'B', 'C'];
// Initialize vars
result += `
    #Set up all zones to have neither team controlling
    zoneControl = [null, null, null]
    #Start Team 1 at Zone A and Team 2 at Zone C
    currTeamSpawns = [0,2]
    # Initialize all colors to white
    zoneAMainColor = Color.WHITE
    zoneAAltColor = Color.WHITE
    zoneBMainColor = Color.WHITE
    zoneBAltColor = Color.WHITE
    zoneCMainColor = Color.WHITE
    zoneCAltColor = Color.WHITE
    #Initialize HUD IDs for each point`;
for (var i = 0;  i < numPoints; i++) {
    // Generate Zone Progress Headers
    var visTo = `p for p in getLivingPlayers(Team.ALL) if (abs(zone${pointToLetter[i]}Progress) > 0 and %CONTEST%) and not powerPlayActive and isWithinZoneBounds(p, ${i})`;
    var visToProgress = visTo.replace('%CONTEST%', `not (numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0)`);
    var visToContested = visTo.replace('%CONTEST%', `(numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0)`);
    // Generate Progress Bar
    result += `
    #Progress Bars for Zone ${pointToLetter[i]} - Visible to all living players within the radius during normal play when point has progress on it. First one is for non-contested, second one is for contested.
    ${progressBarHelper(i, visToProgress, false)}
    ${progressBarHelper(i, visToContested, true)}`;
    // Add Capturing/Contested undertext
    result += `
    #Subtitle for progress bars
    hudSubtext([${visTo.replace('%CONTEST%', 'true')}], "{0} - {1}%".format("Contested" if numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0 else "Capturing", floor(abs(zone${pointToLetter[i]}Progress))), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
}

// Separator Lines
result += `
    #HUD Separator Lines`;
for (var i = 0; i < 2; i++) {
    result += `\t\nhudSubtext(getAllPlayers(), w"--------------", HudPosition.RIGHT, ${-2.5 + i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
    result += `\t\nhudSubtext(null, w"--------------", HudPosition.LEFT, ${-2.5 + i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`;
}

// Info HUD which explains bonus points
result += `
    #Explanation HUD`;
let teams = ['Team.1', 'Team.2'];
teams.forEach(function (team) {
    let pointsControlled = `len([control for control in zoneControl if control == ${team}])`;
    result += `
    hudHeader(getPlayers(${team}), "{0}{1} = +{2} {3}/{4}".format(${pointsControlled}, iconString(Icon.FLAG), max(${pointsControlled}, 1), l"Point" if max(${pointsControlled}, 1) == 1 else l"Points", l"Kill"), HudPosition.TOP, 0.5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
});
// Spectator HUD: show zones controlled by both teams
let specFormatArgs = [];
teams.forEach(function (team) {
    for (let point = 0; point < 3; point++) {
        specFormatArgs.push(`"${pointToLetter[point]}" if zoneControl[${point}] == ${team} else "-"`);
    }
});
result += `
hudSubtext(null, "{0}  {1}  {2} | Zones Controlled | {3}  {4}  {5}".format(${specFormatArgs.join(",")}), HudPosition.TOP, 0.4, Color.WHITE, HudReeval.STRING, SpecVisibility.ALWAYS)`;

result += `
    #Power Play Timer - Visible when power play is active
    progressBarHud(getAllPlayers() if powerPlayActive else null, powerPlayTimer / powerPlayDuration * 100, "Power Play", HudPosition.TOP, 3, Color.WHITE, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)`
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