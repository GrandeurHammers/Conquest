#!mainFile 'conquest.opy'

rule "# Zone A":
	@Event global
	@Disabled
	currScoreComp = false

generateChaserRules(0)
generateVisualUpdates(0)
colorFlashControl(0)

rule "# Zone B":
	@Event global
	@Disabled
	currScoreComp = false

generateChaserRules(1)
generateVisualUpdates(1)
colorFlashControl(1)

rule "# Zone C":
	@Event global
	@Disabled
	currScoreComp = false

generateChaserRules(2)
generateVisualUpdates(2)
colorFlashControl(2)