rule "Setup Zones: Oasis":
    @Event global
    @Condition getCurrentMap() in [Map.OASIS_CITY_CENTER, Map.OASIS_GARDENS, Map.OASIS_UNIVERSITY]
    switch getCurrentMap():
        case Map.OASIS_CITY_CENTER:
            # Oasis: City Center - Zone A
            zoneLocations[0] = vect(125.16, 1.85, 291.32)
            zoneSizes[0] = 6
            zoneHeights[0] = 5
            zoneSpawns[0] = [vect(90.85, 1, 298.71), vect(91.432, 1, 296.424), vect(92.014, 1, 294.138), vect(92.596, 1, 291.852), vect(93.178, 1, 289.566), vect(93.76, 1, 287.28)]
            # Oasis: City Center - Zone B
            zoneLocations[1] = vect(128.3, 4, 232.3)
            zoneSizes[1] = 4
            zoneHeights[1] = 5
            zoneSpawns[1] = [vect(145.22, 4, 215.06), vect(144.56, 4, 217.33), vect(143.9, 4, 219.6), vect(110.67, 4, 249.42), vect(113.065, 4, 248.725), vect(115.46, 4, 248.03)]
            # Oasis: City Center - Zone C
            zoneLocations[2] = vect(187.35, 1.85, 229.137)
            zoneSizes[2] = 6
            zoneHeights[2] = 5
            zoneSpawns[2] = [vect(169.19, 1, 194.39), vect(172.222, 1, 195.19), vect(175.254, 1, 195.99), vect(178.286, 1, 196.79), vect(181.318, 1, 197.59), vect(184.35, 1, 198.39)]
            return
        case Map.OASIS_GARDENS:
            # Oasis: Gardens - Zone A
            zoneLocations[0] = vect(87.54, 2.5, -248.35)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = [vect(99.025, 8, -284.525), vect(102.406, 8, -283.619), vect(104.881, 8, -286.094), vect(103.975, 8, -289.475), vect(100.594, 8, -290.381), vect(98.119, 8, -287.906)]
            # Oasis: Gardens - Zone B
            zoneLocations[1] = vect(141.21, 7.38, -247.45)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = [vect(147.16, 5.5, -275.69), vect(145.89, 5.5, -274.405), vect(144.62, 5.5, -273.12), vect(169.78, 5.5, -253.73), vect(169.065, 5.5, -252.365), vect(168.35, 5.5, -251.0)]
            # Oasis: Gardens - Zone C
            zoneLocations[2] = vect(142.13, 2.5, -193.38)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = [vect(178.375, 8, -205.375), vect(181.756, 8, -204.469), vect(184.231, 8, -206.944), vect(183.325, 8, -210.325), vect(179.944, 8, -211.231), vect(177.469, 8, -208.756)]
            return
        case Map.OASIS_UNIVERSITY:
            # Oasis: University - Zone A
            zoneLocations[0] = vect(-201.7, 15, 30)
            zoneSizes[0] = 6
            zoneHeights[0] = 5
            zoneSpawns[0] = [vect(-204.8, 18, 64.68), vect(-202.824, 18, 64.68), vect(-200.848, 18, 64.68), vect(-198.872, 18, 64.68), vect(-196.896, 18, 64.68), vect(-194.92, 18, 64.68)]
            # Oasis: University - Zone B
            zoneLocations[1] = vect(-172, 17, 0)
            zoneSizes[1] = 3.5
            zoneHeights[1] = 5
            zoneSpawns[1] = [vect(-206.55, 19, -5.0), vect(-206.55, 19, -3.0), vect(-206.55, 19, -1.0), vect(-206.55, 19, 1.0), vect(-206.55, 19, 3.0), vect(-206.55, 19, 5.0)]
            # Oasis: University - Zone C
            zoneLocations[2] = vect(-201.7, 15, -30)
            zoneSizes[2] = 6
            zoneHeights[2] = 5
            zoneSpawns[2] = [vect(-204.8, 18, -64.68), vect(-202.824, 18, -64.68), vect(-200.848, 18, -64.68), vect(-198.872, 18, -64.68), vect(-196.896, 18, -64.68), vect(-194.92, 18, -64.68)]
            return