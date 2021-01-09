let spacesAcross = 0;
var result = `hudHeader(eventPlayer if eventPlayer.isDead() else null, "${"　".repeat(spacesAcross)}Respawning in {0}".format(ceil(eventPlayer.timeToRespawn)), HudPosition.TOP, 5, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)`;
console.log(result);
result;