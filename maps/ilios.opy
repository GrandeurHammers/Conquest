rule "Setup Zones: Ilios":
    @Event global
    @Condition getCurrentMap() in [Map.ILIOS_LIGHTHOUSE, Map.ILIOS_RUINS, Map.ILIOS_WELL]
    switch getCurrentMap():
        case Map.ILIOS_LIGHTHOUSE:
            # Ilios Lighthouse - Zone A
            zoneLocations[0] = vect(300.34, -24.64, -66.94)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(290.2, -25.48, -88.77)
            zoneSpawnRadii[0] = 5
            # Ilios Lighthouse- Zone B
            zoneLocations[1] = vect(358.15, -25.64, -51.54)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(367.83, -28.64, -55.95)
            zoneSpawnRadii[1] = 3.5
            # Ilios Lighthouse- Zone C
            zoneLocations[2] = vect(328, -24.64, 0.38)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(336.43, -25.48, 22.89)
            zoneSpawnRadii[2] = 5
            return
        case Map.ILIOS_RUINS:
            # Ilios Ruins - Zone A
            zoneLocations[0] = vect(80.55, 58.37, -156.66)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(103.70, 60.37, -156.66)
            zoneSpawnRadii[0] = 3
            # Ilios Ruins - Zone B
            zoneLocations[1] = vect(28.39, 57.37, -157.37)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(28.5, 60.37, -177.5)
            zoneSpawnRadii[1] = 4
            # Ilios Ruins - Zone C
            zoneLocations[2] = vect(-23.64, 58.37, -156.66)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(-47.93, 60.37, -156.66)
            zoneSpawnRadii[2] = 3
            return
        case Map.ILIOS_WELL:
            # Ilios Well - Zone A
            zoneLocations[0] = vect(-280.88, -3.3, 38.45)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneLocations[0] = vect(-258, -5, 12.73)
            zoneSpawns[0] = vect(-280.88, -3.3, 38.45)
            zoneSpawnRadii[0] = 5
            # Ilios Well - Zone B
            zoneLocations[1] = vect(-196.3, 1, -4.28)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(-219.01, 0, -27.06)
            zoneSpawnRadii[1] = 4
            # Ilios Well - Zone C
            zoneLocations[2] = vect(-154.25, -3.41, -88.82)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneLocations[2] = vect(-179.37, -5, -66.05)
            zoneSpawns[2] = vect(-154.25, -3.41, -88.82)
            zoneSpawnRadii[2] = 5
            return