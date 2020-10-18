#!mainFile "conquest.opy"

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

rule "Setup Zones: Blizzard World":
    @Event global
    @Condition getCurrentMap() in [Map.BLIZZ_WORLD, Map.BLIZZ_WORLD_WINTER]
    # Blizzard World - Zone A
    zoneLocations[0] = vect(-16.5, 1.91, 88.85)
    zoneSizes[0] = 5
    zoneHeights[0] = 5
    # Blizzard World - Zone B
    zoneLocations[1] = vect(-77, 4.88, 66.25)
    zoneSizes[1] = 3
    zoneHeights[1] = 5
    # Blizzard World - Zone C
    zoneLocations[2] = vect(-70, 0.6, 124)
    zoneSizes[2] = 5
    zoneHeights[2] = 5

rule "Setup Zones: Ilios":
    @Event global
    @Condition getCurrentMap() in [Map.ILIOS_LIGHTHOUSE, Map.ILIOS_RUINS, Map.ILIOS_WELL]
    switch getCurrentMap():
        case Map.ILIOS_LIGHTHOUSE:
            # Ilios Lighthouse - Zone A
            zoneLocations[0] = vect(290.2, -25.48, -88.77)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            # Ilios Lighthouse- Zone B
            zoneLocations[1] = vect(358.15, -25.64, -51.54)
            zoneSizes[1] = 5
            zoneHeights[1] = 5
            # Ilios Lighthouse- Zone C
            zoneLocations[2] = vect(336.43, -25.48, 22.89)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
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

rule "Setup Zones: Dorado":
    @Event global
    @Condition getCurrentMap() in [Map.DORADO]
    # Dorado - Zone A
    zoneLocations[0] = vect(108.94,11.01,-30.82)
    zoneSizes[0] = 3.3
    zoneHeights[0] = 3
    # Dorado - Zone B
    zoneLocations[1] = vect(141.64,10.0,3.07)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    # Dorado - Zone C
    zoneLocations[2] = vect(85.5,12.75,29.3)
    zoneSizes[2] = 5
    zoneHeights[2] = 5

rule "Setup Zones: King's Row":
    @Condition getCurrentMap() in [Map.KINGS_ROW, Map.KINGS_ROW_WINTER]
    # King's Row - Zone A
    zoneLocations[0] = vect(-46.36,-0.13,-33.02)
    zoneSizes[0] = 5
    zoneHeights[0] = 5
    # King's Row - Zone B
    zoneLocations[1] = vect(-50.44,0.0,1.22)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    # King's Row - Zone C
    zoneLocations[2] = vect(-89.72,0.86,-21.42)
    zoneSizes[2] = 5
    zoneHeights[2] = 5

rule "Setup Zones: ":
    #TODO