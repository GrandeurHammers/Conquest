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
            zoneLocations[0] = vect(-4.8, 60.37, -174.63)
            zoneSizes[0] = 5
            zoneHeights[0] = 3
            zoneSpawns[0] = [vect(-18.64, 58.37, -156.66), vect(-21.14, 58.37, -152.33), vect(-26.14, 58.37, -152.33), vect(-28.64, 58.37, -156.66), vect(-26.14, 58.37, -160.990), vect(-21.14, 58.37, -160.990)]
            # Ilios Ruins - Zone B
            zoneLocations[1] = vect(28.5, 57.37, -144.88)
            zoneSizes[1] = 5
            zoneHeights[1] = 3
            zoneSpawns[1] = [vect(46.33, 60.37, -140.9), vect(46.33, 60.37, -143.78), vect(46.33, 60.37, -146.6), vect(10.67, 60.37, -140.9), vect(10.67, 60.37, -143.78), vect(10.67, 60.37, -146.6)]
            zoneSpawnRadii[1] = 4
            # Ilios Ruins - Zone C
            zoneLocations[2] = vect(61.8, 60.37, -174.63)
            zoneSizes[2] = 5
            zoneHeights[2] = 3
            zoneSpawns[2] = [vect(85.55, 58.37, -156.66), vect(83.05, 58.37, -152.33), vect(78.05, 58.37, -152.33), vect(75.55, 58.37, -156.66), vect(78.05, 58.37, -160.990), vect(83.05, 58.37, -160.990)]
            return
        case Map.ILIOS_WELL:
            # Ilios Well - Zone A
            zoneLocations[0] = vect(-280.88, -3.3, 38.45)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneLocations[0] = vect(-258, -5, 12.73)
            zoneSpawns[0] = [vect(-275.88, -3.3, 38.45), vect(-278.38, -3.3, 42.780127018922194), vect(-283.38, -3.3, 42.780127018922194), vect(-285.88, -3.3, 38.45), vect(-283.38, -3.3, 34.11987298107781), vect(-278.38, -3.3, 34.119872981077805)]
            # Ilios Well - Zone B
            zoneLocations[1] = vect(-196.3, 1, -4.28)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = [vect(-187.0, 5.01, -27.52), vect(-189.275, 5.01, -25.205), vect(-191.55, 5.01, -22.89), vect(-219.45, 5.01, 5.18), vect(-217.31, 5.01, 2.74), vect(-215.17, 5.01, 0.299)]
            # Ilios Well - Zone C
            zoneLocations[2] = vect(-154.25, -3.41, -88.82)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneLocations[2] = vect(-179.37, -5, -66.05)
            zoneSpawns[2] = [vect(-149.25, -3.3, -88.82), vect(-151.75, -3.3, -84.4898729810778), vect(-156.75, -3.3, -84.4898729810778), vect(-159.25, -3.3, -88.82), vect(-156.75, -3.3, -93.15012701892219), vect(-151.75, -3.3, -93.15012701892219)]
            return