settings {
    "main": {
        "description": "\nDS2MD\n\nyubz made it",
        "modeName": "mauga nipple measurement"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 5,
        "team1Slots": 9,
        "team2Slots": 0,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                "workshopIslandNight"
            ]
        },
        "general": {
            "gameLengthInMn": 15,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "needsImbalancedTeamScoreToWin": true,
            "enableKillCam": false,
            "respawnTime%": 40,
            "enableSelfInitiatedRespawn": false,
            "tankPassiveHealthBonus": "alwaysEnabled",
            "team1ScoreToWin": 100,
            "team2ScoreToWin": 1
        }
    },
    "heroes": {
        "team1": {
            "winston": {
                "ammoClipSize%": 40
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
                "ammoClipSize%": 70,
                "health%": 60
            }
        },
        "allTeams": {
            "mercy": {
                "ability2Cooldown%": 0
            }
        }
    }
}

globalvar l = vect(0.360, 1.371, 0.266)
globalvar r = vect(-0.137, 1.378, 0.466)

globalvar nip
globalvar scale = 1

rule "":
	print(scale)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
	nip = getLastCreatedEntity()
	nip.startScalingSize(scale,true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector(l*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector(r*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	wait(1)
	nip.setStatusEffect(null, Status.FROZEN, 99999)

rule "set r":
	@Condition hostPlayer.isFiringPrimaryFire()
	r = localVector(hostPlayer.getEyePosition(), nip, Transform.ROTATION_AND_TRANSLATION) / scale

rule "set l":
	@Condition hostPlayer.isFiringSecondaryFire()
	l = localVector(hostPlayer.getEyePosition(), nip, Transform.ROTATION_AND_TRANSLATION) / scale


rule "refr valk":
	@Event eachPlayer
	@Hero mercy
	@Condition not eventPlayer.isUsingUltimate()
	eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
	eventPlayer.setUltCharge(100)
	eventPlayer.forceButtonPress(Button.ULTIMATE)
	wait(0.4)
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.05)
	if ruleCondition:
		goto RULE_START

rule "":
	@Condition hostPlayer.isCrouching()
	nip.startFacing(directionFromAngles(getTotalTimeElapsed(), 0))
	waitUntil(not hostPlayer.isCrouching(), 360)
	nip.stopFacing()

rule "scale":
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	scale += 1 if hostPlayer.isHoldingButton(Button.MELEE) else -1