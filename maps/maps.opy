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

    # Set spawn radii to be the zone radii as a backup
    if not len([r for r in zoneSpawns if r != -1]) == 3:
        printLog("[WARNING] Not all zone spawn radii have been set. Using zone radii.")
        zoneSpawnRadii = zoneSizes
