rule "Setup Zones: Ilios":
    @Event global
    @Condition getCurrentMap() in [Map.ILIOS_LIGHTHOUSE, Map.ILIOS_RUINS, Map.ILIOS_WELL]
    switch getCurrentMap():
        case Map.ILIOS_LIGHTHOUSE:
            # Ilios Lighthouse - Zone A
            zoneLocations[0] = vect(300.34, -24.64, -66.94)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = [vect(298.35, -25.47, -92.08), vect(295.09, -25.47, -90.756), vect(291.83, -25.47, -89.432), vect(288.57, -25.47, -88.108), vect(285.31, -25.47, -86.784), vect(282.05, -25.47, -85.46)]
            # Ilios Lighthouse- Zone B
            zoneLocations[1] = vect(358.15, -25.64, -51.54)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = [vect(360.85, -27.64, -18.02), vect(358.66, -27.64, -17.115), vect(356.47, -27.64, -16.21), vect(336.41, -27.64, -77.1), vect(334.229, -27.64, -76.174), vect(332.048, -27.64, -75.248)]
            # Ilios Lighthouse- Zone C
            zoneLocations[2] = vect(328, -24.64, 0.38)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = [vect(344.614, -25.47, 19.665), vect(341.34, -25.47, 20.955), vect(338.067, -25.47, 22.245), vect(334.793, -25.47, 23.535), vect(331.520, -25.47, 24.824), vect(328.246, -25.47, 26.115)]
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