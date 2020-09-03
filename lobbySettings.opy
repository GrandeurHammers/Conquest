#!mainFile "conquest.opy"

settings {
    "main": {
        "description": "======== CONQUEST v1.6 ========    By @Cactus_Puppy https://workshop.codes/conquest     Inspired by Destiny 2's Iron Banner. Two teams fight for control over 3 zones. The more zones a team controls, the more points they earn per kill. If a team gets all 3 zones, they activate a Power Play. First to 100 points wins!"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 6
    },
    "gamemodes": {
        "tdm": {
            "enabledMaps": [
                "blizzWorld",
                "blizzWorldWinter",
                "dorado",
                "iliosLighthouse",
                "iliosRuins",
                "iliosWell",
                "kingsRow",
                "kingsRowWinter",
                "lijiangControlCenter",
                "lijiangControlCenterLny",
                "lijiangGarden",
                "lijiangGardenLny",
                "lijiangNightMarket",
                "lijiangNightMarketLny",
                "oasisCityCenter",
                "oasisGardens",
                "oasisUniversity"
            ],
            "scoreToWin": 100
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "enableMercyRezKillCancel": false
        }
    }
}