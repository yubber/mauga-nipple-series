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

#!extension buffStatusEffects

# local vectors for mauga of scale 1
globalvar l = vect(0.360, 1.371, 0.266)
globalvar r = vect(-0.137, 1.378, 0.466)

globalvar lyingr = vect(-0.187, 0.698, -0.702);
globalvar lyingl = vect(0.396, 0.602, -0.566);

globalvar ldummy
globalvar rdummy

globalvar nip
globalvar scale = 1

rule "":
	print(scale)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
	nip = getLastCreatedEntity()
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
    rdummy = getLastCreatedEntity()
    wait(1)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
    ldummy = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, getLastCreatedEntity(), 1, EffectReeval.VISIBILITY)
	nip.startScalingSize(scale,true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector(l*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector(r*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	wait(1)
    rdummy.startForcingPosition(worldVector(r*scale, nip, Transform.ROTATION_AND_TRANSLATION), true)
	rdummy.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)
	rdummy.startScalingSize(scale / 12, true)
    rdummy.startFacing(nip.getFacingDirection()*-1, Math.INFINITY, Relativity.TO_WORLD)
    createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, rdummy, 1, EffectReeval.VISIBILITY)
    ldummy.startForcingPosition(worldVector(l*scale, nip, Transform.ROTATION_AND_TRANSLATION), true)
	ldummy.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)
	ldummy.startScalingSize(scale / 12, true)
    ldummy.startFacing(nip.getFacingDirection()*-1, Math.INFINITY, Relativity.TO_WORLD)
    createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, ldummy, 1, EffectReeval.VISIBILITY)

	nip.setStatusEffect(null, Status.FROZEN, 99999)

    createDummy(Hero.MAUGA, Team.1, -1, Vector.FORWARD * 15, Vector.FORWARD)
    wait(3)
    getPlayersOnHero(Hero.MAUGA, Team.1).setStatusEffect(null, Status.KNOCKED_DOWN, 99999)

rule "set r":
    @Disabled
	@Condition hostPlayer.isFiringPrimaryFire()
	r = localVector(hostPlayer.getEyePosition(), nip, Transform.ROTATION_AND_TRANSLATION) / scale

rule "set l":
    @Disabled
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