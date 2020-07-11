let spacesAcross = 0;
var result = `hudHeader([p for p in eventPlayer if p.isDead()], "${"　".repeat(spacesAcross)}Respawning in {0}".format(ceil(eventPlayer.timeToRespawn)) if eventPlayer.respawnBuffered else "${"　".repeat(spacesAcross)}Press Jump to Respawn", `;
result += "HudPosition.TOP, 5, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)";
console.log(result);
result;