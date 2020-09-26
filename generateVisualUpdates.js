if (typeof point === 'undefined') {
    var point = 0
}
var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = "";
var progressBarLen = 10;
var emptyChar = "　";
var fullChar = "▒";
var visKeys = [
    {
        "textKey": "subtextSpec",
        "subtitleKey": "subtitleSpec",
        "players": "null",
        "position": "LEFT",
        "specvis": "ALWAYS"
    },
    {
        "textKey": "subtextTeam1",
        "subtitleKey": "subtitleTeam1",
        "players": "getPlayers(Team.1)",
        "position": "RIGHT",
        "specvis": "NEVER"
    },
    {
        "textKey": "subtextTeam2",
        "subtitleKey": "subtitleTeam2",
        "players": "getPlayers(Team.2)",
        "position": "RIGHT",
        "specvis": "NEVER"
    }
];
const controls = [
    {
        "zoneControl": "null",
        "headerColor": "WHITE",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtextAll": `"Unlocked"`,
                "subtextColor": "WHITE",
                "subtitleColor": "WHITE",
                "subtitleAll": `"Neutral${emptyChar.repeat(7)}"`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitleAll": `${progressBar()}`,
                "subtextColor": "TEAM_1",
                "subtextSpec": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
                "subtextTeam1": `"{0}: {1}%".format(l"Ally", floor(abs(${zoneProgress})))`,
                "subtextTeam2": `"{0}: {1}%".format(l"Enemy", floor(abs(${zoneProgress})))`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitleAll": `${progressBar()}`,
                "subtextColor": "TEAM_2",
                "subtextSpec": `"{0}: {1}%".format(Team.2, floor(abs(${zoneProgress})))`,
                "subtextTeam1": `"{0}: {1}%".format(l"Enemy", floor(abs(${zoneProgress})))`,
                "subtextTeam2": `"{0}: {1}%".format(l"Ally", floor(abs(${zoneProgress})))`
            }
        ]
    },
    {
        "zoneControl": "Team.1",
        "headerColor": "TEAM_1",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitleAll": `"${emptyChar.repeat(progressBarLen + 1)}"`,
                "subtextColor": "WHITE",
                "subtextSpec": `"{0}".format(Team.1)`,
                "subtextTeam1": `"Defend Zone"`,
                "subtextTeam2": `"Attack Zone"`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitleAll": `${progressBar()}`,
                "subtextColor": "TEAM_2",
                "subtextSpec": `"{0}: {1}%".format(Team.2, floor(abs(${zoneProgress})))`,
                "subtextTeam1": `"{0}: {1}%".format(l"Enemy", floor(abs(${zoneProgress})))`,
                "subtextTeam2": `"{0}: {1}%".format(l"Ally", floor(abs(${zoneProgress})))`
            }
        ]
    },
    {
        "zoneControl": "Team.2",
        "headerColor": "TEAM_2",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitleAll": `"${emptyChar.repeat(progressBarLen + 1)}"`,
                "subtextColor": "WHITE",
                "subtextSpec": `"{0}".format(Team.2)`,
                "subtextTeam1": `"Attack Zone"`,
                "subtextTeam2": `"Defend Zone"`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitleAll": `${progressBar()}`,
                "subtextColor": "TEAM_1",
                "subtextSpec": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
                "subtextTeam1": `"{0}: {1}%".format(l"Ally", floor(abs(${zoneProgress})))`,
                "subtextTeam2": `"{0}: {1}%".format(l"Enemy", floor(abs(${zoneProgress})))`
            }
        ]
    }
];
var visInd = -3 + point;
controls.forEach(function (control) {
    control.subtitles.forEach(function (subtitle) {
        result += `
rule "Zone ${pointToLetter[point]} HUD: Control ${control.zoneControl} | Progress ${subtitle.progressCond}":
	@Event global
    @Condition not powerPlayActive
    @Condition zoneControl[${point}] == ${control.zoneControl}
    @Condition ${zoneProgress} ${subtitle.progressCond}
    # Remove existing zone huds
    if zone${pointToLetter[point]}HudText != []:`;

        for (var i = 0; i < visKeys.length; i++) {
            result += `
        destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
        }

        let templateAction = `
     hudText(%VIS%, "{0}Zone ${pointToLetter[point]}".format(iconString(Icon.FLAG)), %SUBTITLE%, %SUBTEXT%, HudPosition.%HUDPOS%, ${visInd}, Color.${control.headerColor}, Color.${subtitle.subtextColor}, Color.${subtitle.subtextColor}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.%SPECVIS%)`;

        result += `
    # Create new zone HUD element(s) and store to zone's HUD text ID array`;
        if ("subtextAll" in subtitle && "subtitleAll" in subtitle) {
            templateAction = templateAction.replace("%SUBTITLE%", subtitle.subtitleAll).replace("%SUBTEXT%", subtitle.subtextAll);

            result += templateAction.replace("%VIS%", "null").replace("%HUDPOS%", "LEFT").replace("%SPECVIS%", "ALWAYS");
            result += `\n\tzone${pointToLetter[point]}HudText[0] = getLastCreatedText()`;
            result += templateAction.replace("%VIS%", "getAllPlayers()").replace("%HUDPOS%", "RIGHT").replace("%SPECVIS%", "NEVER");
            for (var i = 1; i < visKeys.length; i++) {
                result += `
    zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
            }
        } else if ("subtextAll" in subtitle) {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "{0}Zone ${pointToLetter[point]}".format(iconString(Icon.FLAG)), ${subtitle[visData.subtitleKey]}, ${subtitle.subtextAll}, HudPosition.RIGHT, ${visInd}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.${subtitle.subtextColor}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        } else if ("subtitleAll" in subtitle) {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "{0}Zone ${pointToLetter[point]}".format(iconString(Icon.FLAG)), ${subtitle.subtitleAll}, ${subtitle[visData.textKey]}, HudPosition.RIGHT, ${visInd}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.${subtitle.subtextColor}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        } else {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "{0}Zone ${pointToLetter[point]}".format(iconString(Icon.FLAG)), ${subtitle[visData.subtitleKey]}, ${subtitle[visData.textKey]}, HudPosition.RIGHT, ${visInd}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.${subtitle.subtextColor}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        }
    });
});
console.log(result);
result;


function progressBar() {
    let result = `[`;

    for (let bar = 0; bar <= progressBarLen; bar++) {
        result += `"[`;
        for (let place = 0; place < progressBarLen; place++) {
            if (place < bar) {
                result += fullChar;
            } else {
                result += emptyChar;
            }
        }
        result += `]"`;
        if (bar != progressBarLen) {
            result += ', ';
        }
    }
    result += `][round(abs(${zoneProgress}) * ${progressBarLen} / 100)]`;
    return result;
}