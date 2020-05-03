#!mainFile "owib.opy"

rule "Setup Zones: Lijang Tower":
@Event global
if getCurrentMap() in [Map.LIJIANG_CONTROL_CENTER, Map.LIJIANG_CONTROL_CENTER_LNY, Map.LIJIANG_GARDEN, Map.LIJIANG_GARDEN_LNY, Map.LIJIANG_NIGHT_MARKET, Map.LIJIANG_NIGHT_MARKET_LNY]:
    switch getCurrentMap():
        case Map.LIJIANG_CONTROL_CENTER:
        case Map.LIJIANG_CONTROL_CENTER_LNY:
            zoneLocations[0] = vect(48, 265, 329.15)
            zoneSizes[0] = 6
            zoneLocations[1] = vect(0, 267.33, 280)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-48, 265, 329.15)
            zoneSizes[2] = 6
            return
        case Map.LIJIANG_GARDEN:
        case Map.LIJIANG_GARDEN_LNY:
            zoneLocations[0] = vect(43, 95, 150)
            zoneSizes[0] = 5
            zoneLocations[1] = vect(0, 94, 130)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-43, 95, 150)
            zoneSizes[2] = 5
            return
        # FIXME: Change Night Market points
        case Map.LIJIANG_NIGHT_MARKET:
        case Map.LIJIANG_NIGHT_MARKET_LNY:
            zoneLocations[0] = vect(62, 2, -29)
            zoneSizes[0] = 5
            zoneLocations[1] = vect(1, -1, -61)
            zoneSizes[1] = 7
            zoneLocations[2] = vect(-60, 2, -29)
            zoneSizes[2] = 5
            return

# TODO: Add more maps