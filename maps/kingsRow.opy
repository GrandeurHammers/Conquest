rule "Setup Zones: King's Row":
    @Condition getCurrentMap() in [Map.KINGS_ROW, Map.KINGS_ROW_WINTER]
    # King's Row - Zone A
    zoneLocations[0] = vect(-46.36,-0.13,-33.02)
    zoneSizes[0] = 5
    zoneHeights[0] = 5
    zoneSpawns[0] = vect(-36.76, 2, -49.87)
    zoneSpawnRadii[0] = 3
    # King's Row - Zone B
    zoneLocations[1] = vect(-50.44,0.0,1.22)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    zoneSpawns[1] = vect(-59.35, 5.02, -11.78)
    zoneSpawnRadii[1] = 2
    # King's Row - Zone C
    zoneLocations[2] = vect(-89.72,0.86,-21.42)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = vect(-95.47, -2.5, -46.37)
    zoneSpawnRadii[2] = 3.9