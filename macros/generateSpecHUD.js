var result = `\n\nrule "Manage Spectator HUD: Create when not Power Play and destroy during power play":`;
result += `\n\t@Condition not powerPlayActive`;
const pointToLetter = ["A", "B", "C"];
const emptyChar = "　";
const numZones = 3;
for (let i = 0; i < numZones; i++) {
    let sortOrder = -3 + i;
    let zoneProgress = `zone${pointToLetter[i]}Progress`;
    result += `\n\thudText(
        null,
        "{0} {1} ${pointToLetter[i]}".format(iconString(Icon.FLAG), l"Zone"),
        "${emptyChar}" if ${zoneProgress} == 0 else "{0}: {1}%".format(Team.1 if ${zoneProgress} > 0 else Team.2, floor(abs(${zoneProgress}))),
        "{0}".format(Team.1) if zoneControl[${i}] == Team.1 else "{0}".format(Team.2) if zoneControl[${i}] == Team.2 else "Neutral",
        HudPosition.LEFT,
        ${sortOrder},
        zone${pointToLetter[i]}MainColor,
        zone${pointToLetter[i]}AltColor,
        zone${pointToLetter[i]}AltColor,
        HudReeval.VISIBILITY_STRING_AND_COLOR,
        SpecVisibility.ALWAYS
    )`;
    result += `\n\tspecTextIds.append(getLastCreatedText())`;
}
// Separator Lines
result += `
    #HUD Separator Lines`;
for (var i = 0; i < 2; i++) {
    result += `\n\thudSubtext(null, w"--------------", HudPosition.LEFT, ${-2.5 + i}, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)`;
    result += `\n\tspecTextIds.append(getLastCreatedText())`;
}
result += `\n\twaitUntil(powerPlayActive, 1000000)`;
result += `\n\tfor i in range(0, len(specTextIds)):`;
result += `\n\t\tdestroyHudText(specTextIds[i])`;

console.log(result);
result;