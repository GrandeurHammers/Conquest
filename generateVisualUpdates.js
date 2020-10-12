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
                "prefixAll": "iconString(Icon.EXCLAMATION_MARK)",
                "subtextAll": `"Unlocked"`,
                "subtextColor": "WHITE",
                "subtitleColor": "WHITE",
                "subtitleAll": `"Neutral${emptyChar.repeat(7)}"`
            },
            {
                "progressCond": "> 0",
                "prefixTeam1": "iconString(Icon.CHECKMARK)",
                "prefixTeam2": "iconString(Icon.CROSS)",
                "subtitleColor": "TEAM_1",
                "subtitleAll": `${progressBar()}`,
                "subtextColor": "TEAM_1",
                "subtextSpec": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
                "subtextTeam1": `"{0}: {1}%".format(l"Ally", floor(abs(${zoneProgress})))`,
                "subtextTeam2": `"{0}: {1}%".format(l"Enemy", floor(abs(${zoneProgress})))`
            },
            {
                "progressCond": "< 0",
                "prefixTeam1": "iconString(Icon.CROSS)",
                "prefixTeam2": "iconString(Icon.CHECKMARK)",
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
                "prefixTeam1": "iconString(Icon.FLAG)",
                "prefixTeam2": "iconString(Icon.SKULL)",
                "subtitleColor": "WHITE",
                "subtitleAll": `"${emptyChar.repeat(progressBarLen + 1)}"`,
                "subtextColor": "WHITE",
                "subtextSpec": `"{0}".format(Team.1)`,
                "subtextTeam1": `"Defend Zone"`,
                "subtextTeam2": `"Attack Zone"`
            },
            {
                "progressCond": "< 0",
                "prefixTeam1": "iconString(Icon.WARNING)",
                "prefixTeam2": "iconString(Icon.ASTERISK)",
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
                "prefixTeam1": "iconString(Icon.SKULL)",
                "prefixTeam2": "iconString(Icon.FLAG)",
                "subtitleColor": "WHITE",
                "subtitleAll": `"${emptyChar.repeat(progressBarLen + 1)}"`,
                "subtextColor": "WHITE",
                "subtextSpec": `"{0}".format(Team.2)`,
                "subtextTeam1": `"Attack Zone"`,
                "subtextTeam2": `"Defend Zone"`
            },
            {
                "progressCond": "> 0",
                "prefixTeam1": "iconString(Icon.ASTERISK)",
                "prefixTeam2": "iconString(Icon.WARNING)",
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

        let templateAction = `\n\thudText(%VIS%, "{0}Zone ${pointToLetter[point]}".format(%PREFIX%), %SUBTITLE%, %SUBTEXT%, HudPosition.%HUDPOS%, ${visInd}, Color.${control.headerColor}, Color.${subtitle.subtextColor}, Color.${subtitle.subtextColor}, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.%SPECVIS%)`;

        result += `\n\t# Create new zone HUD element(s) and store to zone's HUD text ID array`;
        if ("subtitleAll" in subtitle) {
            templateAction = templateAction.replace("%SUBTITLE%", subtitle.subtitleAll);
        }
        if ("subtextAll" in subtitle) {
            templateAction = templateAction.replace("%SUBTEXT%", subtitle.subtextAll);
        }

        visKeys.forEach(function (visData, index) {
            let finalAction = templateAction.replace("%VIS%", visData.players).replace("%HUDPOS%", visData.position).replace("%SPECVIS%", visData.specvis);
            // Set prefix
            if ("prefixKey" in visData) {
                finalAction = finalAction.replace("%PREFIX%", subtitle[visData.prefixKey]);
            } else if ("prefixValue" in visData) {
                finalAction = finalAction.replace("%PREFIX%", visData.prefixValue);
            } else {
                finalAction = finalAction.replace("%PREFIX%", "iconString(Icon.FLAG)");
            }
            // Set subtitle
            if (!("subtitleAll" in subtitle)) {
                finalAction = finalAction.replace("%SUBTITLE%", subtitle[visData.subtitleKey]);
            }
            // Set subtext
            if (!("subtextAll" in subtitle)) {
                finalAction = finalAction.replace("%SUBTEXT%", subtitle[visData.textKey]);
            }
            result += finalAction;
            result += `\n\tzone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
        });
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