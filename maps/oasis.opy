rule "Setup Zones: Oasis":
    @Event global
    @Condition getCurrentMap() in [Map.OASIS_CITY_CENTER, Map.OASIS_GARDENS, Map.OASIS_UNIVERSITY]
    switch getCurrentMap():
        case Map.OASIS_CITY_CENTER:
            # Oasis: City Center - Zone A
            zoneLocations[0] = vect(98.5, 0.85, 300)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Oasis: City Center - Zone B
            zoneLocations[1] = vect(143.5, 2.15, 247.5)
            zoneSizes[1] = 4.5
            zoneHeights[1] = 5
            # Oasis: City Center - Zone C
            zoneLocations[2] = vect(196.5, 0.85, 202.5)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.OASIS_GARDENS:
            # Oasis: Gardens - Zone A
            zoneLocations[0] = vect(101.5, 8, -287)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Oasis: Gardens - Zone B
            zoneLocations[1] = vect(121.255, 5.5, -227.48)
            zoneSizes[1] = 7
            zoneHeights[1] = 5
            # Oasis: Gardens - Zone C
            zoneLocations[2] = vect(180.85, 8, -207.85)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.OASIS_UNIVERSITY:
            # Oasis: University - Zone A
            zoneLocations[0] = vect(-188, 18, 53.5)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Oasis: University - Zone B
            zoneLocations[1] = vect(-210, 19, 0)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            # Oasis: University - Zone C
            zoneLocations[2] = vect(-188, 18, -53.5)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return