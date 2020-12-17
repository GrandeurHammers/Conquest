rule "Setup Zones: Lijang Tower":
	@Event global
	@Condition getCurrentMap() in [Map.LIJIANG_CONTROL_CENTER, Map.LIJIANG_CONTROL_CENTER_LNY, Map.LIJIANG_GARDEN, Map.LIJIANG_GARDEN_LNY, Map.LIJIANG_NIGHT_MARKET, Map.LIJIANG_NIGHT_MARKET_LNY]
    switch getCurrentMap():
        case Map.LIJIANG_CONTROL_CENTER:
        case Map.LIJIANG_CONTROL_CENTER_LNY:
            # Lijang Tower: Control Center - Zone A
            zoneLocations[0] = vect(48, 265, 329.15)
            zoneSizes[0] = 6
            zoneHeights[0] = 6
            zoneSpawns[0] = vect(60.5,266.5,343.5)
            zoneSpawnRadii[0] = 5
            # Lijang Tower: Control Center - Zone B
            zoneLocations[1] = vect(0, 267.33, 280)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = vect(0,270,265)
            zoneSpawnRadii[1] = 2
            # Lijang Tower: Control Center - Zone C
            zoneLocations[2] = vect(-48, 265, 329.15)
            zoneSizes[2] = 6
            zoneHeights[2] = 6
            zoneSpawns[2] = vect(-60.5,266.5,343.5)
            zoneSpawnRadii[2] = 5
            return
        case Map.LIJIANG_GARDEN:
        case Map.LIJIANG_GARDEN_LNY:
            # Lijang Tower: Garden - Zone A
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(65, 94, 150)
            zoneSpawnRadii[0] = 5
            # Lijang Tower: Garden - Zone B
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = vect(0, 96, 116)
            zoneSpawnRadii[1] = 5
            # Lijang Tower: Garden - Zone C
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(-65, 94, 150)
            zoneSpawnRadii[2] = 5
            return
        case Map.LIJIANG_NIGHT_MARKET:
        case Map.LIJIANG_NIGHT_MARKET_LNY:
            # Lijang Tower: Night Market - Zone A
            zoneLocations[0] = vect(62, 2, -29)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(78.5, 3.5, -32)
            zoneSpawnRadii[0] = 5
            # Lijang Tower: Night Market - Zone B
            zoneLocations[1] = vect(1, -1, -61)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = vect(0, -1, -74)
            zoneSpawnRadii[1] = 2
            # Lijang Tower: Night Market - Zone C
            zoneLocations[2] = vect(-60, 2, -29)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(-76, 3.5, -31.5)
            zoneSpawnRadii[2] = 5
            return