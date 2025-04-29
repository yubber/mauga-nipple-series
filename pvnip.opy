settings {
    "main": {
        "description":"it's like rein invasion but with mauga's milkers\nDS2MD\n\nyubz made it",
        "modeName": "mauga n!pple pve"
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
        "tdm": {
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
			"venture": {
                "ability1Cooldown%": 99
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
            },
			"wreckingBall": {
                "enableRollOnly": true
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
right -0.16, 1.32, 0.56 | left 0.43, 1.31, 0.31
scaled at 0 -15 30: righ 4.46, 24.61, 21.40 | left -6.51, 24.36, 24.04

horde pvp base
-
extra attacks
- freeze explode nipple icicles
- torb ult
- snipers
- lifeweaver forest -> slenderman find pages
- knocking lazer
*/

enum OBJ:
	INTERMISSION = -1,
	PAGES, # keep as first
	MORE,
	KILL,
	BOSS,
	CAPTURE # keep as last

enum THREATS:
	SLENDY,
	MORE,
	ICE, # keep as first after slendy
	GRAB,
	FRACTAL,
	CAGE,
	TWISTER,
	RAIN,
	NUKE,
	DD,
	WALL,
	HEAL,
	COOM,
	SNIPER,
	BOOST,
	DAKKA,
	GRAV,
	SUN,
	LASER # keep as last

#!extension spawnMoreDummyBots
#!extension projectiles
#!extension beamEffects
#!extension energyExplosionEffects
#!extension buffStatusEffects
# !extension debuffStatusEffects
#!extension explosionSounds

#!define MaxBots 15-1
#!define TreeNo 7
#!define PlayerSlots 9

globalvar nipman
globalvar LeftNip = vect(2.93, 10.84-1.8, 26.15)
globalvar RightNip = vect(-7.19, 10.8-1.8, 30.27)
# globalvar LeftNip = vect(4.46, 21.7, 26.40) # phased out & floating values
# globalvar RightNip = vect(-6.51, 22.1, 29.04)
globalvar obj
globalvar objDescs = ["collect pages", "defeat the mini maugas", "slay enemies", "slay the miniboss", "capture the point"] # keep point as last
# globalvar objWeights = [0.05, 0.25, 0.25, 0.25, 0.20]
globalvar objWeights = [0.01, 0.96, 0.01, 0.01, 0.01]

globalvar objProg
globalvar objGoal
globalvar objPos # used for miniboss entity
globalvar roundNo
# globalvar kills
globalvar threatList = []
# threats that use dummy bots
globalvar dummyThreats = [THREATS.COOM, THREATS.SNIPER, THREATS.SUN, THREATS.FRACTAL/*, THREATS.KITSUNIPS*/]
# keep lazer as last and frosty as 1st after slender
globalvar threatNames = ["slenderman", "more maugas", "frosty nips", "grabbyteats", "niplets", "cup fight", "tiddy twister", "lactose hail", "n!pple nuke", "dairy deaths", "milk wall", "mending milk", "scalding discharge", "s-nip-ers", "boobsted mobs", "booblet hell", "gravitatas", "sun exposure", "lazer"]
globalvar threatIcons = [heroIcon(Hero.REAPER), abilityIconString(Hero.MAUGA, Button.ABILITY_1), abilityIconString(Hero.MEI, Button.ULTIMATE), abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), abilityIconString(Hero.SIGMA, Button.ABILITY_1), abilityIconString(Hero.MAUGA, Button.ULTIMATE), abilityIconString(Hero.JUNKER_QUEEN, Button.ULTIMATE), abilityIconString(Hero.HAZARD, Button.ULTIMATE), iconString(Icon.RADIOACTIVE), abilityIconString(Hero.REAPER, Button.ULTIMATE), abilityIconString(Hero.MEI, Button.ABILITY_2), iconString(Icon.PLUS), abilityIconString(Hero.TORBJORN, Button.ULTIMATE), abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), abilityIconString(Hero.ANA, Button.ULTIMATE), abilityIconString(Hero.PHARAH, Button.ULTIMATE), abilityIconString(Hero.ZARYA, Button.ULTIMATE), abilityIconString(Hero.ILLARI, Button.ULTIMATE), abilityIconString(Hero.ECHO, Button.ABILITY_2)]
#kitsunip rush, milk wall, mini mauga, tanky mobs 1 kill, heal, dd, milk rain (moving pillar beams), spoiled milk titties (global/big chasing dot?), maven degen like (chases then explodes after delay), restrict to 1 square of arena
# mini maugas have weak spots to shoot before attakc
globalvar isHardcore = createWorkshopSettingBool("difficulty", "respawn players only when round ends", false, 0)

globalvar threatText = ""
globalvar enemies = [Hero.WINSTON, Hero.TORBJORN, Hero.REINHARDT]
globalvar mobDmg = [80, 155, 75]
globalvar i # used in horde
globalvar upto # used in init, phase change, hp set on bug

# for icicle threat
globalvar target1 # players only
globalvar target2 # players only
# for laser threat
globalvar area1
globalvar area2
globalvar twisterPos
globalvar twisterCache
# wall
globalvar wallPos
globalvar wallI
globalvar wallEffects
#!define WallGap 2.2
#!define WallWidth 6

globalvar missilePos
globalvar missileFx
globalvar missileTemp

globalvar rainVar

globalvar grabLeft
globalvar grabLeftPlayer
globalvar grabRight
globalvar grabRightPlayer

globalvar nipletsPosList
globalvar iniplets

globalvar iMores
globalvar moreFx
globalvar attackingClone
globalvar weakSpots = []

globalvar threatSnipers
globalvar threatLactaters
globalvar threatSuns
globalvar threatNiplets
# globalvar threatTwinks
globalvar mobs = []
# persistent effects only (not destroyed until round end)
globalvar threatFx
globalvar antiCrashOn

playervar mobTarget # also used for sniper target, milk wall victims (nipman.mobTarget)
playervar cacheA
playervar cacheB
playervar cacheC

#!define chainSetup nipman.cacheA

# small maugas' nip pos
#!define smallLNip cacheA
#!define smallRNip cacheB
#!define hpBar cacheC

#!define MiniScale 15

rule "init":
	# print(len(getPlayers(Team.2)))
	# hudText(hostPlayer, iconString(Icon.EYE), "eye position", localPlayer.getEyePosition(), HudPosition.LEFT, 0, Color.SKY_BLUE, Color.SKY_BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), null,  "peak: {} | average: {}".format(getPeakServerLoad(), getAverageServerLoad()), "server load: {}\n".format(getServerLoad()), HudPosition.RIGHT, -2, Color.ORANGE, Color.GRAY, Color.GRAY, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), "use code DS2MD for the latest version", HudPosition.RIGHT, -1, Color.WHITE, HudReeval.VISIBILITY)
	disableInspector()

	obj = OBJ.INTERMISSION
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	nipman = getLastCreatedEntity()
	nipman.startForcingPosition(vect(0,-17-1.8,35), false)
	nipman.startFacing(Vector.BACKWARD, 999, Relativity.TO_WORLD, FacingReeval.NONE)
	nipman.disablePlayerCollision()
	nipman.startScalingSize(20, false) # max size
	upto = nipman.getMaxHealth()
	wait(0.08)
	nipman.setMaxHealth(10000)
	kill(nipman, null) # this is to fill hp and reset his pose
	nipman.setKnockbackReceived(0)
	disableGamemodeCompletion()
	disableMusic()
	disableScoring()
	heal(nipman, null, 999999)
	wait()
	nipman.setHealingReceived(0)
	wait()
	nipman.setHealth(72500)

	# score huds
	hudText(getAllPlayers(), abilityIconString(Hero.LUCIO, Button.ABILITY_2), "time elapsed", "{}:{}".format(floor(getTotalTimeElapsed() / 60), getTotalTimeElapsed() % 60), HudPosition.LEFT, 1, Color.SKY_BLUE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(), iconString(Icon.SKULL), "team deaths", teamScore(Team.2), HudPosition.LEFT, 2, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(), iconString(Icon.FLAG), "rounds elapsed", roundNo, HudPosition.LEFT, 2, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	# hudText(getAllPlayers(), abilityIconString(Hero.CASSIDY, Button.ULTIMATE), "total kills", kills, HudPosition.LEFT, 2, Color.ROSE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers() if isHardcore else null, iconString(Icon.EXCLAMATION_MARK), "hardcore mode is on", "no respawning until round ends", HudPosition.LEFT, 3, Color.BLACK, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	createEffect(getAllPlayers() if obj != OBJ.INTERMISSION else [], Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED, Color.TEAM_2, nipman, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# createEffect([] if obj != OBJ.INTERMISSION else getAllPlayers(), Effect., Color.TEAM_1, nipman, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

	# createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, LeftNip, 1, EffectReeval.VISIBILITY)
	# createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, RightNip, 1, EffectReeval.VISIBILITY)

	# objective effects
	createEffect(getAllPlayers() if obj == OBJ.PAGES else [], Effect.BAD_AURA, Color.GRAY, Vector.UP, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	for i in range(10):
		createEffect(getAllPlayers() if obj == OBJ.PAGES else [], Effect.CLOUD, Color.GRAY, Vector.UP * i * 0.1 - 0.7, 50, EffectReeval.VISIBILITY)
		wait()
	createEffect(getAllPlayers(), Effect.SPHERE, Color.ROSE, objPos if obj == OBJ.PAGES else Vector.DOWN, 0.7, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createEffect(getAllPlayers(), Effect.RING, Color.BLUE, objPos if obj == OBJ.CAPTURE else Vector.DOWN * getTotalTimeElapsed(), 12, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createIcon(getAllPlayers() if obj == OBJ.CAPTURE else [], objPos, Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.TEAM_1, true)

	# threat fx
	createProjectileEffect(getAllPlayers() if THREATS.ICE in threatList else [], Projectile.MEI_ICICLE, null, LeftNip + Vector.FORWARD * 5.8, Vector.BACKWARD, 0.5, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.ICE in threatList else [], Projectile.MEI_ICICLE, null, RightNip + Vector.FORWARD * 5.8, Vector.BACKWARD, 0.5, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.GRAV in threatList else [], Projectile.ZARYA_GRAVITON, null, LeftNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.GRAV in threatList else [], Projectile.ZARYA_GRAVITON, null, RightNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, LeftNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, RightNip, Vector.BACKWARD, 0.02, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.HEAL in threatList else [], Projectile.MOIRA_HEAL_ORB, null, LeftNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)
	createProjectileEffect(getAllPlayers() if THREATS.HEAL in threatList else [], Projectile.MOIRA_HEAL_ORB, null, RightNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)

	wait(0.16)
	# objective huds. get max hp is fucking broken for mauga. and tank passive bonus doesn't even let him heal to there
	progressBarHud(getAllPlayers() if obj == OBJ.INTERMISSION else [], 100 * nipman.getHealth() / 57500, "{} {} / {} hp".format(heroIcon(Hero.MAUGA), ceil(nipman.getHealth()), 57500), HudPosition.TOP, 1, Color.TEAM_2, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
	progressBarHud(getAllPlayers() if obj != OBJ.INTERMISSION else [], objProg / objGoal * 100, "objective: {}! {} / {}".format(objDescs[obj], objProg, objGoal), HudPosition.TOP, 1, Color.TEAM_2 if obj == OBJ.BOSS else Color.TEAM_1, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers() if obj != OBJ.INTERMISSION else [], "\&fullwidth_space;threats: {}\&fullwidth_space;".format(threatText), "", " \n ", HudPosition.TOP, 0, Color.ORANGE, Color.GRAY, Color.GRAY, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)

	setMatchTime(5/*10*/)

rule "loop":
	# start game when any player spawns for the first time
	@Condition any([x.hasSpawned() for x in getPlayers(Team.1)])
	# intermission
	destroyEffect(threatFx)
	destroyEffect(moreFx)
	threatFx = []
	threatLactaters = []
	threatSuns = []
	threatSnipers = []
	threatNiplets = []
	nipman.setDamageReceived(60)
	nipman.clearStatusEffect(Status.FROZEN) # has to be unfroze early bc his hitbox desyncs with model
	pauseMatchTime()
	stopChasingVariable(area1)
	stopChasingVariable(area2)
	stopChasingVariable(twisterPos)
	stopChasingVariable(missilePos)
	stopAllDamageModifications()
	# getPlayers(Team.1).stopAcceleration()
	getPlayers(Team.1).setGravity(100)
	obj = OBJ.INTERMISSION
	objProg = 0
	threatList = []
	setMatchTime(11)
	unpauseMatchTime()
	wait(8)
	bigMessage(getAllPlayers(), "next objective in 3 seconds!")
	wait(2.5)
	pauseMatchTime()
	wait(0.5)
	mobs = []

	# pick objective
	obj = random.uniform(0, 1) # sum(weights) must be 1. obj is r here
	upto = 0
	for i in range(len(objWeights)): # weighted rand from stackoverflow
		if upto + objWeights[i] >= obj:
			obj = i
			break
		upto += objWeights[i]
		wait()

	objGoal = [8, 3, 60, 1, 100][obj]

	# threats
	threatList = []
	if obj == OBJ.PAGES:
		threatList.append(THREATS.SLENDY)
	elif obj == OBJ.MORE:
		threatList.append(THREATS.MORE)

	threatList.append(random.randint(THREATS.ICE, THREATS.LASER))

	wait(0.8)
	if obj != OBJ.PAGES: # random.randint(0,2) > 0: # chance to add 2nd threat
		threatText = random.randint(THREATS.ICE, THREATS.LASER) # temp orangemint
		if not threatText in threatList:
			threatList.append(threatText)
			if all([x in dummyThreats for x in threatList]): # if dummy bots used would exceed cap. allow slendy and more to override
				threatList = threatList.slice(1,len(threatList))

	wait()

	threatText = ""
	for i in range(len(threatList)):
		threatText = "{}{} {}, ".format(threatText, threatIcons[threatList[i]], threatNames[threatList[i]])
		wait()
	threatText = threatText.substring(0, strLen(threatText)-2)
	roundNo++

	wait()
	bigMessage(getAllPlayers(), "round start!")
	nipman.forceButtonPress(Button.ABILITY_2)
	wait(0.48)
	nipman.setDamageReceived(1)
	nipman.setStatusEffect(null, Status.FROZEN, 99999)

	waitUntil(objProg >= objGoal, 99999)

	# for i in range(len(getPlayers(Team.2))):
	# 	if getPlayersInSlot(i, Team.2) != nipman:
	# 		destroyDummy(Team.2, i)
	# 	wait()

	# nipman.setStatusEffect(null, Status.STUNNED, 0.5)
	playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_EFFECT, Color.TEAM_1, Vector.FORWARD * 18, 100)
	playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.TEAM_1, localPlayer, 200)
	bigMessage(getAllPlayers(), "objective complete! mauga is vulnerable!")
	wait()
	getDeadPlayers(Team.1).respawn()

	goto RULE_START

# mobs
rule "summon the horde":
	@Condition obj != OBJ.INTERMISSION
	@Condition obj != OBJ.PAGES
	@Condition obj != OBJ.MORE
	wait(0.64, Wait.ABORT_WHEN_FALSE)
	getAllPlayers().disableKillFeed()
	wait()
	# destroyAllInWorldTexts() # debug
	for i in range(MaxBots-4):
		# createDummy(enemies[i%len(enemies)], Team.2, -1, Vector.DOWN, Vector.BACKWARD)
		# can't split enemy heroes bc skin limit
		# do not put this above skybox in case enemies aren't killed
		createDummy(enemies[roundNo%len(enemies)], Team.2, -1, 40 * Vector.UP, Vector.BACKWARD)
		mobs.append(getLastCreatedEntity())
		wait(0.08)
		# mobs.last().startFacing(directionTowards(mobs[evalOnce(i)].getEyePosition(), mobs[evalOnce(i)].mobTarget), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
		if THREATS.BOOST in threatList:
			createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED, Color.TEAM_2, mobs[evalOnce(i)], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
			threatFx.append(getLastCreatedEntity())
		# debug
		# createInWorldText(getAllPlayers(), mobs[evalOnce(i)].mobTarget, mobs[evalOnce(i)], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)

	wait(0.48)
	getPlayersOnHero(Hero.TORBJORN, Team.2).setWeapon(2)
	mobs.stopForcingButton(Button.PRIMARY_FIRE)
	mobs.startForcingThrottle(1,1,0,0,0,1)
	mobs.setDamageDealt(mobDmg[roundNo%len(mobDmg)])
	mobs.setMoveSpeed(60)
	wait()
	if enemies[roundNo%len(enemies)] == Hero.TORBJORN:
		mobs.setDamageReceived(85)
	else:
		mobs.setDamageReceived(100)

	# kill(mobs, null)
	# mobs.resurrect()
	# if obj == OBJ.KILL:
	# 	objProg -= len(mobs)

	if THREATS.BOOST in threatList:
		startDamageModification(getPlayers(Team.1), mobs, 130, DamageReeval.RECEIVERS_AND_DAMAGERS)

	getAllPlayers().enableKillFeed()
	# wait(5)

rule "slendy":
	@Condition obj == OBJ.PAGES
	# destroyAllInWorldTexts() # debug
	# bigMessage(hostPlayer, "slendy spawn debug")
	# for i in range(MaxBots-4-TreeNo):
	createDummy(Hero.REAPER, Team.2, -1, vect(0,7,99), Vector.BACKWARD)
	mobs.append(getLastCreatedEntity())
	wait()
	# mobs.last().startFacing(directionTowards(mobs[evalOnce(i)].getEyePosition(), mobs[evalOnce(i)].mobTarget), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	mobs.last().startFacing(directionTowards(mobs.last().getEyePosition(), mobs.last().mobTarget), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	wait()
	createEffect(getAllPlayers(), Effect.REAPER_WRAITH_FORM, Color.TEAM_2, mobs.last(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	if THREATS.BOOST in threatList:
		createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED, Color.TEAM_2, mobs.last(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		# debug
		# createInWorldText(getAllPlayers(), mobs[evalOnce(i)].mobTarget, mobs[evalOnce(i)], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)

	wait(0.64)
	mobs.startForcingThrottle(1,1,0,0,0,1)
	mobs.setDamageDealt(500)
	mobs.setMoveSpeed(95)
	mobs.startScalingSize(2, false)
	mobs.setMaxHealth(1200)
	getAllPlayers().disableKillFeed()
	kill(mobs, null)
	wait()
	getAllPlayers().enableKillFeed()
	objPos = Vector.FORWARD # set first page pos for clueless players
	mobs.resurrect()
	mobs.startModifyingVoicelinePitch(0.6, false)
	mobs.startForcingName("slenderman")
	wait(2)
	heal(mobs,null,99999)
	while obj == OBJ.PAGES:
		mobs.forceButtonPress(Button.MELEE)
		wait(1.2)
		if random.uniform(0,1) < 0.05:
			smallMessage(getAllPlayers(), "remember to check inside mauga's guns for the pages.")

rule "mob respawn":
	@Event eachPlayer
	@Condition eventPlayer.isDummy()
	@Condition eventPlayer.isAlive()
	@Condition eventPlayer in mobs
	eventPlayer.teleport(LeftNip if random.randint(0,1) == 0 else RightNip)
	eventPlayer.applyImpulse(vect(random.uniform(-0.15, 0.15), random.uniform(0.4, 0.66), -1), random.uniform(50,70), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
	eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.mobTarget), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)

	# torb is hammer only in settings
	# if obj != OBJ.PAGES:
	# 	getPlayersOnHero(Hero.TORBJORN, Team.2).setWeapon(2)
		# mobs.startForcingButton(Button.PRIMARY_FIRE)
	# wait(0.24)
	eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 5)

rule "knock mobs":
	@Event eachPlayer
	@Team 2
	@Condition eventPlayer.isDummy()
	@Condition eventPlayer.getPosition().y > 8.5
	@Condition eventPlayer.getNormalizedHealth() == 1
	@Condition not eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN)
	@Condition eventPlayer in mobs
	wait(1.5)
	waitUntil(eventPlayer.getPosition().y < 1.8, 7)
	eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 1.6)
	if obj != OBJ.PAGES:
		eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
	# wait(0.24)
rule "mob retarget":
	@Event global
	@Condition mobs != []
	@Condition obj != OBJ.INTERMISSION
	if getLivingPlayers(Team.1) == []:
		# mobs.mobTarget = null
		mobs.stopForcingThrottle()
		if obj == OBJ.BOSS:
			objPos.stopForcingThrottle()
	else:
		mobs.startForcingThrottle(1,1,0,0,0,1)
		if obj == OBJ.BOSS:
			objPos.startForcingThrottle(1,1,0,0,0,1)
		for i in range(len(mobs)):
			wait(0.12)
			# 1st-3rd closest player
			mobs[i].mobTarget = getRealClosestPlayers(mobs[i].getPosition(), Team.1)[random.randint(0,2) % getNumberOfLivingPlayers(Team.1)]
		wait(0.96)
		# change boss target
		if obj == OBJ.BOSS:
			objPos.mobTarget = mobs[0].mobTarget
			# objPos.mobTarget = getRealClosestPlayer(objPos, Team.1)
	if ruleCondition:
		loop
# threats
rule "more maugas persistent attack":
	@Condition obj == OBJ.MORE


rule "init weak spots": # ALL hammond dummies are weak spots
	@Event eachPlayer
	@Hero wreckingBall
	@Condition eventPlayer.isDummy()
	eventPlayer.startScalingSize(0.7, false)
	eventPlayer.startForcingName("weak spot")
	createIcon(getAllPlayers(), eventPlayer, Icon.WARNING, IconReeval.VISIBILITY_AND_COLOR, rgb(255, 255 * (sin(getTotalTimeElapsed()) + 1) / 2, 0), true)
	weakSpots.append(eventPlayer)
	wait(0.096)
	createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY)

rule "more maugas charge attack":
	@Condition obj == OBJ.MORE
	while obj == OBJ.MORE:
		wait(16)
		moreFx = []

		attackingClone = random.choice(objPos)

		createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallLNip, LeftNip if attackingClone.smallLNip.x > 0 else RightNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		moreFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallRNip, LeftNip if attackingClone.smallRNip.x > 0 else RightNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		moreFx.append(getLastCreatedEntity())

		bigMessage(getAllPlayers(), "{} deadly attack incoming! attack the weak spots! {}".format(iconString(Icon.WARNING), iconString(Icon.WARNING)))

		# all hammond dummies get weak spot init
		createDummy(Hero.WRECKING_BALL, Team.2, -1, Vector.UP, Vector.UP)
		getLastCreatedEntity().attachTo(attackingClone, vect(0.360, 1.371, 0.766)*MiniScale)
		wait()
		createDummy(Hero.WRECKING_BALL, Team.2, -1, Vector.UP, Vector.UP)
		getLastCreatedEntity().attachTo(attackingClone, vect(-0.137, 1.378, 0.966)*MiniScale)
		weakSpots.setHealth(200)
		weakSpots.setHealingReceived(0)
		wait(0.064)
		heal(weakSpots, null, 99999)

		wait(10)

		if obj != OBJ.MORE:
			return

		if (entityExists(attackingClone) == false) or (weakSpots == []):
			continue

		bigMessage(getAllPlayers(), "failed to stop the attack. brace for impact!")

		createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, LeftNip, vect(10, 0, 20 - 22 * (getTotalTimeElapsed() - evalOnce(getTotalTimeElapsed()))), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		moreFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, RightNip, vect(-10, 0, 20 - 22 * (getTotalTimeElapsed() - evalOnce(getTotalTimeElapsed()))), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		moreFx.append(getLastCreatedEntity())

		for iMores in range(15, -17, -5):
			playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, vect(10,0,iMores), 9)
			playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, vect(-10,0,iMores), 9)
			createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, null, vect(-10,1,iMores), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 200, 20, 9, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 99, 1, 50, 0,0)
			createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, null, vect(10,1,iMores), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 200, 20, 9, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 99, 1, 50, 0,0)
			wait(0.016*21)

		destroyEffect(moreFx)
		moreFx = []

rule "niplets":
	@Condition THREATS.FRACTAL in threatList
	threatNiplets = []
	createDummy(Hero.MAUGA, Team.2, -1, Vector.DOWN, Vector.BACKWARD)
	threatNiplets.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, Vector.DOWN, Vector.BACKWARD)
	threatNiplets.append(getLastCreatedEntity())

	threatNiplets.setStatusEffect(null, Status.FROZEN, 99999)
	threatNiplets.setStatusEffect(null, Status.UNKILLABLE, 99999)

	threatNiplets.last().startForcingPosition(RightNip + 2 * Vector.DOWN, true)
	threatNiplets[0].startForcingPosition(LeftNip + 2 * Vector.DOWN)
	threatNiplets.startScalingSize(2, false)

	nipletsPosList.append(worldVector(vect(0.360, 1.371, 0.266)*2, threatNiplets[0], Transform.ROTATION_AND_TRANSLATION))
	nipletsPosList.append(worldVector(vect(0.360, 1.371, 0.266)*2, threatNiplets.last(), Transform.ROTATION_AND_TRANSLATION))
	nipletsPosList.append(worldVector(vect(-0.137, 1.378, 0.466)*2, threatNiplets[0], Transform.ROTATION_AND_TRANSLATION))
	nipletsPosList.append(worldVector(vect(-0.137, 1.378, 0.466)*2, threatNiplets.last(), Transform.ROTATION_AND_TRANSLATION))

	iniplets = 0
	while obj != OBJ.INTERMISSION:
		iniplets = (iniplets + 1) % len(nipletsPosList)
		createProjectile(Projectile.BASTION_TACTICAL_GRENADE, null, nipletsPosList[iniplets], vect(random.uniform(-1,1),random.uniform(-0.5,1),-3), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 80, 1, 1, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0, 1, 10, 0, 5, 5)

rule "grab":
	@Condition THREATS.GRAB in threatList
	createBeam(getAllPlayers(), Beam.MOIRA_GRASP_CONNECTED, LeftNip, grabLeft, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MOIRA_GRASP_CONNECTED, RightNip, grabRight, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.SIGMA_HYPERSPHERE, null, grabLeft,Vector.DOWN, 0.05,ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.SIGMA_HYPERSPHERE, null, grabRight,Vector.DOWN, 0.05,ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers() if grabLeftPlayer != null else null, Effect.BAD_AURA, Color.TEAM_2, grabLeftPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers() if grabRightPlayer != null else null, Effect.BAD_AURA, Color.TEAM_2, grabRightPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION:
		grabLeft = LeftNip
		grabRight = RightNip
		# select
		grabLeftPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x > 0])
		grabRightPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x < 0])

		# attack
		if entityExists(grabLeftPlayer):
			grabLeftPlayer = grabLeftPlayer.getEyePosition()
			chaseOverTime(grabLeft, grabLeftPlayer, 4, ChaseTimeReeval.NONE)
		if entityExists(grabRightPlayer) and grabLeftPlayer != grabRightPlayer:
			grabRightPlayer = grabRightPlayer.getEyePosition()
			chaseOverTime(grabRight, grabRightPlayer, 4, ChaseTimeReeval.NONE)

		wait(4)

		stopChasingVariable(grabLeft)
		stopChasingVariable(grabRight)

		if obj == OBJ.INTERMISSION:
			return

		# check landing
		grabLeftPlayer = getRealPlayersInRadius(grabLeft, 2)
		grabLeftPlayer.startForcingPosition(grabLeft,true)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabLeft, 20)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabLeft, 20)

		grabRightPlayer = getRealPlayersInRadius(grabRight, 2)
		grabRightPlayer.startForcingPosition(grabRight,true)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabRight, 20)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabRight, 20)
		# else:
		# 	grabLeftPlayer = null
		# if distance(grabRight, grabRightPlayer) < 2:
		# 	grabRightPlayer.startForcingPosition(grabRight,true)
		# 	playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabRight, 20)
		# 	playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabRight, 1)
		# else:
		# 	grabRightPlayer = null

		# pull
		chaseOverTime(grabLeft, LeftNip, 1.2, ChaseTimeReeval.NONE)
		chaseOverTime(grabRight, RightNip, 1.2, ChaseTimeReeval.NONE)

		grabLeftPlayer.startDamageOverTime(null, 1.2, 10)
		grabRightPlayer.startDamageOverTime(null, 1.2, 10)

		wait(1.2)
		stopChasingVariable(grabLeft)
		stopChasingVariable(grabRight)
		if obj == OBJ.INTERMISSION:
			return

		wait()
		grabLeftPlayer.stopForcingPosition()
		grabRightPlayer.stopForcingPosition()

	# createEffect
	/*while obj != OBJ.INTERMISSION:
		grabLeft = LeftNip
		chaseAtRate(grabLeft, getRealClosestPlayer(grabLeft, Team.1).getEyePosition(), 2, ChaseRateReeval.DESTINATION_AND_RATE)
		while true:
			wait(0.096)
			if obj == OBJ.INTERMISSION:
				stopChasingVariable(grabLeft)
				return
			else:
				for grabLeftPlayer in range(getNumberOfPlayers(Team.1)):
					wait(0.096)
					grabLeftPlayer = getPlayersInSlot(grabLeftPlayer, Team.1)
					if grabLeftPlayer.hasSpawned() and grabLeftPlayer.isAlive() and distance(grabLeft, grabLeftPlayer) < 1:
						break
		stopChasingVariable(grabLeft)
		grabLeftPlayer.startForcingPosition(grabLeft, true)
		chaseAtRate(grabLeft, LeftNip, 20, ChaseRateReeval.NONE)
		grabLeftPlayer.startDamageOverTime(null, 2, 30)
		wait(2, Wait.ABORT_WHEN_FALSE)
		grabLeftPlayer.stopForcingPosition()
		stopChasingVariable(grabLeft)*/

/*rule "grab right":
	@Disabled
	@Condition THREATS.GRAB in threatList
	wait()
	while obj != OBJ.INTERMISSION:
		grabLeft = RightNip
		chaseAtRate(grabRight, getRealClosestPlayer(grabRight, Team.1).getPosition(), 2, ChaseRateReeval.DESTINATION_AND_RATE)
		while true:
			if obj == OBJ.INTERMISSION:
				stopChasingVariable(grabRight)
				return
			else:
				for grabRightPlayer in range(getNumberOfPlayers(Team.1)):
					grabRightPlayer = getPlayersInSlot(grabRightPlayer, Team.1)
					if grabRightPlayer.hasSpawned() and grabRightPlayer.isAlive() and distance(grabRight, grabRightPlayer) < 1:
						break
					wait(0.096)
			wait(0.096)
		stopChasingVariable(grabRight)
		grabRightPlayer.startForcingPosition(grabRight, true)
		chaseAtRate(grabRight, RightNip, 20, ChaseRateReeval.NONE)
		grabRightPlayer.startDamageOverTime(null, 2, 30)
		wait(2, Wait.ABORT_WHEN_FALSE)
		grabRightPlayer.stopForcingPosition()
		stopChasingVariable(grabRight)*/

rule "cage":
	@Event eachPlayer
	@Condition eventPlayer.isDummy() == false
	@Condition eventPlayer.hasSpawned()
	@Condition THREATS.CAGE in threatList
	# for nipman.chainSetup in range(9):
	# 	createBeam(getAllPlayers() if entityExists(getPlayersInSlot(evalOnce(i),Team.1)) else null, Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if i % 2 == 0 else RightNip), getPlayersInSlot(evalOnce(i)), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# 	threatFx.append(getLastCreatedEntity())
	# 	wait()

	createBeam(getAllPlayers(), Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if eventPlayer.getSlot() % 2 == 0 else RightNip), eventPlayer, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION:
		if eventPlayer.getPosition().z < -5:
			eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition(), LeftNip if (eventPlayer.getSlot() % 2 == 0) else RightNip), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
		wait(0.24)

rule "cage boundary":
	@Condition THREATS.CAGE in threatList

	# for chainSetup in range(9):
	# 	createBeam(getAllPlayers() if entityExists(getPlayersInSlot(evalOnce(chainSetup),Team.1)) else null, Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if chainSetup % 2 == 0 else RightNip), getPlayersInSlot(evalOnce(i)), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# 	threatFx.append(getLastCreatedEntity())
	# 	wait()

	createBeam(getAllPlayers(), Beam.BAD, vect(-20,0.1,-5), vect(20,0.1,-5), Color.ROSE, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

rule "milk wall + collision":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.WALL in threatList
	wallEffects = []
	while obj != OBJ.INTERMISSION:
		wallPos = vect(random.uniform(-20, 20 - WallGap * WallWidth), 0, 20)
		for wallI in range(54):
			createProjectile(Projectile.ECHO_STICKY_BOMB, nipman, LeftNip if wallI % 2 == 0 else RightNip, directionTowards(LeftNip if wallI % 2 == 0 else RightNip, wallPos + vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 0, 0, 0.1, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.1, 50,
				magnitude((LeftNip if wallI % 2 == 0 else RightNip) - wallPos + (vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap)) / 120 /*0.6 - 0.002 * wallI ** 2*/, 0,0,0)
			wait(0.144)
			createProjectileEffect(getAllPlayers(), Projectile.ECHO_STICKY_BOMB, null, wallPos + evalOnce(vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap), Vector.BACKWARD, 0.1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
			wallEffects.append(getLastCreatedEntity())

		for wallI in range(3):
			playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR_SOUND, Color.TEAM_2, wallPos, 800)
			wait((3 - wallI) * 0.16)
		chaseOverTime(wallPos, wallPos + 90 * Vector.BACKWARD, 3.5, ChaseTimeReeval.NONE)
		# collision
		for wallI in range(25):
			wait(0.064)
			nipman.mobTarget = [p for p in getLivingPlayers(Team.1)
				if abs(p.getPosition().z - wallPos.z) < 1.3
				and p.getPosition().x > wallPos.x
				and p.getPosition().x < wallPos.x + WallWidth * WallGap
				and p.getPosition().y <= 54 / WallWidth * WallGap]
			# nipman.mobTarget.applyImpulse(Vector.BACKWARD + Vector.UP * 0.1, 100, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
			nipman.mobTarget.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
			damage(nipman.mobTarget, null, 90) # multihits except when it doesn't
		# [p for p in getLivingPlayers(Team.1)
		# 	if p.getPosition().z <= 20
		# 	and p.getPosition().x > wallPos.x
		# 	and p.getPosition().x < wallPos.x + WallWidth * WallGap
		# 	and p.getPosition().y <= 60 / WallWidth].applyImpulse(Vector.BACKWARD + Vector.UP * 0.3, 360, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
		# wait(1)
		for wallI in range(len(wallEffects)):
			destroyEffect(wallEffects[wallI])
			wait()
		destroyEffect(wallEffects)
		wallEffects = []
		stopChasingVariable(wallPos)

#!define RainPosFormula vect((sin(getTotalTimeElapsed() / 3) * 20) * evalOnce((rainVar % 2) * 2 - 1), 0, evalOnce(16 - 8 * rainVar))
rule "rain":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.RAIN in threatList
	createEffect(getAllPlayers(), Effect.CLOUD, Color.GRAY, Vector.UP * 30, 40, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	for rainVar in range(5):
		createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.PURPLE, RainPosFormula + Vector.DOWN * 18, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, RainPosFormula, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION:
		for rainVar in range(5):
			createProjectile(Projectile.ECHO_STICKY_BOMB, null, LeftNip if rainVar % 2 == 0 else RightNip, directionTowards(nipman.getEyePosition(), vect(random.uniform(-10,10), 30, random.uniform(-15,19))), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 1,1,0,DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0.05, 30, 1, 0,0,-5)
			wait(0.048)
			createProjectile(Projectile.MEI_ICICLE, null, RainPosFormula + Vector.UP * 30 + vect(random.uniform(-0.5,0.5),0,random.uniform(-0.5,0.5)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 40, 1,3.2,DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0.07, 300, 1,0,0,0)

rule "twister":
	@Condition THREATS.TWISTER in threatList
	for twisterCache in range(3,12,2):
		# smallMessage(getAllPlayers(), i)
		createEffect(getAllPlayers(), Effect.BAD_AURA, Color.GRAY, Vector.UP * evalOnce(twisterCache*2.5 - 6) + twisterPos, evalOnce(twisterCache * 0.7), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		createProjectileEffect(getAllPlayers(), Projectile.ECHO_STICKY_BOMB, null, twisterPos + evalOnce(twisterCache) * 0.8 * vect(cos(getTotalTimeElapsed() * 7 + evalOnce(twisterCache)), 1 + 0.4 * sin(getTotalTimeElapsed()), sin(getTotalTimeElapsed() * 7 + evalOnce(twisterCache))), Vector.UP, evalOnce(random.uniform(0,0.05)), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		threatFx.append(getLastCreatedEntity())
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, twisterPos + evalOnce(twisterCache) * 0.8 * vect(cos(getTotalTimeElapsed() * 9 + evalOnce(twisterCache)), 1.3 + 0.4 * cos(getTotalTimeElapsed()), sin(getTotalTimeElapsed() * 9 + evalOnce(twisterCache))), Vector.UP, evalOnce(random.uniform(0,0.05)), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		threatFx.append(getLastCreatedEntity())
		wait()
	createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, twisterPos, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers(), Effect.CLOUD, Color.GRAY, twisterPos + 24 * Vector.UP, 30, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, twisterPos + 7 * Vector.DOWN, Vector.DOWN, 1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())

	twisterPos = LeftNip * vect(1,0,1)
	chase(twisterPos, getRealClosestPlayer(twisterPos,Team.1).getPosition()*vect(1,0,1), rate=1.6, ChaseReeval.DESTINATION_AND_RATE)
	while obj != OBJ.INTERMISSION:
		twisterCache = [x for x in getLivingPlayers(Team.1) if distance(x.getPosition() * vect(1,0,1), twisterPos) < 5 and x.getPosition().y < 25]
		twisterCache.applyImpulse(Vector.UP, 7, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
		damage(twisterCache, null, 35)
		wait(0.24)

rule "sun":
	@Condition THREATS.SUN in threatList
	createDummy(Hero.ILLARI, Team.2, -1, LeftNip, Vector.DOWN)
	threatSuns.append(getLastCreatedEntity())
	createDummy(Hero.ILLARI, Team.2, -1, RightNip, Vector.DOWN)
	threatSuns.append(getLastCreatedEntity())
	threatSuns[0].startForcingPosition(LeftNip, false)
	threatSuns.last().startForcingPosition(RightNip, false)

	threatSuns.setInvisibility(Invis.ENEMIES)
	threatSuns.startForcingName("sunkissed nips")
	threatSuns.setDamageDealt(90)
	threatSuns.setProjectileSpeed(30)
	threatSuns.disableNameplatesFor(getAllPlayers())

	while obj != OBJ.INTERMISSION:
		wait(2)
		threatSuns.setUltCharge(100)
		wait(4)
		threatSuns.forceButtonPress(Button.ULTIMATE)
		threatSuns[0].setFacing(directionTowards(LeftNip + Vector.UP * 5, random.choice(getLivingPlayers(Team.1)).getEyePosition()), Relativity.TO_WORLD)
		threatSuns.last().setFacing(directionTowards(RightNip + Vector.UP * 5, random.choice(getLivingPlayers(Team.1)).getEyePosition()), Relativity.TO_WORLD)
		wait(1.5)
		threatSuns.forceButtonPress(Button.PRIMARY_FIRE)

rule "gravitatas":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.GRAV in threatList
	# there was an issue with players getting stuck on the bottom rocks opposite mauga
	# getPlayers(Team.1).startAcceleration(Vector.FORWARD + 0.15 * Vector.DOWN, 80, 15, Relativity.TO_WORLD, AccelReeval.NONE)
	getPlayers(Team.1).setGravity(300)
	wait(6)
	if RULE_CONDITION:
		goto RULE_START # to affect new players
rule "boolet":
	@Condition THREATS.DAKKA in threatList
	while obj != OBJ.INTERMISSION:
		createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, null, LeftNip,
			vect(sin(getTotalTimeElapsed()*2)*0.55, cos(getTotalTimeElapsed()) * 0.3 - 0.53, -1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 120, 1, 0, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0.04, 8, 7, 0, 0,0)
		# wait(0.08)
		createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, null, RightNip,
			vect(sin(getTotalTimeElapsed()*2)*-0.55, cos(getTotalTimeElapsed()) * -0.3 - 0.53, -1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 120, 1, 0, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0.1, 8, 7, 0, 0,0)
		wait(0.128)
rule "laser":
	@Condition THREATS.LASER in threatList
	area1 = vect(10,0,20)
	area2 = vect(-10,0,20)
	createBeam(getAllPlayers(), Beam.OMNIC_SLICER, LeftNip, area1, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.OMNIC_SLICER, RightNip, area2, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, area1 + 4 * Vector.DOWN, Vector.DOWN, 0.55, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, area2 + 4 * Vector.DOWN, Vector.DOWN, 0.55, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())

	chase(area1, getRealClosestPlayer(area1,Team.1).getPosition()*vect(1,0,1), rate=0.8, ChaseReeval.DESTINATION_AND_RATE)
	chase(area2, getRealClosestPlayer(area2,Team.1).getPosition()*vect(1,0,1), rate=0.8, ChaseReeval.DESTINATION_AND_RATE)

rule "laser hurty loop":
	@Condition THREATS.LASER in threatList
	while obj != OBJ.INTERMISSION:
		createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, nipman, area1 + 0.5 * Vector.UP, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 3, DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, 0, getTotalTimeElapsed(), 10, 55, 0, 0)
		wait(0.08)
		createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, nipman, area2 + 0.5 * Vector.UP, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 3, DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, 0, getTotalTimeElapsed(), 3, 55, 0, 0)
		wait(0.8)

rule "snipers":
	@Condition THREATS.SNIPER in threatList
	threatSnipers = []
	wait()
	createDummy(Hero.WIDOWMAKER, Team.2, -1, Vector.UP, Vector.BACKWARD)
	threatSnipers.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(LeftNip + Vector.BACKWARD, false)
	getLastCreatedEntity().startFacing(directionTowards(threatSnipers[0].getEyePosition(), threatSnipers[0].mobTarget.getEyePosition()), 5, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

	wait()
	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, threatSnipers[0].getEyePosition(), updateEveryTick(threatSnipers[0].getEyePosition() + 80 * threatSnipers[0].getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	wait()
	createDummy(Hero.WIDOWMAKER, Team.2, -1, Vector.UP, Vector.BACKWARD)
	threatSnipers.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(RightNip + vect(0,-0.3,-1), false)
	getLastCreatedEntity().startFacing(directionTowards(threatSnipers.last().getEyePosition(), threatSnipers.last().mobTarget.getEyePosition()), 5, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, threatSnipers.last().getEyePosition(), updateEveryTick(threatSnipers.last().getEyePosition() + 80 * threatSnipers.last().getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	wait(0.36)

	threatSnipers.startForcingButton(Button.SECONDARY_FIRE)
	threatSnipers.disableNameplatesFor(getAllPlayers())
	threatSnipers.startForcingName("s-nip-ers")
	threatSnipers.setDamageDealt(50)
	threatSnipers.setStatusEffect(null, Status.PHASED_OUT, 9999)
	threatSnipers.startScalingSize(0.1, false)

	while obj != OBJ.INTERMISSION:
		wait(2)
		threatSnipers.forceButtonPress(Button.PRIMARY_FIRE)

rule "sniper change target":
	@Condition THREATS.SNIPER in threatList
	while obj != OBJ.INTERMISSION:
		wait(4)
		threatSnipers[0].mobTarget = random.choice(getLivingPlayers(Team.1))
		threatSnipers.last().mobTarget = random.choice(getLivingPlayers(Team.1))
		threatSnipers.setAmmo(0,9999)

rule "discharge":
	@Condition THREATS.COOM in threatList
	createDummy(Hero.TORBJORN, Team.2, -1, Vector.UP, Vector.BACKWARD)
	threatLactaters.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(LeftNip, false)
	createDummy(Hero.TORBJORN, Team.2, -1, Vector.UP, Vector.BACKWARD)
	threatLactaters.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(RightNip, false)
	wait(0.36)
	threatLactaters.setWeapon(2)
	threatLactaters.startScalingSize(0.3, false)
	threatLactaters.setDamageDealt(50)
	threatLactaters.setStatusEffect(null, Status.PHASED_OUT, 9999)
	threatLactaters.startForcingButton(Button.PRIMARY_FIRE)
	threatLactaters.startFacing(vect(sin(getTotalTimeElapsed() * 33)*0.42, sin(getTotalTimeElapsed() * 47)*0.28 - 0.1, -1), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	wait(0.36)
	threatLactaters.startModifyingVoicelinePitch(1 + 0.5 * sin(getTotalTimeElapsed()*2), true)
	threatLactaters.startForcingName("overheating glands")
	threatLactaters.disableNameplatesFor(getAllPlayers())
	wait(0.8)
	while THREATS.COOM in threatList:
		threatLactaters.setUltCharge(100)
		wait(0.096)
		threatLactaters.forceButtonPress(Button.ULTIMATE)
		wait(10)

rule "heal milk":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.HEAL in threatList

	while obj != OBJ.INTERMISSION:
		wait(0.8)
		createHomingProjectile(Projectile.ECHO_STICKY_BOMB, nipman, LeftNip + Vector.BACKWARD, Vector.BACKWARD, Relativity.TO_WORLD, ModifyHealth.HEAL, Team.2, 20, 1, 1, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0.05, 60,10,0,random.choice(objPos if obj == OBJ.MORE else mobs))
		createHomingProjectile(Projectile.ECHO_STICKY_BOMB, nipman, RightNip + Vector.BACKWARD, Vector.BACKWARD, Relativity.TO_WORLD, ModifyHealth.HEAL, Team.2, 20, 1, 1, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0.05, 60,10,0,random.choice(objPos if obj == OBJ.MORE else mobs))

rule "nuke":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.NUKE in threatList

	# debug
	# createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.ROSE, missilePos, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	while obj != OBJ.INTERMISSION:
		missileFx = []
		missilePos = vect(0,1,20)
		chaseAtRate(missilePos, getRealClosestPlayer(missilePos, Team.1).getPosition() * vect(1,0,1) + Vector.UP, 4, ChaseRateReeval.DESTINATION_AND_RATE)
		# chaser
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, null, missilePos, Vector.UP, 0.1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		missileFx.append(getLastCreatedEntity())
		wait()
		# closest player check, can't use wait until in case rule must break
		while missileFx != []:
			if obj == OBJ.INTERMISSION:
				for missileTemp in range(len(missileFx)):
					destroyEffect(missileFx[missileTemp])
				return
			# probably a bit more optimal since this stops checking on the first player found, instead of checking all players in radius
			for missileTemp in range(getNumberOfLivingPlayers(Team.1)):
				if getLivingPlayers(Team.1)[missileTemp].hasSpawned() and distance(getLivingPlayers(Team.1)[missileTemp].getPosition(), missilePos) < 3:
					playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, missilePos, 100)
					destroyEffect(missileFx[0])
					missileFx = []
					break
			wait(0.24)
		# arming
		lbl_0:
		stopChasingVariable(missilePos)
		missilePos -= Vector.UP
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, null, missilePos + Vector.UP, Vector.UP, 0.1 + 0.1 * (getTotalTimeElapsed() - missileTemp), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		missileFx.append(getLastCreatedEntity())
		wait()
		missileTemp = getTotalTimeElapsed()

		wait(3)
		# deto
		if obj == OBJ.INTERMISSION:
			for missileTemp in range(len(missileFx)):
				destroyEffect(missileFx[missileTemp])
			return
		createProjectile(Projectile.PHARAH_ROCKET, nipman, LeftNip, directionTowards(LeftNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, 0, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,70, 0,0)
		createProjectile(Projectile.PHARAH_ROCKET, nipman, RightNip, directionTowards(RightNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, 0, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,70, 0,0)
		wait(0.012 * distance(LeftNip, missilePos))
		# playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, missilePos, 1)
		# playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST, Color.TEAM_2, missilePos, 1)
		playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Color.TEAM_2, missilePos, 1)
		playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_2, missilePos, 400)
		destroyEffect(missileFx[0])
		missileFx = []
		missileTemp = getTotalTimeElapsed()
		wait()
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, missilePos + Vector.DOWN * 10, Vector.UP, 0.8, ProjectileEffectReeval.VISIBILITY)
		missileFx.append(getLastCreatedEntity())
		createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, missilePos, 8, EffectReeval.VISIBILITY)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos, missilePos + min(16, 20 * (getTotalTimeElapsed() - missileTemp)) * Vector.UP, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos + Vector.UP * 12, missilePos + Vector.UP * 12 + min(4, max(0.01, 20 * (getTotalTimeElapsed() - missileTemp - 0.6))) * Vector.LEFT, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos + Vector.UP * 12, missilePos + Vector.UP * 12 + min(4, max(0.01, 20 * (getTotalTimeElapsed() - missileTemp - 0.6))) * Vector.RIGHT, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())
		wait(2)
		for missileTemp in range(2,len(missileFx)):
			destroyEffect(missileFx[missileTemp])
		missileFx = missileFx.slice(0,2)
		# dot

		for missileTemp in range(50):
			damage(getPlayersInRadius(missilePos, 8, Team.1, LosCheck.OFF), null, 30)
			getPlayersInRadius(missilePos, 8, Team.1, LosCheck.OFF).setStatusEffect(null, Status.BURNING, 0.16)
			wait(0.112)
		for missileTemp in range(len(missileFx)):
			destroyEffect(missileFx[missileTemp])
		missileFx = []

rule "make ice":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.ICE in threatList
	# createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, threatVar1, directionTowards(threatVar1, target1), 0.5, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	# threatFx.append(getLastCreatedEntity())
	# createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, threatVar1, directionTowards(threatVar1, target1), 0.5, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	# threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION:
		wait(9)
		target1 = random.choice(getLivingPlayers(Team.1))
		target2 = random.choice(getLivingPlayers(Team.1))
		createProjectile(Projectile.MEI_ICICLE, nipman, LeftNip, directionTowards(LeftNip, target1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 70, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)
		wait(0.36)
		createProjectile(Projectile.MEI_ICICLE, nipman, RightNip, directionTowards(RightNip, target2), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 70, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)

rule "ice impact":
	@Event playerTookDamage
	@Team 1
	@Condition eventAbility == null
	@Condition attacker == nipman
	@Condition THREATS.ICE in threatList
	victim.setStatusEffect(nipman, Status.FROZEN, 1.2)

# objective setup
rule "more maugas":
	@Condition obj == OBJ.MORE
	wait(0.64)
	objPos = []
	createDummy(Hero.MAUGA, Team.2, -1, vect(-33,-19.5,0), Vector.LEFT)
	objPos.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, vect(33,-19.5,0), Vector.RIGHT)
	objPos.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, vect(0,-19.5,-33), Vector.FORWARD)
	objPos.append(getLastCreatedEntity())
	objPos.setGravity(0)
	wait(0.16)
	objPos.disablePlayerCollision()
	objPos.disableEnvironmentCollision(true)
	objPos.setKnockbackReceived(0)
	for iMores in range(len(objPos)):
		wait()
		objPos[iMores].smallLNip = worldVector(vect(0.360, 1.371, 0.266)*MiniScale, objPos[iMores], Transform.ROTATION_AND_TRANSLATION)
		objPos[iMores].smallRNip = worldVector(vect(-0.137, 1.378, 0.466)*MiniScale, objPos[iMores], Transform.ROTATION_AND_TRANSLATION)
		objPos[iMores].startForcingPosition(objPos[iMores].getPosition(), false)
		createProgressBarInWorldText(getAllPlayers(), evalOnce(objPos[iMores]).getNormalizedHealth() * 100, "{} / {} HP".format(evalOnce(objPos[iMores]).getHealth(), evalOnce(objPos[iMores]).getMaxHealth()), objPos[iMores], 1, Clip.NONE, Color.RED, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_AND_VALUES, SpecVisibility.DEFAULT)
		objPos[iMores].hpBar = getLastCreatedText()
	objPos.startScalingSize(MiniScale,false)
	objPos.setMaxHealth(1500)
	wait(0.48)
	heal(objPos, null, 99999)
	objPos.setHealingDealt(0)
	wait(0.64)
	objPos.setStatusEffect(null, Status.FROZEN, 99999)

rule "miniboss":
	@Condition obj == OBJ.BOSS
	# hero must be same as mobs for skin limit
	wait(0.64)
	createDummy(enemies[roundNo%len(enemies)], Team.2, -1, Vector.UP * 50, Vector.BACKWARD)
	objPos = getLastCreatedEntity()
	objPos.setKnockbackReceived(10)
	objPos.setMoveSpeed(40)
	objPos.startScalingSize(3, false)
	if objPos.getCurrentHero() == Hero.WINSTON:
		objPos.setDamageDealt(40)
	objPos.startForcingThrottle(1,1,0,0,0,1)
	objPos.startForcingName("miniboss")
	objPos.startFacing(directionTowards(objPos.getPosition(), objPos.mobTarget.getPosition()), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	objPos.setMaxHealth(2200 if objPos.getCurrentHero() in getTankHeroes() else 4000)

	wait(2)
	waitUntil(objPos.isOnGround(), 4)
	objPos.setStatusEffect(null,Status.KNOCKED_DOWN,2)
	objPos.startForcingButton(Button.PRIMARY_FIRE)

	while obj == OBJ.BOSS:
		objProg = 1 - objPos.getHealth()/objPos.getMaxHealth() # objPos.getNormalizedHealth()
		wait(0.24)

rule "clean bots":
	@Event eachPlayer
	@Team 2
	@Condition eventPlayer.isDummy()
	@Condition eventPlayer != nipman
	@Condition obj == OBJ.INTERMISSION
	destroyProgressBarInWorldText(eventPlayer.hpBar)
	destroyDummy(Team.2, eventPlayer.getSlot())

rule "setup & refresh forest":
	@Condition obj == OBJ.PAGES
	wait(1.5, Wait.ABORT_WHEN_FALSE)
	for i in range(TreeNo):
		createDummy(Hero.LIFEWEAVER, Team.2, -1, Vector.UP, Vector.DOWN)
		wait(0.032)
		if len(getPlayersOnHero(Hero.LIFEWEAVER, Team.2)) > TreeNo:
			break

	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setStatusEffect(null, Status.PHASED_OUT, 9999)
	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setInvisibility(Invis.ENEMIES)
	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setHealingDealt(30)

	wait(0.96)

	while obj == OBJ.PAGES:
		getPlayers(Team.2).setUltCharge(100)
		wait(0.08)
		getPlayersOnHero(Hero.LIFEWEAVER, Team.2).forceButtonPress(Button.ULTIMATE)
		getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setFacing(Vector.DOWN, Relativity.TO_WORLD)
		wait()
		for i in range(TreeNo):
			getPlayersOnHero(Hero.LIFEWEAVER, Team.2)[i].teleport(vect(random.uniform(-18,18),6,random.uniform(-18,18)))
			# while distance(objPos, getPlayersOnHero(Hero.LIFEWEAVER, Team.2)[i]) < 4:
			# 	getPlayersOnHero(Hero.LIFEWEAVER, Team.2)[i].teleport(vect(random.randint(-18,18),5,random.randint(-18,18)))
			# 	wait()
			wait()
		wait(0.08)
		getPlayersOnHero(Hero.LIFEWEAVER, Team.2).forceButtonPress(Button.PRIMARY_FIRE)
		wait(0.55)
		getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setStatusEffect(null, Status.HACKED, 0.5)
		wait(14, Wait.ABORT_WHEN_FALSE)

rule "place objective":
	@Condition obj == OBJ.CAPTURE
	objPos = vect(random.randint(-13,13),0,random.randint(-13,13))
# objective progress
rule "kill/obj prog/weak spot + respawn timer":
	@Event playerDied
	@Condition eventPlayer.isDummy()

	if eventPlayer in weakSpots:
		weakSpots.remove(eventPlayer)
		playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR, Color.TEAM_2, eventPlayer, 1)
		playEffect(getAllPlayers(), DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer, 50)
		if weakSpots == []:
			if obj == OBJ.MORE:
				attackingClone.setStatusEffect(null, Status.STUNNED, 1)
				destroyEffect(moreFx)
				moreFx = []
				attackingClone = null
				bigMessage(getAllPlayers(), "success! attack cancelled.")
		destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
		return

	heal(attacker, eventPlayer, 50)
	if THREATS.DD in threatList:
		playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR, Color.TEAM_2, eventPlayer.getPosition() + Vector.UP, 1)
		playEffect(getAllPlayers(), DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.getPosition() + Vector.UP, 10)
		damage(getPlayersInRadius(eventPlayer.getPosition(), 2, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS),eventPlayer,90)
		# createProjectile(Projectile.ECHO_STICKY_BOMB, eventPlayer, Vector.UP + eventPlayer.getPosition(), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 90, 1, 4, DynamicEffect.MOIRA_FADE_REAPPEAR, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION_SOUND,0,0,0.5, 0,0,0)
	if obj == OBJ.PAGES:
		eventPlayer.setRespawnTime(7)
		# objGoal -= 0.5
		objProg += 0.5
		return
	elif obj == OBJ.KILL:
		objProg++
		addToTeamScore(Team.1, 1)
		setTeamScore(Team.1, 0)
		eventPlayer.setRespawnTime(2)
		return
	elif obj == OBJ.BOSS and eventPlayer == objPos:
		objProg = objGoal
	elif obj == OBJ.MORE and eventPlayer in objPos:
		if eventPlayer == attackingClone:
			attackingClone = null
			destroyEffect(moreFx)
			moreFx = []
		objProg++
		objPos.remove(eventPlayer)
		destroyProgressBarInWorldText(eventPlayer.hpBar)
		destroyDummy(Team.2, eventPlayer.getSlot())
	eventPlayer.setRespawnTime(2.5)
	# kills++

rule "point":
	@Condition obj == OBJ.CAPTURE
	if getPlayersInRadius(objPos, 12, Team.1, LosCheck.OFF) != []:
		objProg += len(getPlayersInRadius(objPos, 12, Team.1, LosCheck.OFF)) / getNumberOfPlayers(Team.1) * 3
		playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, objPos, 25)
		playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, objPos, 150)
	wait(0.64)
	if RULE_CONDITION:
		goto RULE_START

rule "page found":
	@Event eachPlayer
	@Team 1
	@Condition obj == OBJ.PAGES
	@Condition distance(eventPlayer, objPos) < 1.3
	smallMessage(getAllPlayers(), " {} found a page!".format(eventPlayer))
	playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, objPos, 65)
	playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.TEAM_1, objPos, 1)
	addToTeamScore(Team.1, 1) # sound
	setTeamScore(Team.1, 0)
	objProg++
	objPos = vect(random.randint(-14,14),0,random.randint(-18,16))

rule "debug finish obj":
	@Disabled
	@Condition "{}".format(hostPlayer) == "OMGIDIED"
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	@Condition obj != OBJ.INTERMISSION
	objProg = objGoal

# misc
rule "rez cd if not hardcore":
	if isHardcore == false:
		while true:
			getPlayersOnHero(Hero.MERCY, Team.1).setAbilityCooldown(Button.ABILITY_2, 0)
			wait(2)

rule "player count balancing, freeze check":
	while true:
		if createWorkshopSettingBool("gameplay", "increase player damage per missing player",true,0):
			# getPlayers(Team.1).setDamageDealt(100 + (20 * (9 - getNumberOfPlayers(Team.1))))
			getPlayers(Team.1).setDamageDealt(min(400,900 / getNumberOfPlayers(Team.1)))
		if (nipman.hasStatusEffect(Status.FROZEN) == false) and (obj != OBJ.INTERMISSION):
			nipman.setStatusEffect(null, Status.FROZEN, 99999)
			nipman.setDamageReceived(1)
		wait(10)
rule "wake up":
	@Condition nipman.hasStatusEffect(Status.ASLEEP)
	nipman.clearStatusEffect(Status.ASLEEP)

rule "get up":
	@Condition nipman.hasStatusEffect(Status.ASLEEP)
	nipman.clearStatusEffect(Status.ASLEEP)

rule "anti crash on":
    @Condition not antiCrashOn
    @Condition getServerLoad() > 235
    wait(0.8, Wait.ABORT_WHEN_FALSE)
    setSlowMotion(50)
    # smallMessage(getAllPlayers(), "server load high. anti crash on.")
    antiCrashOn = true

rule "anti crash off":
    @Condition antiCrashOn
    @Condition getServerLoad() < 200
    do:
        wait(0.16, Wait.ABORT_WHEN_FALSE)
        setSlowMotion(100)
        antiCrashOn = false
    while RULE_CONDITION
rule "where did he go":
	@Condition not entityExists(nipman)
	wait(2, Wait.ABORT_WHEN_FALSE)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	nipman = getLastCreatedEntity()
	nipman.startForcingPosition(vect(0,-17,35), false)
	nipman.startFacing(Vector.BACKWARD, 999, Relativity.TO_WORLD, FacingReeval.NONE)
	nipman.disablePlayerCollision()
	nipman.startScalingSize(50, false)
	upto = nipman.getMaxHealth()
	wait(0.08)
	nipman.setMaxHealth(10000)
	kill(nipman, null) # this is to fill hp and reset his pose
	nipman.setKnockbackReceived(0)
	disableGamemodeCompletion()
	disableMusic()
	disableScoring()
	heal(nipman, null, 999999)
	wait()
	nipman.setHealingReceived(0)
	wait()
	nipman.setHealth(72500)

rule "charge no breaky":
	@Event eachPlayer
	@Hero reinhardt
	@Condition eventPlayer.isUsingAbility1()
	@Condition eventPlayer.getPosition().z > 18
	@Condition eventPlayer.getFacingDirection().z > -0.7
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")

rule "charge no breaky more maugas":
	@Event eachPlayer
	@Hero reinhardt
	@Condition obj == OBJ.MORE
	@Condition eventPlayer.isUsingAbility1()
	@Condition ((eventPlayer.getPosition().z < -18 and eventPlayer.getFacingDirection().z < 0.7)
	or (eventPlayer.getPosition().x < -18 and eventPlayer.getFacingDirection().x < 0.7)
	or (eventPlayer.getPosition().x > 18 and eventPlayer.getFacingDirection().x > -0.7))
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")

rule "punch no breaky":
	@Event eachPlayer
	@Hero doomfist
	@Disabled
	@Condition obj != OBJ.INTERMISSION
	@Condition eventPlayer.isFiringSecondaryFire()
	@Condition eventPlayer.getPosition().z > 15
	@Condition eventPlayer.getFacingDirection().z > 0
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")

rule "hook no breaky":
	@Event eachPlayer
	@Hero roadhog
	@Disabled
	@Condition obj != OBJ.INTERMISSION
	@Condition eventPlayer.isUsingAbility1()
	@Condition raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + 35 * eventPlayer.getFacingDirection(), getPlayers(Team.2), getPlayersOnHero(Hero.LIFEWEAVER, Team.2), true).getPlayerHit() == nipman
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")
rule "flux no breaky":
	@Event playerDealtDamage
	@Hero sigma
	@Condition eventAbility == Button.ULTIMATE
	@Condition victim == nipman or (obj == OBJ.MORE and victim in objPos)
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")
	wait(0.8)
	eventPlayer.setUltCharge(100)
rule "punch unbreaky":
	@Event playerDealtDamage
	@Hero doomfist
	@Condition victim == nipman or (obj == OBJ.MORE and victim in objPos)
	@Condition obj != OBJ.INTERMISSION
	@Condition eventAbility == Button.SECONDARY_FIRE
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)
rule "hook unbreaky":
	@Event playerDealtDamage
	@Hero roadhog
	@Condition victim == nipman or (obj == OBJ.MORE and victim in objPos)
	@Condition obj != OBJ.INTERMISSION
	@Condition eventAbility == Button.ABILITY_1
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)
rule "debug":
	@Disabled
	@Condition hostPlayer.isHoldingButton(Button.ULTIMATE)
	hostPlayer.setUltCharge(100)
	# hostPlayer.setDamageReceived(0)
rule "win":
	@Event playerDied
	@Condition eventPlayer == nipman
	@Condition attacker != null
	setSlowMotion(50)
	wait(0.48)
	declareTeamVictory(Team.1)
	destroyAllEffects()
	setSlowMotion(100)
	wait(3)
	restartMatch()

rule "player init, cage add":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	eventPlayer.disableGamemodeHud()
	eventPlayer.setAllowedHeroes(getAllHeroes())
	if isHardcore:
		getPlayers(Team.1).disableRespawn()

rule "sombra aint slick":
	@Event eachPlayer
	@Hero sombra
	@Condition eventPlayer.isUsingUltimate() or (eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.getUltCharge() == 100)
	startDamageModification(getPlayersOnHero(Hero.MAUGA, Team.2), eventPlayer, 2, DamageReeval.NONE)
	eventPlayer.mobTarget = getLastDamageModification()
	waitUntil(eventPlayer.getUltCharge() < 100, 2)
	stopDamageModification(eventPlayer.mobTarget)
rule "sombra was a little slick":
	@Event playerDealtDamage
	@Disabled
	@Hero sombra
	@Condition victim == nipman
	@Condition eventAbility == Button.ULTIMATE or eventDamage > 1000
	nipman.setHealth(nipman.getHealth() + eventDamage * 0.7)

rule "you are dead, not big surprise":
	@Event playerDied
	@Team 1
	addToTeamScore(Team.2, 1)
	# if getPlayersOnHero(Hero.MERCY, Team.1) == []:
	# 	eventPlayer.teleport(Vector.DOWN * getTotalTimeElapsed())
	if isHardcore:
		# eventPlayer.setRespawnTime(99999)
		if [x for x in getPlayers(Team.1) if x.isAlive() and x.hasSpawned()] == []:
			bigMessage(getAllPlayers(), "game over. all players died.")
			setSlowMotion(50)
			wait(1)
			declareTeamVictory(Team.2)
			destroyAllEffects()
			setSlowMotion(100)
			wait(3)
			restartMatch()