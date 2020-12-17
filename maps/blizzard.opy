rule "Setup Zones: Blizzard World":
    @Event global
    @Condition getCurrentMap() in [Map.BLIZZ_WORLD, Map.BLIZZ_WORLD_WINTER]
    # Blizzard World - Zone A
    zoneLocations[0] = vect(-16.5, 1.91, 88.85)
    zoneSizes[0] = 5
    zoneHeights[0] = 5
    # Blizzard World - Zone B
    zoneLocations[1] = vect(-77, 4.88, 66.25)
    zoneSizes[1] = 3
    zoneHeights[1] = 5
    # Blizzard World - Zone C
    zoneLocations[2] = vect(-70, 0.6, 124)
    zoneSizes[2] = 5
    zoneHeights[2] = 5