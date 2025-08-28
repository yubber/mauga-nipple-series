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
                "abilityCooldown%": 0,
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
            },
            "general": {
                "abilityCooldown%": 0,
            }
        },
    }
}

#!extension buffStatusEffects

# local vectors for mauga of scale 1
globalvar l = vect(0.360, 1.371, 0.266)
globalvar r = vect(-0.137, 1.378, 0.466)

globalvar lyingr = vect(-0.187, 0.698, -0.702)
globalvar lyingl = vect(0.396, 0.602, -0.566)

globalvar ldummy
globalvar rdummy

globalvar nip
globalvar scale = 1

globalvar offset

rule "":
	waitUntil(hostPlayer.hasSpawned(), 10)
    hostPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
    hostPlayer.startScalingSize(20)
    hostPlayer.disableEnvironmentCollision(false)

	while true:
        hostPlayer.setUltCharge(100)
		wait(0.288)
		getPlayersOnHero(Hero.VENTURE).forceButtonPress(Button.SECONDARY_FIRE)

rule "":
    hudText(localPlayer, iconString(Icon.EYE), "eye position", localPlayer.getEyePosition(), HudPosition.LEFT, 0, Color.SKY_BLUE, Color.SKY_BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
	hudText(localPlayer, abilityIconString(Hero.HAMMOND, Button.CROUCH), "player position", localPlayer.getPosition(), HudPosition.LEFT, 0, Color.LIME_GREEN, Color.LIME_GREEN, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
	hudText(localPlayer, abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), "facing direction", localPlayer.getFacingDirection(), HudPosition.LEFT, 0, Color.RED, Color.RED, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

    r = vect(-0.16, 1.32, 0.56)
    l = vect(0.43, 1.31, 0.31)
    offset = vect(0.06,-0.65,-1.75)
    lyingl = vect(-0.187, 0.698, -0.702)
    lyingr = vect(0.396, 0.602, -0.566)
    ldummy = [null]
    rdummy = [null]
    nip = [null]
    scale = 20

	print(scale)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
	nip = getLastCreatedEntity()
    # freeze
    # nip.setStatusEffect(null, Status.PHASED_OUT, 99999)
	createDummy(Hero.VENTURE, Team.2, -1, Vector.UP, Vector.FORWARD)
    rdummy = getLastCreatedEntity()
    wait(1)
	createDummy(Hero.VENTURE, Team.2, -1, Vector.UP, Vector.FORWARD)
    ldummy = getLastCreatedEntity()
    # createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, getLastCreatedEntity(), 1, EffectReeval.VISIBILITY)
	nip.startScalingSize(scale,true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector((l+offset)*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, worldVector((r+offset)*scale, nip, Transform.ROTATION_AND_TRANSLATION), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	wait(1)
    rdummy.startForcingPosition(worldVector((r+offset)*scale, nip, Transform.ROTATION_AND_TRANSLATION), true)
	# rdummy.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)
	rdummy.startScalingSize(scale, true)
    rdummy.setFacing(nip.getFacingDirection()*-1, Relativity.TO_WORLD)
    # createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, rdummy, 1, EffectReeval.VISIBILITY)
    ldummy.startForcingPosition(worldVector((l+offset)*scale, nip, Transform.ROTATION_AND_TRANSLATION), true)
	# ldummy.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)
	ldummy.startScalingSize(scale, true)
    ldummy.setFacing(nip.getFacingDirection()*-1, Relativity.TO_WORLD)
    # createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_2, ldummy, 1, EffectReeval.VISIBILITY)

	nip.setStatusEffect(null, Status.FROZEN, 99999)

    # createDummy(Hero.SIGMA, Team.1, -1, Vector.FORWARD * 15, Vector.FORWARD)
    # wait(3)
    # getPlayersOnHero(Hero.SIGMA, Team.1).setStatusEffect(null, Status.KNOCKED_DOWN, 99999)


    ldummy.setFacing(Vector.FORWARD, Relativity.TO_WORLD)
    rdummy.setFacing(Vector.FORWARD, Relativity.TO_WORLD)
    # ldummy.setFacing(vect(0.07, 0.18, 0.98), Relativity.TO_WORLD)
    print(ldummy.getFacingDirection())
    print(nip.getPosition())

rule "set r":
    # @Disabled
	@Condition hostPlayer.isFiringSecondaryFire()
	r = localVector(hostPlayer.getEyePosition(), nip, Transform.ROTATION_AND_TRANSLATION) / scale
    wait(0.064)
    rdummy.setFacing(hostPlayer.getFacingDirection(), Relativity.TO_WORLD)

rule "set l":
    # @Disabled
	@Condition hostPlayer.isFiringPrimaryFire()
	l = localVector(hostPlayer.getEyePosition(), nip, Transform.ROTATION_AND_TRANSLATION) / scale
    wait(0.064)
    ldummy.setFacing(hostPlayer.getFacingDirection(), Relativity.TO_WORLD)

rule "":
    @Event playerTookDamage
    @Condition eventPlayer.isDummy()
    @Condition eventAbility == Button.MELEE
    if eventPlayer.hasStatus(Status.KNOCKED_DOWN):
        eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
    else:
        eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)


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
	nip.startFacing(directionFromAngles(getTotalTimeElapsed()*30, 0))
	waitUntil(not hostPlayer.isCrouching(), 360)
	nip.stopFacing()

rule "scale":
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	scale -= 1 if hostPlayer.isHoldingButton(Button.MELEE) else -1
    hostPlayer.disablePlayerCollision()