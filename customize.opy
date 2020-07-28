#!mainFile "conquest.opy"
# NOTE: OverPy currently compiles CRLF and LF differently. Extra newlines are added to the action comments when it is in CRLF, so please set the line endings to LF.

rule "Game Settings":
	@Event global
    #How many points a team must score to win.
    # Default: 100
    #IMPORTANT: This does not automatically update the in-game scoreboard. In order for the scoreboard to display properly, the host must change "Settings > Modes > Score to Win" to match this value.
    scoreToWin = __workshopSettingInteger__("Game Settings", "Score To Win - should match \"Modes > TDM > Score to Win\" value", 100, 1, 200)
    #Will Overtime be triggered if regulation time runs out with both teams at the same score?
    # Default: True
    overtimeEnabled = __workshopSettingToggle__("Game Settings", "Overtime Enabled", true)
    # The minimum amount of time a player will remain dead, in seconds.
    # Default: 8
    minRespawnTime = __workshopSettingInteger__("Game Settings", "​Minimum Respawn Time", 8, 1, 30)
    # The maximum amount of time a player can remain dead, in seconds.
    # Default: 16
    maxRespawnTime = __workshopSettingInteger__("Game Settings", "​​Maximum Respawn Time", 16, 1, 30)

rule "Capture Rate Customization":
    @Event global
    #Capture rate is calculated as follows: 
    #captureRatePerPlayer * min(# of capturing players, maxPlayerRate) + baseCaptureRate
    #
    #The base capture rate of a zone, which does not vary based on the number of players
    # Default: 4%/s
    baseCaptureRate = __workshopSettingReal__("Capture Rate Settings", "Base Capture Rate", 4, 0, 20)
    # The amount of capture progress per second contributed by each capturing player
    # Default: 2%/player/s
    captureRatePerPlayer = __workshopSettingReal__("Capture Rate Settings", "Capture Rate Per Player", 2, 0, 20)
    # Determines the maximum number of capturing players at which adding more capturing players will have no effect
    # Default: 6
    maxPlayerRate = __workshopSettingInteger__("Capture Rate Settings", "Maximum Capturing Players per Zone", 6, 1, 6)
    # Determines if capture rate scales with team size
    # Default: True
    adaptiveCaptureRate = __workshopSettingToggle__("Capture Rate Settings", "Adaptive Capture Rate", true)

rule "Power Play Customization":
    @Event global
    # Whether or not Power Play can be triggered when a team caps all 3 zones
    # Default: True
    powerPlayEnabled = __workshopSettingToggle__("Power Play Settings", "Enabled", true)
    # How long a Power Play should last for at most (seconds)
    # Default: 30
    powerPlayDuration = __workshopSettingReal__("Power Play Settings", "​Duration", 30, 5, 60)
    # Whether the targeted team has markers above their heads during Power Play
    # Default: True
    powerPlayMarkers = __workshopSettingToggle__("Power Play Settings", "​Player Markers", true)