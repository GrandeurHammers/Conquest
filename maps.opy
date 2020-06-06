#!mainFile "conquest.opy"

rule "Setup Zones: Lijang Tower":
	@Event global
	@Condition getCurrentMap() in [Map.LIJIANG_CONTROL_CENTER, Map.LIJIANG_CONTROL_CENTER_LNY, Map.LIJIANG_GARDEN, Map.LIJIANG_GARDEN_LNY, Map.LIJIANG_NIGHT_MARKET, Map.LIJIANG_NIGHT_MARKET_LNY]
    switch getCurrentMap():
        case Map.LIJIANG_CONTROL_CENTER:
        case Map.LIJIANG_CONTROL_CENTER_LNY:
            # Zone A
            zoneLocations[0] = vect(48, 265, 329.15)
            zoneSizes[0] = 6
            zoneHeights[0] = 6
            # Zone B
            zoneLocations[1] = vect(0, 267.33, 280)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            # Zone C
            zoneLocations[2] = vect(-48, 265, 329.15)
            zoneSizes[2] = 6
            zoneHeights[2] = 6
            return
        case Map.LIJIANG_GARDEN:
        case Map.LIJIANG_GARDEN_LNY:
            # Zone A
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Zone B
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            # Zone C
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.LIJIANG_NIGHT_MARKET:
        case Map.LIJIANG_NIGHT_MARKET_LNY:
            # Zone A
            zoneLocations[0] = vect(62, 2, -29)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Zone B
            zoneLocations[1] = vect(1, -1, -61)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            # Zone C
            zoneLocations[2] = vect(-60, 2, -29)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return

rule "Setup Zones: Oasis":
    @Event global
    @Condition getCurrentMap() in [Map.OASIS_CITY_CENTER, Map.OASIS_GARDENS, Map.OASIS_UNIVERSITY]
    switch getCurrentMap():
        case Map.OASIS_CITY_CENTER:
            # Zone A
            zoneLocations[0] = vect(98.5, 0.85, 300)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Zone B
            zoneLocations[1] = vect(143.5, 2.15, 247.5)
            zoneSizes[1] = 4.5
            zoneHeights[1] = 5
            # Zone C
            zoneLocations[2] = vect(196.5, 0.85, 202.5)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.OASIS_GARDENS:
            # Zone A
            zoneLocations[0] = vect(101.5, 8, -287)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Zone B
            zoneLocations[1] = vect(121.255, 5.5, -227.48)
            zoneSizes[1] = 7
            zoneHeights[1] = 5
            # Zone C
            zoneLocations[2] = vect(180.85, 8, -207.85)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return
        case Map.OASIS_UNIVERSITY:
            # Zone A
            zoneLocations[0] = vect(-188, 18, 53.5)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Zone B
            zoneLocations[1] = vect(-210, 19, 0)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            # Zone C
            zoneLocations[2] = vect(-188, 18, -53.5)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            return