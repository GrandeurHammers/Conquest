var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = "";
var visKeys = [
    {
        "textKey": "subtext_spec",
        "subtitleKey": "subtitle_spec",
        "specVis": "ALWAYS",
        "players": "null"
    },
    {
        "textKey": "subtext_Team1",
        "subtitleKey": "subtitle_Team1",
        "specVis": "NEVER",
        "players": "getPlayers(Team.1)"
    },
    {
        "textKey": "subtext_Team2",
        "subtitleKey": "subtitle_Team2",
        "specVis": "NEVER",
        "players": "getPlayers(Team.2)"
    }
];
var controls = [
    {
        "zoneControl": "null",
        "headerColor": "WHITE",
        "subtext_all": `"Unlocked"`,
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitle_all": `"Neutral"`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitle_spec": `"{0}: {1}%"`,
                "subtitle_Team1": `"Ally: {1}%"`,
                "subtitle_Team2": `"Enemy: {1}%"`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitle_spec": `"{0}: {1}%"`,
                "subtitle_Team1": `"Enemy: {1}%"`,
                "subtitle_Team2": `"Ally: {1}%"`
            }
        ]
    },
    {
        "zoneControl": "Team.1",
        "headerColor": "TEAM_1",
        "subtext_spec": "\"{}\".format(Team.1)",
        "subtext_Team1": "\"Defend Zone\"",
        "subtext_Team2": "\"Attack Zone\"",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitle_all": `""`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitle_spec": `"{0}: {1}%"`,
                "subtitle_Team1": `"Enemy: {1}%"`,
                "subtitle_Team2": `"Ally: {1}%"`
            }
        ]
    },
    {
        "zoneControl": "Team.2",
        "headerColor": "TEAM_2",
        "subtext_spec": "\"{}\".format(Team.2)",
        "subtext_Team1": "\"Attack Zone\"",
        "subtext_Team2": "\"Defend Zone\"",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitle_all": `""`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitle_spec": `"{0}: {1}%"`,
                "subtitle_Team1": `"Ally: {1}%"`,
                "subtitle_Team2": `"Enemy: {1}%"`
            }
        ]
    }
];
controls.forEach(function (control) {
    control.subtitles.forEach(function (subtitle) {
        result += `
@Rule "Zone ${pointToLetter[point]} HUD: Control ${control.zoneControl} | Progress ${subtitle.progressCond}"
@Event global
if not huntActive and zoneControl[${point}] == ${control.zoneControl} and ${zoneProgress} ${subtitle.progressCond}:
    if zone${pointToLetter[point]}HudText != []:`;
        for (var i = 0; i < visKeys.length; i++) {
            result += `
        destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
        }
        if ("subtext_all" in control && "subtitle_all" in subtitle) {
            result += `
    hudText(getAllPlayers(), "Zone ${pointToLetter[point]}", ${subtitle.subtitle_all}, ${control.subtext_all}, HudPosition.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`;
            for (var i = 0; i < visKeys.length; i++) {
                result += `
    zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
            }
        } else if ("subtext_all" in control) {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "Zone ${pointToLetter[point]}", ${subtitle[visData.subtitleKey]}.format(${control.zoneControl}, floor(abs(${zoneProgress}))), ${control.subtext_all}, HudPosition.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${visData.specVis})
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        } else if ("subtitle_all" in subtitle) {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "Zone ${pointToLetter[point]}", ${subtitle.subtitle_all}, ${control[visData.textKey]}, HudPosition.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${visData.specVis})
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        } else {
            visKeys.forEach(function (visData, index) {
                result += `
    hudText(${visData.players}, "Zone ${pointToLetter[point]}", ${subtitle[visData.subtitleKey]}.format(${control.zoneControl}, floor(abs(${zoneProgress}))), ${control[visData.textKey]}, HudPosition.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${visData.specVis})
    zone${pointToLetter[point]}HudText[${index}] = getLastCreatedText()`;
            });
        }
    });
});
result;