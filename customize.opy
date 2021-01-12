#!mainFile "conquest.opy"
# NOTE: OverPy currently compiles CRLF and LF differently. Extra newlines are added to the action comments when it is in CRLF, so please set the line endings to LF.

rule "Game Settings":
	@Event global
    # How many points a team must score to win.
    # Default: 100
    #IMPORTANT: This does not automatically update the in-game scoreboard. In order for the scoreboard to display properly, the host must change "Settings > Modes > Score to Win" to match this value.
    scoreToWin = createWorkshopSetting(int<1:200>, "Game Settings", "Score To Win - should match \"Modes > TDM > Score to Win\" value", 100, 0)
    # Will Overtime be triggered if regulation time runs out with both teams at the same score?
    # Default: True
    overtimeEnabled = createWorkshopSetting(bool, "Game Settings", "Overtime Enabled", true, 1)
    # The minimum amount of time a player will remain dead, in seconds.
    # Default: 3
    minRespawnTime = createWorkshopSetting(float<1:30>, "Game Settings", "Minimum Respawn Time", 5, 2)
    # The maximum amount of time a player can remain dead, in seconds.
    # Default: 12
    maxRespawnTime = createWorkshopSetting(float<1:30>, "Game Settings", "Maximum Respawn Time", 12, 3)
    # Are spawns random, set at A and C, or dynamic based on control status?
    # Default: Dynamic
    spawnBehavior = createWorkshopSetting(enum["Random", "Static", "Dynamic"], "Game Settings", "Respawn Locations", RespawnLocations.DYNAMIC, 4)
    # Do respawn timings attempt to spawn players in waves, or are respawn timings static?
    spawnTimings = createWorkshopSetting(enum["Static", "Waves"], "Game Settings", "Respawn Timings", RespawnTimings.WAVES, 5)

rule "Capture Rate Customization":
    @Event global
    #Capture rate is calculated as follows: 
    #captureRatePerPlayer * min(# of capturing players, maxPlayerRate) + baseCaptureRate
    #
    #The base capture rate of a zone, which does not vary based on the number of players
    # Default: 4%/s
    baseCaptureRate = createWorkshopSetting(float<0:20>, "Capture Rate Settings", "Base Capture Rate", 4)
    # The amount of capture progress per second contributed by each capturing player
    # Default: 2%/player/s
    captureRatePerPlayer = createWorkshopSetting(float<0:20>, "Capture Rate Settings", "Capture Rate Per Player", 2)
    # Determines the maximum number of capturing players at which adding more capturing players will have no effect
    # Default: 6
    maxPlayerRate = createWorkshopSetting(int<1:6>, "Capture Rate Settings", "Maximum Capturing Players per Zone", 6)
    # Determines if capture rate scales with team size
    # Default: True
    adaptiveCaptureRate = createWorkshopSetting(bool, "Capture Rate Settings", "Adaptive Capture Rate", true)

rule "Power Play Customization":
    @Event global
    # Whether or not Power Play can be triggered when a team caps all 3 zones
    # Default: True
    powerPlayEnabled = createWorkshopSetting(bool, "Power Play Settings", "Enabled", true, 0)
    # How long a Power Play should last for at most (seconds)
    # Default: 30
    powerPlayDuration = createWorkshopSetting(float<5:60>, "Power Play Settings", "Duration", 30, 1)
    # Whether the targeted team has markers above their heads during Power Play
    # Default: True
    powerPlayMarkers = createWorkshopSetting(bool, "Power Play Settings", "Player Markers", true, 2)