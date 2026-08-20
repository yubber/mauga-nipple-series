settings {
    "main": {
        "description":"it's like rein invasion but with mauga's \"guns\"\n1984 blizzard\nworkshop.codes/ds2md\n^ see above to contribute translations\n\nyubz made it\nyubz 제작, Lonepier 번역\nグルメスパイザー\nでお願いします",
        "modeName": "mauga's investor friendly pve (test version)" if DEBUG else "mauga's investor friendly pve"
		# "description": "마우가의 찌!찌!를 공략하는 보스레이드\nDS2MD\n\nyubz 제작, Lonepier 번역",
        # "modeName": "마우가 찌!찌! pve"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 12,
        "team1Slots": PlayerSlots,
        "team2Slots": 0,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "tdm": {
            "enabledMaps": [
                "workshopIslandNight",
                "workshopIsland",
            ],
			"enablePerks": true,
            "perkEliminationCatchupLevelAmount%": 100,
            "perkGeneration%": 500
        },
        "general": {
            "gameLengthInMn": 15,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "needsImbalancedTeamScoreToWin": true,
            "enableKillCam": false,
            "respawnTime%": 35,
            "enableSelfInitiatedRespawn": false,
            "tankPassiveHealthBonus": "alwaysEnabled",
            "team1ScoreToWin": 100,
            "team2ScoreToWin": 1
        }
    },
    "heroes": {
        "team1": {
            # "winston": {
            #     "ammoClipSize%": 40,
            # },
            "lifeweaver": {
                "primaryFireRange%": 200,
                "ultHealth%": 300
            },
            "widowmaker": {
                "ability2Cooldown%": 10
            },
			"venture": {
                "ability1Cooldown%": 120
            },
			"echo": {
                "ability1Cooldown%": 130,
                "enablePassive": false
            },
			"freja": {
                "ability1Cooldown%": 65,
                "ability2Cooldown%": 120
            },
			"zarya": {
				# "ability1Cooldown%": 45,
				# "ability2Cooldown%": 45,
                # "ultGen%": 50
            },
			"cassidy":{
				"damageDealt%": 85,
                "ultGen%": 70
			},
			"doomfist":{
				"ammoRegenerationTime%": 33,
                "ability1Cooldown%": 50,
                "ability2Cooldown%": 50,
                "secondaryFireCooldown%": 60,
			},
			"lucio":{
				"damageDealt%": 150,
                "ammoClipSize%": 300
			},
			"mercy":{
				"ability2Cooldown%": 250
			},
			"reinhardt": {
                "ability1Cooldown%": 40
            },
            "general": {
                "abilityCooldown%": 60,
                "ammoClipSize%": 150,
                "jumpVerticalSpeed%": 121,
                "movementGravity%": 110,
                "movementSpeed%": 140,
                "ultGen%": 160
            }
        },
        "team2": {
            "lifeweaver": {
                "enableSpawningWithUlt": true
            },
            "reinhardt": {
                "health%": 60
            },
            "torbjorn": {
                "weaponsEnabled": "hammer"
            },
            "winston": {
                "ammoClipSize%": 30,
                "health%": 80
            },
			"mauga": {
                "ability1Cooldown%": 0,
                "passiveHealthRegen": false
            },
			"venture": {
                "secondaryFireCooldown%": 0
            },
			"wreckingBall": {
                "enableRollOnly": true
            },
			"general": {
                "passiveHealthRegen": false,
				"healingDealt%": 10
            }
        },
        "allTeams": {
            # "mercy": {
            #     "ability2Cooldown%": 0
            # }
        }
    }
}

/*
mechanics
- upgrade stats with milk & tickling/squeezing
- buy boosts to come out of mauga
	- healing
	- 
bosses
- kiriko battle pass skin shadow clones
*/