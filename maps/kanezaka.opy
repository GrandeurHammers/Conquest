rule "Setup Zones: Kanezaka":
    @Event global
    @Condition getCurrentMap() in [Map.KANEZAKA]

    # Kanezaka - Zone A
    zoneLocations[0] = vect(-27.67, 5.84, 28.04)
    zoneSizes[0] = 5
    zoneHeights[0] = 3.95
    zoneSpawns[0] = [vect(-6, 8, 44), vect(-6, 8.15, 40.44), vect(-6, 9.65, 37.43), vect(-54.38, 8, 28.5), vect(-52.69, 8, 31.47), vect(-51.0, 8, 34.44)]
    # Kanezaka - Zone B
    zoneLocations[1] = vect(10, 7, -25)
    zoneSizes[1] = 4
    zoneHeights[1] = 5
    zoneSpawns[1] = [vect(5.38, 9, 1.64), vect(7.907, 9, 1.393), vect(10.433, 9, 1.147), vect(12.96, 9, 0.9), vect(0, 9, -47), vect(-3, 9.39, -44)]
    # Kanezaka - Zone C
    zoneLocations[2] = vect(-47.74, 11, -42.88)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = [vect(-37.10, 10, -28.53), vect(-34.58, 10, -31.19), vect(-45.42, 13, -23.5), vect(-57.66, 12, -23.5), vect(-30.24, 9, -54.17), vect(-30.24, 9, -52.22)]
