if (typeof point === 'undefined') {
    var point = 0
}
var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = "";
var progressBarLen = 10;
var emptyChar = "　";
const prefixes = ["team1", "team2", "specs"];
var nT1 = `numTeam1${pointToLetter[point]}`;
var nT2 = `numTeam2${pointToLetter[point]}`;
const controlStates = [
    {
        "zoneControl":      "null",
        "name":             "Neutral",
        "mainColor":        "Color.WHITE",
        "subtitleAll":      `"Neutral"`,
        "progressStates": [
            {
                "progressCond":     "== 0",
                "altColor":         "Color.WHITE",
                "subtextSpecs":     `"Unlocked"`,
            },
            {
                "progressCond":     "> 0",
                "altColor":         "Color.TEAM_1",
                "subtextSpecs":     `"{0} Capturing".format(Team.1)`,
            },
            {
                "progressCond":     "< 0",
                "altColor":         "Color.TEAM_2",
                "subtextSpecs":     `"{0} Capturing".format(Team.2)`,
            }
        ]
    },
    {
        "zoneControl":      "Team.1",
        "name":             "Team 1",
        "mainColor":        "Color.TEAM_1",
        "subtitleTeam1":    `"{0} {1}".format(l"Ally", "Control")`,
        "subtitleTeam2":    `"{0} {1}".format(l"Enemy", "Control")`,
        "subtitleSpecs":    `"{0}".format(Team.1)`,
        "progressStates": [
            {
                "progressCond":     "== 0",
                "altColor":         "Color.WHITE",
                "subtextSpecs":     `"SHOWATKDEF"`,
            },
            {
                "progressCond":     "< 0",
                "altColor":         "Color.TEAM_2",
                "subtextSpecs":     `"SHOWATKDEF"`
            }
        ]
    },
    {
        "zoneControl":      "Team.2",
        "name":             "Team 2",
        "mainColor":        "Color.TEAM_2",
        "subtitleTeam1":    `"{0} {1}".format(l"Enemy", "Control")`,
        "subtitleTeam2":    `"{0} {1}".format(l"Ally", "Control")`,
        "subtitleSpecs":    `"{0}".format(Team.2)`,
        "progressStates": [
            {
                "progressCond":     "== 0",
                "altColor":         "Color.WHITE",
                "subtextSpecs":     `"{0} {1}".format(l"Current", l"Spawn") if currTeamSpawns[1] == ${point} else null`,
            },
            {
                "progressCond":     "> 0",
                "altColor":         "Color.TEAM_1",
                "subtextSpecs":     `"SHOWATKDEF"`
            }
        ]
    }
];

controlStates.forEach(function (cState) {
    /**
     * PROGRESS-AGNOSTIC RULE
     */
    result += `\n\nrule "Zone ${pointToLetter[point]} HUD: Update for ${cState.name} Control | Macro Handler":`;
    result += `\n\t@Condition zoneControl[${point}] == ${cState.zoneControl}`;
    result += `\n\tzone${pointToLetter[point]}MainColor = ${cState.mainColor}`;
    // Set subtitles
    if ("subtitleAll" in cState) {
        prefixes.forEach((p) => result += `\n\t${p}Zone${pointToLetter[point]}Text[TextKeys.SUBTITLE] = ${cState.subtitleAll}`);
    } else {
        prefixes.forEach(function (p) {
            let capitalVer = p.charAt(0).toUpperCase() + p.slice(1);
            result += `\n\t${p}Zone${pointToLetter[point]}Text[TextKeys.SUBTITLE] = ${cState["subtitle" + capitalVer]}`;
        });
    }
    /**
     * PROGRESS SENSITIVE RULES
     */
    cState.progressStates.forEach(function (pState) {
        result += `\n\nrule "Zone ${pointToLetter[point]} HUD: Update for ${cState.name} Control & Progress ${pState.progressCond}":`;
        result += `\n\t@Condition zoneControl[${point}] == ${cState.zoneControl}`;
        result += `\n\t@Condition ${zoneProgress} ${pState.progressCond}`;
        result += `\n\tzone${pointToLetter[point]}AltColor = ${pState.altColor}`;
        result += `\n\tspecsZone${pointToLetter[point]}Text[TextKeys.SUBTEXT] = ${pState.subtextSpecs}`;
    })
});

console.log(result);
result;