rule "Setup Zones: Oasis":
    @Event global
    @Condition getCurrentMap() in [Map.OASIS_CITY_CENTER, Map.OASIS_GARDENS, Map.OASIS_UNIVERSITY]
    switch getCurrentMap():
        case Map.OASIS_CITY_CENTER:
            # Oasis: City Center - Zone A
            zoneLocations[0] = vect(92, 0.85, 290.35)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(98.43, 1, 318.33)
            zoneSpawnRadii[0] = 3
            # Oasis: City Center - Zone B
            zoneLocations[1] = vect(143.5, 2.15, 247.5)
            zoneSizes[1] = 4.5
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(168.7, 4, 272.74)
            zoneSpawnRadii[1] = 3
            # Oasis: City Center - Zone C
            zoneLocations[2] = vect(186.55, 0.85, 196.17)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(214.43, 1, 202.03)
            zoneSpawnRadii[1] = 3
            return
        case Map.OASIS_GARDENS:
            # Oasis: Gardens - Zone A
            zoneLocations[0] = vect(101.5, 8, -287)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(79.6, 5.49, -259.37)
            zoneSpawnRadii[0] = 3
            # Oasis: Gardens - Zone B
            zoneLocations[1] = vect(121.255, 5.5, -227.48)
            zoneSizes[1] = 7
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(111.23, 11.5, -217.43)
            zoneSpawnRadii[1] = 3
            # Oasis: Gardens - Zone C
            zoneLocations[2] = vect(180.85, 8, -207.85)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(153, 5.49, -186)
            zoneSpawnRadii[2] = 3
            return
        case Map.OASIS_UNIVERSITY:
            # Oasis: University - Zone A
            zoneLocations[0] = vect(-175, 16, 54)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = vect(-210.87, 18, 63.96)
            zoneSpawnRadii[0] = 3.5
            # Oasis: University - Zone B
            zoneLocations[1] = vect(-188, 15, 0)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            zoneSpawns[1] = vect(-210, 19, 0)
            zoneSpawnRadii[1] = 3
            # Oasis: University - Zone C
            zoneLocations[2] = vect(-175, 16, -54)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = vect(-210.87, 18,-63.96)
            zoneSpawnRadii[2] = 3.5
            return