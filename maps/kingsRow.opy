rule "Setup Zones: King's Row":
    @Condition getCurrentMap() in [Map.KINGS_ROW, Map.KINGS_ROW_WINTER]
    # King's Row - Zone A
    zoneLocations[0] = vect(-55.55, -0.34, -34.82)
    zoneSizes[0] = 5
    zoneHeights[0] = 5
    zoneSpawns[0] = [vect(-36.02, 2, -50.02), vect(-38.458, 2, -50.184), vect(-40.896, 2, -50.348), vect(-43.334, 2, -50.512), vect(-45.772, 2, -50.676), vect(-48.21, 2, -50.84)]
    # King's Row - Zone B
    zoneLocations[1] = vect(-62.36, 0.00, 3.78)
    zoneSizes[1] = 5
    zoneHeights[1] = 5
    zoneSpawns[1] = [vect(-42.69, 0, 5.03), vect(-42.433, 0, 2.56), vect(-42.177, 0, 0.09), vect(-41.92, 0, -2.38), vect(-46.71, 1, -9.19), vect(-47.66, 0, -3.3)]
    # King's Row - Zone C
    zoneLocations[2] = vect(-88.55, 0.8, -24.8)
    zoneSizes[2] = 5
    zoneHeights[2] = 5
    zoneSpawns[2] = [vect(-92.97, -2.5, -46.37), vect(-94.22, -2.5, -44.205), vect(-96.72, -2.5, -44.205), vect(-97.97, -2.5, -46.37), vect(-96.72, -2.5, -48.535), vect(-94.22, -2.5, -48.535)]
