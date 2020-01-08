#!disableUnusedVars

#Global variables

# Where are the zones?
#!declareGlobal zoneLocations
# How large are the zones? (radius)
#!declareGlobal zoneSizes
# Who controls the zone?
#!declareGlobal zoneControl
# Is Team 1 on the zone?
#!declareGlobal isTeam1
# Is Team 2 on the zone?
#!declareGlobal isTeam2
# How much time is left in the Hunt?
#!declareGlobal huntTimer
# Stores all active hud texts (0 = spec)
#!declareGlobal hudTexts


@Rule "=====SETUP====="
@Event global
return