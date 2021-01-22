#!mainFile 'conquest.opy'

rule "# Zone A":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(0)
generateHudUpdates(0)

rule "# Zone B":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(1)
generateHudUpdates(1)

rule "# Zone C":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(2)
generateHudUpdates(2)
