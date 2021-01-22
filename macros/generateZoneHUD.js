var result = "";
const numZones = 3;
const progressBarLen = 10;
const pointToLetter = ["A", "B", "C"];
const emptyChar = "　";
var fullChar = "▒";
const textGroups = [
    {
        "name":         "Team 1",
        "prefix":       "team1",
        "constant":     "Team.1",
        "compare":      ">",
    },
    {
        "name":         "Team 2",
        "prefix":       "team2",
        "constant":     "Team.2",
        "compare":      "<"
    }
]
for (let i = 0; i < numZones; i++) {
    let sortOrder = -3 + i;
    let zoneControl = `zoneControl[${i}]`;
    let zoneProgress = `zone${pointToLetter[i]}Progress`;
    textGroups.forEach(function (textGroup) {
        result += `\n\thudText(
            getPlayers(${textGroup.constant}) if not powerPlayActive else null,
            "{0} {1} ${pointToLetter[i]}".format(
                iconString(Icon.HALO) if ${zoneControl} == null else iconString(Icon.FLAG) if ${zoneControl} == ${textGroup.constant} else iconString(Icon.SKULL),
                l"Zone"
            ),
            ${progressBar(zoneProgress)} if ${zoneProgress} != 0 else (
                "Neutral${emptyChar.repeat(7)}" if ${zoneControl} == null else "${emptyChar.repeat(progressBarLen+1)}"
            ),
            (
                "{0} {1}".format(l"Capture", l"Zone") if ${zoneControl} == null else "{0} {1}".format(l"Defend", l"Zone") if ${zoneControl} == ${textGroup.constant} else "{0} {1}".format(l"Attack", l"Zone")
            ) if ${zoneProgress} == 0 else "{0}: {1}%".format(l"Ally" if ${zoneProgress} ${textGroup.compare} 0 else l"Enemy", floor(abs(${zoneProgress}))),
            HudPosition.RIGHT,
            ${sortOrder},
            zone${pointToLetter[i]}MainColor,
            zone${pointToLetter[i]}AltColor,
            zone${pointToLetter[i]}AltColor,
            HudReeval.VISIBILITY_STRING_AND_COLOR,
            SpecVisibility.NEVER
        )`;
        // result += `\n\tprogressBarHud(
        //     getPlayers(${textGroup.constant}) if not powerPlayActive else null,
        //     abs(${zoneProgress}),
        //     "Contested!" if ${nT1} > 0 and ${nT2} > 0 else "",
        //     HudPosition.RIGHT,
        //     ${sortOrder} + 0.25,
        //     Color.YELLOW if ${nT1} > 0 and ${nT2} > 0 else zone${pointToLetter[i]}AltColor,
        //     Color.WHITE,
        //     ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR,
        //     SpecVisibility.NEVER
        // )`;
    });
    
}
// Separator Lines
result += `
    #HUD Separator Lines`;
for (var i = 0; i < 2; i++) {
    result += `\n\thudSubtext(getAllPlayers() if not powerPlayActive else null, w"--------------", HudPosition.RIGHT, ${-2.5 + i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
}
console.log(result);
result;

function progressBar(zoneProgress) {
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