rule "Setup Zones: Dorado":
    @Event global
    @Condition getCurrentMap() in [Map.DORADO]
    # Dorado - Zone A
    zoneLocations[0] = vect(125.94, 8, -20.70)
    zoneSizes[0] = 6
    zoneHeights[0] = 9
    zoneSpawns[0] = [vect(112.11, 11.01, -32.33), vect(109.64, 11.01, -29.18), vect(107.17, 11.01, -26.03), vect(109.47, 11.01, -34.37), vect(107.0, 11.01, -31.22), vect(104.53, 11.01, -28.07)]
    # Dorado - Zone B
    zoneLocations[1] = vect(131.09,11.05,26.15)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    zoneSpawns[1] = [vect(137.0, 14.01, 53.37), vect(137.887, 14.01, 50.457), vect(138.773, 14.01, 47.543), vect(139.66, 14.01, 44.63), vect(132.89, 13.07, 52.42), vect(129.26, 12.01, 51.22)]
    # Dorado - Zone C
    zoneLocations[2] = vect(85.5,12.75,29.3)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = [vect(70.25, 14.01, 13.66), vect(68.25, 14.01, 16.11), vect(66.25, 14.01, 18.56), vect(67.27, 14.01, 11.32), vect(65.27, 14.01, 13.77), vect(63.27, 14.01, 16.22)]
