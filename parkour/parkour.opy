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
                "workshopChamber"
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
    }
}

#!extension buffStatusEffects
#!extension spawnMoreDummyBots

globalvar l = vect(0.360, 1.371, 0.266)
globalvar r = vect(-0.137, 1.378, 0.466)
globalvar lyingr = vect(-0.187, 0.698, -0.702)
globalvar lyingl = vect(0.396, 0.602, -0.566)

globalvar baby

globalvar maugaPos = []
globalvar maugaFacing = []
globalvar maugaType = []

enum MAUGA:
	GRAB,
	GEYSER,
	PUSHOFF,
	PLATFORM,
	JUMP

globalvar maugaIcons = [abilityIconString(Hero.ROADHOG, Button.ABILITY_1), abilityIconString(Hero.FREJA, Button.ABILITY_2), abilityIconString(Hero.GENJI, Button.ABILITY_2), abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_1), abilityIconString(Hero.KIRIKO, Button.ABILITY_1)]
globalvar maugaPrompts = ["grapple", "geyser", "springboard", "platform", "double jump"]
globalvar meleeMaugas = [MAUGA.PUSHOFF]

globalvar i

globalvar editmode
playervar oldFacing
playervar target
playervar lookingAt
playervar _NoClip

#!define botpos oldFacing
#!define type target
#!define botFx lookingAt
#!define playerUseTimes _NoClip

#!define facingdial 10 * (hostPlayer.oldFacing - hostPlayer.getVerticalFacingAngle())
#!define Chungus (sorted(getLivingPlayers(Team.2), lambda x: angleBetweenVectors(hostPlayer.getFacingDirection(), directionTowards(hostPlayer.getEyePosition(), x.getPosition())))[0])

# player to bot


# bot behavior
rule "init bot":
	@Event eachPlayer
	@Condition eventPlayer.isDummy()
	eventPlayer.playerUseTimes = [null for x in getNumberOfSlots(Team.1)] # can't use range but this is wrong

rule "grapple":
	@Event eachPlayer

# core
rule "set target":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.isDummy() == false
	wait(0.096)
	eventPlayer.lookingAt = Chungus
	loop()
# editor
rule "fx":
	print(facingdial)
	createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_1, localPlayer.lookingAt, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	waitUntil(hostPlayer.hasSpawned(), 999)

	# createInWorldText(getAllPlayers(), )

	pauseMatchTime()
	hostPlayer.setUltEnabled(false)

	print("hold rclick set scale")
	print("ult export")
	print("lclick create/confirm")
	print("rclick scale")
	print("melee knock down/destroy")

	editmode = true

rule "theprinter":
	@Event eachPlayer
	@Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
	if baby == null:
		eventPlayer.disablePlayerCollision()
		createDummy(Hero.SIGMA, Team.2, -1, Vector.UP, Vector.UP)
		baby = getLastCreatedEntity()
		baby.attachTo(eventPlayer, vect(0,0,0))
		baby.startFacing(eventPlayer.getFacingDirection(), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
		baby.setGravity(0)
		baby.setKnockbackReceived(0)
	else:
		eventPlayer.setJumpVerticalSpeed(250)
		eventPlayer.enablePlayerCollision()
		baby.detach()
		baby.botpos = eventPlayer.getPosition()
		baby.stopFacing()
		# baby.startForcingPosition(eventPlayer.getPosition(), false)
		baby = null

rule "tp back":
	@Event eachPlayer
	@Condition eventPlayer.isDummy()
	@Condition eventPlayer.botpos != null
	# eventPlayer.teleport(eventPlayer.botpos)
	eventPlayer.applyImpulse(-eventPlayer.getVelocity(), eventPlayer.getSpeed(), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
	wait(1.2)
	loop()

rule "scale dababy":
	@Condition hostPlayer.isHoldingButton(Button.SECONDARY_FIRE)
	hostPlayer.target = Chungus
	hostPlayer.oldFacing = hostPlayer.getVerticalFacingAngle()
	while hostPlayer.isHoldingButton(Button.SECONDARY_FIRE):
		wait(0.048)
		hostPlayer.target.startScalingSize(facingdial, false)
	# hostPlayer.target.startScalingSize(hostPlayer.oldFacing - hostPlayer.getVerticalFacingAngle(), false)

rule "edit bot facing/status":
	@Condition hostPlayer.isHoldingButton(Button.RELOAD)
	@Condition baby == null
	baby = Chungus
	baby.startFacing(hostPlayer.getFacingDirection(), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	wait(0.64)
	waitUntil(hostPlayer.isHoldingButton(Button.RELOAD), 99999)
	baby.stopFacing()
	baby = null

rule ".NoClip": # from workshop.codes/RVWKC
    @Event eachPlayer
	@Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    eventPlayer._NoClip = not eventPlayer._NoClip
    eventPlayer.startForcingPosition(eventPlayer.getPosition() + ((Vector.UP * (eventPlayer.isHoldingButton(Button.JUMP) - eventPlayer.isHoldingButton(Button.CROUCH)) + worldVector(eventPlayer.getThrottle(), eventPlayer, Transform.ROTATION)) * createWorkshopSettingFloat(".NoClip", ".NoClip speed", 0.2, 0, 1)))
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
	eventPlayer.disableEnvironmentCollision(true)
	hostPlayer.startCamera(
		updateEveryFrame(worldVector(vect(-0.7, 1.5, -3), hostPlayer, Transform.ROTATION_AND_TRANSLATION)),
		hostPlayer.getEyePosition() + hostPlayer.getFacingDirection() * 50, 50)
	if eventPlayer._NoClip == false:
		eventPlayer.stopForcingPosition()
		eventPlayer.clearStatusEffect(Status.PHASED_OUT)
		eventPlayer.enableEnvironmentCollision()
		hostPlayer.stopCamera()

rule "theshredder / theknocker":
	@Condition hostPlayer.isHoldingButton(Button.MELEE)
	if baby == null:
		kill(Chungus, hostPlayer)
	else:
		baby.type = (baby.type + 1) % len(maugaPrompts)
		if baby.hasStatus(Status.KNOCKED_DOWN):
			baby.clearStatusEffect(Status.KNOCKED_DOWN)
		else:
			baby.setStatusEffect(hostPlayer, Status.KNOCKED_DOWN, 99999)

rule "export & toggle edit mode":
	@Condition hostPlayer.isHoldingButton(Button.ULTIMATE)
	if editmode:
		maugaPos = []
		maugaFacing = []
		maugaType = []
		for i in range(getNumberOfLivingPlayers(Team.2)):
				maugaPos.append(getLivingPlayers(Team.2)[i].getPosition())
				maugaFacing.append(getLivingPlayers(Team.2)[i].getFacingDirection())
			# if getLivingPlayers(Team.2)[i].hasStatus(Status.KNOCKED_DOWN):
			# 	floorgaPos.append(getLivingPlayers(Team.2)[i].getPosition())
			# 	floorgaFacing.append(getLivingPlayers(Team.2)[i].getFacingDirection())
			# else:
			# 	shelfgaPos.append(getLivingPlayers(Team.2)[i].getPosition())
			# 	shelfgaFacing.append(getLivingPlayers(Team.2)[i].getFacingDirection())
		bigMessage(getAllPlayers(), "exported")
	else:
		kill(getPlayers(Team.2), null)

	editmode = not editmode

# rule ""

rule "rip":
	@Event playerDied
	@Condition eventPlayer.isDummy()
	# floorgaPos.remove(eventPlayer.getPosition())
	# floorgaFacing.remove(eventPlayer.getFacingDirection())
	destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())