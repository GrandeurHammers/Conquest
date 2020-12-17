rule "Setup Zones: Dorado":
    @Event global
    @Condition getCurrentMap() in [Map.DORADO]
    # Dorado - Zone A
    zoneLocations[0] = vect(108.94,11.01,-30.82)
    zoneSizes[0] = 3.3
    zoneHeights[0] = 3
    # Dorado - Zone B
    zoneLocations[1] = vect(141.64,10.0,3.07)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    # Dorado - Zone C
    zoneLocations[2] = vect(85.5,12.75,29.3)
    zoneSizes[2] = 5
    zoneHeights[2] = 5