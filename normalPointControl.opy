#!mainFile 'conquest.opy'

rule "# Point A":
	@Event global
	@Disabled
	return

generateChaserRules(0)
generateVisualUpdates(0)

rule "# Point B":
	@Event global
	@Disabled
	return

generateChaserRules(1)
generateVisualUpdates(1)

rule "# Point C":
	@Event global
	@Disabled
	return

generateChaserRules(2)
generateVisualUpdates(2)