rule "Setup Zones: Dorado":
    @Event global
    @Condition getCurrentMap() in [Map.DORADO]
    # Dorado - Zone A
    zoneLocations[0] = vect(125.94, 8, -20.70)
    zoneSizes[0] = 6
    zoneHeights[0] = 9
    zoneSpawns[0] = vect(108.94,11.01,-30.82)
    zoneSpawnRadii[0] = 3.3
    # Dorado - Zone B
    zoneLocations[1] = vect(131.09,11.05,26.15)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    zoneSpawns[1] = vect(119.63, 11, 40.48)
    zoneSpawnRadii[1] = 4
    # Dorado - Zone C
    zoneLocations[2] = vect(67.9, 14, 15.93)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = vect(64.82, 17, 36.77)
    zoneSpawnRadii[2] = 1.7
