#!mainFile 'conquest.opy'

rule "# Zone A":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(0)

rule "# Zone B":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(1)

rule "# Zone C":
	@Event global
	@Disabled
	@Delimiter

generateChaserRules(2)