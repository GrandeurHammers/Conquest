rule "Setup Zones: Blizzard World":
    @Event global
    @Condition getCurrentMap() in [Map.BLIZZ_WORLD, Map.BLIZZ_WORLD_WINTER]
    # Blizzard World - Zone A
    zoneLocations[0] = vect(-16.5, 1.91, 88.85)
    zoneSizes[0] = 4
    zoneHeights[0] = 5
    zoneSpawns[0] = [vect(-15.87, 2, 66.0), vect(-18.26, 2, 68.6), vect(-20.65, 2, 71.2), vect(-16.37, 2, 63.0), vect(-18.76, 2, 65.6), vect(-21.15, 2, 68.2)]
    # Blizzard World - Zone B
    zoneLocations[1] = vect(-69.67, 5.5, 73.55)
    zoneSizes[1] = 4
    zoneHeights[1] = 3
    zoneSpawns[1] = [vect(-80.2, 0.25, 63.09), vect(-78.4, 0.25, 61), vect(-82.07, 0.25, 65.19), vect(-78.12, 0.25, 65.2), vect(-75.39, 0.25, 62.55), vect(-80.8, 0.25, 67.87)]
    # Blizzard World - Zone C
    zoneLocations[2] = vect(-70, 0.6, 124)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = [vect(-50.77, -0.25, 142.75), vect(-51.5, -0.25, 146.31), vect(-49.39, -0.25, 139.37), vect(-70.62, 1.75, 152.5), vect(-73.69, 1.75, 152), vect(-67.47,1.75, 153.87)]