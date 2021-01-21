var result = "";
let teams = ['Team.1', 'Team.2'];
//BUG WORKAROUND: team score in HUDs does not evaluate properly
teams.forEach(function (team, i) {
    result += `\nrule "BUG WORKAROUND: Update Team ${i} about-to-win marker":`;
    result += `\n\t@Condition teamScore(${team}) + 1 >= scoreToWin`;
    result += `\n\t@Condition endRequiresPowerPlay`
    result += `\n\tteamAboutToWin[${i}] = true`;
});
console.log(result);
result;