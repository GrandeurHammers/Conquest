// Params: 
// create (boolean) - True if creating, False if destroying

var result = "";
const numSlots = 6;
const teamData = [
    {
        'color': 'WHITE',
        'team': 'null'
    },
    {
        'color': 'TEAM_1',
        'team': 'Team.1'
    },
    {
        'color': 'TEAM_2',
        'team': 'Team.2'
    }
];
function teamGenerator(team) {
    for (var i = 0; i < numSlots; i++) {
        result += `
            createIcon([p for p in getAllPlayers() if entityExists(getPlayersInSlot(${i}, ${teamData[team]['team']})) and getPlayersInSlot(${i}, ${teamData[team]['team']}).isAlive()], getPlayersInSlot(${i}, ${teamData[team]['team']}), Icon.SKULL, IconReeval.VISIBILITY_AND_POSITION, Color.${teamData[team]['color']}, false)
            skullIcons[${i}] = getLastCreatedEntity()`;
    }
}

if (create) {
    result += `
        if zoneControl[0] == Team.1:`;
    teamGenerator(1);
    result += `
        else:`;
    teamGenerator(2);
} else {
    for (var i = 0; i < numSlots; i++) {
        result += `
        destroyIcon(skullIcons[${i}])`;
    }
}

result;