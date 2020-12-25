rule "Setup Zones: Blizzard World":
    @Event global
    @Condition getCurrentMap() in [Map.BLIZZ_WORLD, Map.BLIZZ_WORLD_WINTER]
    # Blizzard World - Zone A
    zoneLocations[0] = vect(-16.5, 1.91, 88.85)
    zoneSizes[0] = 4
    zoneHeights[0] = 5
    zoneSpawns[0] = vect(-21, 2, 68)
    zoneSpawnRadii[0] = 2.5
    # Blizzard World - Zone B
    zoneLocations[1] = vect(-69.67, 5.5, 73.55)
    zoneSizes[1] = 4
    zoneHeights[1] = 3
    zoneSpawns[1] =  vect(-80.2, 0.25, 63.09)
    zoneSpawnRadii[1] = 3
    # Blizzard World - Zone C
    zoneLocations[2] = vect(-70, 0.6, 124)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = vect(-70.62, 1.75, 152.5)
    zoneSpawnRadii[2] = 4