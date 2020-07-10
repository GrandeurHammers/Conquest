#!mainFile "conquest.opy"
# NOTE: OverPy currently compiles CRLF and LF differently. Extra newlines are added to the action comments when it is in CRLF, so please set the line endings to LF.

rule "Game Settings":
	@Event global
    #How many points a team must score to win.
    # Default: 100
    #IMPORTANT: This does not automatically update the in-game scoreboard. In order for the scoreboard to display properly, the host must change "Settings > Modes > Score to Win" to match this value.
    scoreToWin = 100
    #Will Overtime be triggered if regulation time runs out with both teams at the same score?
    # Default: True
    overtimeEnabled = true

rule "Capture Rate Customization":
    @Event global
    #Capture rate is calculated as follows: 
    #captureRatePerPlayer * min(# of capturing players, maxPlayerRate) + baseCaptureRate
    #
    #The base capture rate of a zone, which does not vary based on the number of players
    # Default: 4%/s
    baseCaptureRate = 4
    # The amount of capture progress per second contributed by each capturing player
    # Default: 2%/player/s
    captureRatePerPlayer = 2
    # Determines the maximum number of capturing players at which adding more capturing players will have no effect
    # Default: 6
    maxPlayerRate = 6
    # Determines if capture rate scales with team size
    # Default: False
    adaptiveCaptureRate = false

rule "Power Play Customization":
    @Event global
    # Whether or not Power Play can be triggered when a team caps all 3 zones
    # Default: True
    powerPlayEnabled = true
    # How long a Power Play should last for at most (seconds)
    # Default: 30
    powerPlayDuration = 30
    # Whether the targeted team has markers above their heads during Power Play
    # Default: True
    powerPlayMarkers = true