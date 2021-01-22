#!mainFile "../conquest.opy"

#!include "maps/lijang.opy"

#!include "maps/oasis.opy"

#!include "maps/blizzard.opy"

#!include "maps/ilios.opy"

#!include "maps/dorado.opy"

#!include "maps/kingsRow.opy"

rule "Spawn point failsafe: use zone position and radius if not set":
    @Condition isMapInitialized()

    # Set zone spawns to be in the zones as a backup
    if not len([s for s in zoneSpawns if s != 0]) == 3:
        printLog("[WARNING] Not all zone spawns have been set. Using zone locations.")
        zoneSpawns = zoneLocations

    # Ensure that singular spawn points are converted to arrays
    for i in range(0, len(zoneSpawns)):
        if len(zoneSpawns[i]) == 0:
            zoneSpawns[i] = [zoneSpawns[i]]
