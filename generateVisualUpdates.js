var pointToLetter = ['A', 'B', 'C'];
var visibleTo = ["null", "getPlayers(Team.1)", "getPlayers(Team.2)"];
var specVisibility = ["ALWAYS", "NEVER", "NEVER"];
var zoneProgress = `zone${pointToLetter[point]}Progress`;
var zeroBlankFillers = {
    "team1control": [
        { // spec
            "subheader": `"{}: 0%".format(Team.2)`,
            "subtext": `"{}".format(Team.1)`
        },
        { // team 1
            "subheader": `"Enemy: 0%"`,
            "subtext": `"Defend Zone"`
        },
        { // team 2
            "subheader": `"Ally: 0%"`,
            "subtext": `"Capture Zone"`
        }
    ],
    "team2control": [
        { // spec
            "subheader": `"{}: 0%".format(Team.1)`,
            "subtext": `"{}".format(Team.2)`
        },
        { // team 1
            "subheader": `"Ally: 0%"`,
            "subtext": `"Capture Zone"`
        },
        { // team 2
            "subheader": `"Enemy: 0%"`,
            "subtext": `"Defend Zone"`
        }
    ]
};
var notZeroBlankFillers = {
    "null_team1": [
        { // spec
            "subheader": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
            "subtext": `"Unlocked"`
        },
        { // team 1
            "subheader": `"Ally: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        },
        { // team 2
            "subheader": `"Enemy: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        }
    ],
    "null_team2": [
        { // spec
            "subheader": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
            "subtext": `"Unlocked"`
        },
        { // team 1
            "subheader": `"Enemy: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        },
        { // team 2
            "subheader": `"Ally: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        }
    ],
    "team1capping": [
        { // spec
            "subheader": `"{0}: {1}%".format(Team.1, floor(abs(${zoneProgress})))`,
            "subtext": `"Unlocked"`
        },
        { // team 1
            "subheader": `"Ally: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        },
        { // team 2
            "subheader": `"Enemy: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Defend Zone"`
        }
    ],
    "team2capping": [
        { // spec
            "subheader": `"{0}: {1}%".format(Team.2, floor(abs(${zoneProgress})))`,
            "subtext": `"Unlocked"`
        },
        { // team 1
            "subheader": `"Enemy: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Defend Zone"`
        },
        { // team 2
            "subheader": `"Ally: {}%".format(floor(abs(${zoneProgress})))`,
            "subtext": `"Capture Zone"`
        }
    ]
};

// Begin with listening for when zoneProgress hits 0 which happens when:
//   a) A point is reset to being uncaptured,
//   b) A point is captured by a team, or
//   c) A point is reset after being partially captured
var result = `
@Rule "Point ${pointToLetter[point]} Visuals: Listen for Progress Zero"
@Event global
if ${zoneProgress} == 0:`;
// Destroy current HUD text for this point
for (var i = 0; i < 3; i++) {
    result += `
    destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
}
// Special "everyone sees the same thing" case for a zero progress, no capture point
result += `
    switch zoneControl[${point}]:
        case null:
            hudText(getAllPlayers(), "Zone ${pointToLetter[point]}", "Neutral: 0%", "Unlocked", Position.RIGHT, ${point + 1}, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            zone${pointToLetter[point]}HudText[0] = getLastCreatedText()
            zone${pointToLetter[point]}HudText[1] = getLastCreatedText()
            zone${pointToLetter[point]}HudText[2] = getLastCreatedText()
            break
        case Team.1:`;
// Generate hudText for when Team 1 gains control
zeroBlankFillers.team1control.forEach(function (key, i) {
    result += `
            hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.TEAM_1, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
            zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
});

result += `
            break
        case Team.2:`;
// Generate hudText for when Team 2 gains control
zeroBlankFillers.team2control.forEach(function (key, i) {
    result += `
            hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.TEAM_2, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
            zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
});
result += `
            break`;

// Handle when a zoneProgress becomes non-zero
result += `
@Rule "Point ${pointToLetter[point]} Visuals: Listen for Not Zero"
@Event global
if abs(${zoneProgress}) > 0:`;
// Destroy current HUD text for this zone
for (var i = 0; i < 3; i++) {
    result += `
    destroyHudText(zone${pointToLetter[point]}HudText[${i}])`;
}

result += `
    switch zoneControl[${point}]:
        case null:
            if ${zoneProgress} > 0:`;

// When Team 1 is capping an uncaptured zone
notZeroBlankFillers.null_team1.forEach(function (key, i) {
    result += `
                hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.WHITE, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
                zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
});
result += `
            else:`;
// When Team 2 is capping an uncaptured zone
notZeroBlankFillers.null_team2.forEach(function (key, i) {
    result += `
                hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.WHITE, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
                zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
});
result += `
            break
        case Team.1:`;
// When Team 2 is capping a zone Team 1 controls
notZeroBlankFillers.team2capping.forEach(function (key, i) {
    result += `
            hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.TEAM_1, Color.TEAM_2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
            zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
})
result += `
            break
        case Team.2:`;
// When Team 1 is capping a zone Team 2 controls
notZeroBlankFillers.team1capping.forEach(function (key, i) {
    result += `
            hudText(${visibleTo[i]}, "Zone ${pointToLetter[point]}", ${key.subheader}, ${key.subtext}, Position.RIGHT, ${point + 1}, Color.TEAM_2, Color.TEAM_1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.${specVisibility[i]})
            zone${pointToLetter[point]}HudText[${i}] = getLastCreatedText()`;
});
result += `
            break`;
result;