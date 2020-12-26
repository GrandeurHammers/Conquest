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
            zoneLocations[0] = vect(103, 60.37, -165.24)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Ilios Ruins - Zone B
            zoneLocations[1] = vect(28.39, 57.37, -157.37)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            # Ilios Ruins - Zone C
            zoneLocations[2] = vect(-49, 60.37, -165.24)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.ILIOS_WELL:
            # Ilios Well - Zone A
            zoneLocations[0] = vect(-280.88, -3.3, 38.45)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Ilios Well - Zone B
            zoneLocations[1] = vect(-196.3, 1, -4.28)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            # Ilios Well - Zone C
            zoneLocations[2] = vect(-154.25, -3.41, -88.82)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return