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
    #Init Spec Text ID trackers
    specTextIds = []
    #BUG WORKAROUND: Manually track when a team is about to win
    teamAboutToWin = [false, false]`;
for (let i = 0;  i < numPoints; i++) {
    let isContested = `numTeam1${pointToLetter[i]} > 0 and numTeam2${pointToLetter[i]} > 0`;
    // Generate Zone Progress Headers
    let visTo = `[p for p in getLivingPlayers(Team.ALL) if abs(zone${pointToLetter[i]}Progress) > 0 and not powerPlayActive and isWithinZoneBounds(p, ${i})]`;
    // Generate Progress Bar
    result += `\n\t#Progress Bars for Zone ${pointToLetter[i]} - Visible to all living players within the radius during normal play when point has progress on it.`;
    result += `\n\tprogressBarHud(
        ${visTo},
        abs(zone${pointToLetter[i]}Progress),
        "Contested!" if ${isContested} else "Capturing - {0}%".format(floor(abs(zone${pointToLetter[i]}Progress))),
        HudPosition.TOP,
        4,
        Color.ORANGE if ${isContested} else Color.WHITE,
        Color.WHITE,
        ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR,
        SpecVisibility.NEVER
    )`;
}

// Info HUD which explains bonus points
result += `
    #Explanation HUD`;
let teams = ['Team.1', 'Team.2'];
teams.forEach(function (team, i) {
    let pointsControlled = `len([control for control in zoneControl if control == ${team}])`;
    result += `
    hudHeader(getPlayers(${team}), "{0}{1} = +{2} {3}/{4}".format(${pointsControlled}, iconString(Icon.FLAG), max(${pointsControlled}, 1), l"Point" if max(${pointsControlled}, 1) == 1 else l"Points", l"Kill") if not teamAboutToWin[${i}] else "{0}: {1} {2}".format(l"Final Objective", l"Power", l"Play"), HudPosition.TOP, 0.5, Color.WHITE if not teamAboutToWin[${i}] else Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)`;
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