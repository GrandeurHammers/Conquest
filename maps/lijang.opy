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
            zoneSpawns[0] = [vect(60.7, 267.45, 353.12), vect(62.926, 267.45, 350.928), vect(65.152, 267.45, 348.736), vect(67.378, 267.45, 346.544), vect(69.604, 267.45, 344.352), vect(71.83, 267.45, 342.16)]
            # Lijang Tower: Control Center - Zone B
            zoneLocations[1] = vect(0, 267.33, 280)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = [vect(5.75, 270, 260.75), vect(9.5, 270, 262.915), vect(9.5, 270, 258.585), vect(-5.75, 270, 260.75), vect(-9.5, 270, 262.915), vect(-9.5, 270, 258.585)]
            # Lijang Tower: Control Center - Zone C
            zoneLocations[2] = vect(-48, 265, 329.15)
            zoneSizes[2] = 6
            zoneHeights[2] = 6
            zoneSpawns[2] = [vect(-60.7, 267.51, 353.12), vect(-62.926, 267.51, 350.928), vect(-65.152, 267.51, 348.736), vect(-67.378, 267.51, 346.544), vect(-69.604, 267.51, 344.352), vect(-71.83, 267.51, 342.16)]
            return
        case Map.LIJIANG_GARDEN:
        case Map.LIJIANG_GARDEN_LNY:
            # Lijang Tower: Garden - Zone A
            zoneLocations[0] = vect(31.69, 94, 170)
            zoneSizes[0] = 5
            zoneHeights[0] = 3.5
            zoneSpawns[0] = [vect(58.0, 94, 168.75), vect(58.0, 94, 166.934), vect(58.0, 94, 165.118), vect(58.0, 94, 163.302), vect(58.0, 94, 161.486), vect(58.0, 94, 159.67)]
            # Lijang Tower: Garden - Zone B
            zoneLocations[1] = vect(0, 94.15, 135.95)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = [vect(-7.21, 96, 112.33), vect(-7.21, 96, 115.915), vect(-7.21, 96, 119.5), vect(7.21, 96, 112.33), vect(7.21, 96, 115.915), vect(7.21, 96, 119.5)]
            # Lijang Tower: Garden - Zone C
            zoneLocations[2] = vect(-31.69, 94, 170)
            zoneSizes[2] = 5
            zoneHeights[2] = 3.5
            zoneSpawns[2] = [vect(-58.0, 94, 168.75), vect(-58.0, 94, 166.934), vect(-58.0, 94, 165.118), vect(-58.0, 94, 163.302), vect(-58.0, 94, 161.486), vect(-58.0, 94, 159.67)]
            return
        case Map.LIJIANG_NIGHT_MARKET:
        case Map.LIJIANG_NIGHT_MARKET_LNY:
            # Lijang Tower: Night Market - Zone A
            zoneLocations[0] = vect(36.5, -0.14, -28)
            zoneSizes[0] = 5
            zoneHeights[0] = 5
            zoneSpawns[0] = [vect(77.0, 3.5, -34.57), vect(77.0, 3.5, -31.148), vect(77.0, 3.5, -27.726), vect(77.0, 3.5, -24.304), vect(77.0, 3.5, -20.882), vect(77.0, 3.5, -17.46)]
            # Lijang Tower: Night Market - Zone B
            zoneLocations[1] = vect(1, -1, -61)
            zoneSizes[1] = 7
            zoneHeights[1] = 7
            zoneSpawns[1] = [vect(7.0, -2, -81.42), vect(4.6, -2, -81.42), vect(2.2, -2, -81.42), vect(-0.2, -2, -81.42), vect(-2.6, -2, -81.42), vect(-5.0, -2, -81.42)]
            # Lijang Tower: Night Market - Zone C
            zoneLocations[2] = vect(-34.5, -0.14, -28)
            zoneSizes[2] = 5
            zoneHeights[2] = 5
            zoneSpawns[2] = [vect(-75, 3.5, -16.72), vect(-75, 3.5, -20.412), vect(-75, 3.5, -24.104), vect(-75, 3.5, -27.796), vect(-75, 3.5, -31.488), vect(-75, 3.5, -35.18)]
            return