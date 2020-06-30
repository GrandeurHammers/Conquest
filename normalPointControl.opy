#!mainFile 'conquest.opy'

rule "# Zone A":
	@Event global
	@Disabled
	asdf = false

generateChaserRules(0)
generateVisualUpdates(0)

rule "# Zone B":
	@Event global
	@Disabled
	asdf = false

generateChaserRules(1)
generateVisualUpdates(1)

rule "# Zone C":
	@Event global
	@Disabled
	asdf = false

generateChaserRules(2)
generateVisualUpdates(2)