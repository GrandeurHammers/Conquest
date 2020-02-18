var pointToLetter = ['A', 'B', 'C'];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var result = "";
var subtextKeys = [
    {
        "key": "subtext_spec",
        "specVis": "ALWAYS",
        "players": "null"
    },
    {
        "key": "subtext_Team1",
        "specVis": "NEVER",
        "players": "getPlayers(Team.1)"
    },
    {
        "key": "subtext_Team2",
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
                "subtitle": `"Neutral"`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitle": `"Progress: {}%"`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitle": `"Progress: {}%"`
            }
        ]
    },
    {
        "zoneControl": "Team.1",
        "headerColor": "TEAM_1",
        "subtext_spec": "\"{} Control\".format(Team.1)",
        "subtext_Team1": "\"Defend Zone\"",
        "subtext_Team2": "\"Attack Zone\"",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitle": `""`
            },
            {
                "progressCond": "< 0",
                "subtitleColor": "TEAM_2",
                "subtitle": `"Progress: {}%"`
            }
        ]
    },
    {
        "zoneControl": "Team.2",
        "headerColor": "TEAM_2",
        "subtext_spec": "\"{} Control\".format(Team.2)",
        "subtext_Team1": "\"Attack Zone\"",
        "subtext_Team2": "\"Defend Zone\"",
        "subtitles": [
            {
                "progressCond": "== 0",
                "subtitleColor": "WHITE",
                "subtitle": `""`
            },
            {
                "progressCond": "> 0",
                "subtitleColor": "TEAM_1",
                "subtitle": `"Progress: {}%"`
            }
        ]
    }
];
controls.forEach(function (control) {
    control.subtitles.forEach(function (subtitle, index) {
        result += `
@Rule "Zone ${pointToLetter[point]} HUD: ${control.zoneControl} ${index}"
@Event global
if not huntActive and zoneControl[${point}] == ${control.zoneControl} and ${zoneProgress} ${subtitle.progressCond}:
    wait(0.05, Wait.ABORT_WHEN_FALSE)
    if zone${pointToLetter[point]}HudText != []:`;
        for (var i = 0; i < subtextKeys.length; i++) {
            result += `
        destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
        }
        if ("subtext_all" in control) {
            result += `
    hudText(getAllPlayers(), "Zone ${pointToLetter[point]}", ${subtitle.subtitle}.format(floor(abs(${zoneProgress}))), ${control.subtext_all}, Position.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`;
            for (var i = 0; i < subtextKeys.length; i++) {
                result += `
    zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
            }
        } else  {
            subtextKeys.forEach(function (subtextKey, index2) {
                result += `
    hudText(${subtextKey.players}, "Zone ${pointToLetter[point]}", ${subtitle.subtitle}.format(floor(abs(${zoneProgress}))), ${control[subtextKey.key]}, Position.RIGHT, ${point + 1}, Color.${control.headerColor}, Color.${subtitle.subtitleColor}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${subtextKey.specVis})
    zone${pointToLetter[point]}HudText[${index2}] = getLastCreatedText()
    wait(0.33, Wait.ABORT_WHEN_FALSE)`;
            });
        }
    });
});
result;