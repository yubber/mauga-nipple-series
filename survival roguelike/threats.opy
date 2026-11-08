#!mainFile "main.opy"

globalvar threatIcons
globalvar threatScores
globalvar threatNames
globalvar threatDescs
globalvar threatStacks
globalvar threatMaxStacks

globalvar mortarPos = [null,null,null,null,null]
globalvar mortarI
globalvar mortarTimes = [null,null,null,null,null]

globalvar gorgonPos
playervar feetSlow

globalvar grabLeft
globalvar grabLeftPlayer
globalvar grabRight
globalvar grabRightPlayer

globalvar wallEffects
globalvar wallPos
globalvar wallI

globalvar rainVar

globalvar missileFx
globalvar missilePos
globalvar missileTemp

enum THREATS:
	JAIL,
	MORE,
	GRAB,
	CHAIN,
	ICE,
	WALL,
	NUKE,
	RAIN,
	MEDUSA,
	MORTAR # LAST

macro chainThreatZLimit = -20 + threatStacks[THREATS.CHAIN] * 0.5

rule "threat info":
	tabular([threatNames,threatScores,threatMaxStacks,threatIcons,threatDescs], [
		"jailor", 3, 99999, abilityIconString(Hero.MAUGA, Button.ULTIMATE), "spawns a small mauga that charges you and\ntraps you in his ult. kill him to stop it.\neach stack increases his speed.",
		"more maugas", 5, 99999, heroIcon(Hero.MAUGA), "spawns an extra mauga that charges a\ndeadly attack. kill him to stop it.\neach stack increases his health.",
		# og threats
		"sticky handshake", 2, 99999, iconString(Icon.HAPPY), "mauga reaches out and tries to grab you to him. each stack increases \"hand\" speed.",
		"chained together", 4, 40, abilityIconString(Hero.MAUGA, Button.ULTIMATE), "mauga pulls you in if you're on the far side of the arena.\neach stack reduces minimum distance to be pulled.",
		"frostbitties", 2, 99999, iconString(Icon.DIAMOND), "mauga shoots freezing icicles.\neach stack increases fire rate.",
		"milk wall", 5, 99999, iconString(Icon.STOP), "mauga sends forth a wall that stuns on impact.\neach stack increases build speed.",
		"double d-day", 3, 99999, iconString(Icon.RADIOACTIVE), "a singularity follows players around.\non contact, mauga nukes it to create a deadly fallout zone.\neach stack increases singularity speed.",
		"cloudy with a chance of milkballs", 4, 99999, iconString(Icon.BOLT), "storm clouds move back and forth in rows.\neach stack increases damage.",
		"milkdusa", 7, 99999, iconString(Icon.EYE), "a gorgon spawns on the map. staring at it slows and eventually petrifies you.\neach stack increases buildup speed.",
		"moo-rtar", 4, 99999, iconString(Icon.DIZZY), "bombs random spaces on the map. each stack adds explosion radius.",
	])
	threatStacks = [0 for x in threatNames]

rule "perma threat fx":
	# medusa
	createIcon(getAllPlayers() if gorgonPos else null, gorgonPos, Icon.EYE, IconReeval.VISIBILITY_AND_POSITION, Color.YELLOW, true)
	createProjectileEffect(getAllPlayers() if gorgonPos else null, Projectile.ORISA_FUSION_DRIVER, getAllPlayers(), gorgonPos, Vector.DOWN, 1, ProjectileEffectReeval.VISIBILITY_FRIENDLINESS_POSITION_DIRECTION_AND_SIZE)
	createInWorldText(getAllPlayers() if gorgonPos else null, t"avert your eyes!", gorgonPos + Vector.DOWN, 1.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE)

rule "round start threat init":
	@Condition phase == PHASE.SURVIVE
	# medusa
	if threatStacks[THREATS.MEDUSA]:
		gorgonPos = vect(random.uniform(-20, 20), 1, random.uniform(chainThreatZLimit, 20))

rule "round end threat cleanup":
	@Condition phase == PHASE.INTERMISSION
	gorgonPos = null

macro mortarN = 5
macro mortarRad = 4.5 + threatStacks[THREATS.MORTAR]
macro mortarDelay = 1.5
rule "mortar":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.MORTAR] > 0
	wait(THREATS.MORTAR * 0.032)
	for mortarI in range(mortarN):
		createEffect(getAllPlayers() if mortarPos[evalOnce(mortarI)] else null, Effect.LIGHT_SHAFT, Color.ORANGE, mortarPos[evalOnce(mortarI)] - Vector.UP * 10, mortarRad * min(1, (getTotalTimeElapsed() - mortarTimes[evalOnce(mortarI)]) / mortarDelay), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		mortarPos[mortarI] = 0

	mortarI = 0

	while phase == PHASE.SURVIVE:
		# mortarPos[mortarI] = null
		mortarI = (mortarI + 1) % mortarN
		mortarPos[mortarI] = vect(random.uniform(-18, 18), 0, random.uniform(-18, 18))
		mortarTimes[mortarI] = getTotalTimeElapsed()
		wait(mortarDelay / 4, Wait.ABORT_WHEN_FALSE)
		createProjectile(Projectile.BAPTISTE_BIOTIC_LAUNCHER, null, LeftNip if mortarI % 2 else RightNip, directionTowards(LeftNip if mortarI % 2 else RightNip, mortarPos[mortarI] + Vector.UP * 60), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, 0, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0.4, 200/mortarDelay, mortarDelay * 0.45)
		wait(mortarDelay / 4, Wait.ABORT_WHEN_FALSE)
		createProjectile(Projectile.PHARAH_ROCKET, null, mortarPos[mortarI] + Vector.UP * 50, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 220, 110, mortarRad, DynamicEffect.BAD_EXPLOSION, DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, 0.8, 25/mortarDelay)

rule "toe medusa":
	@Event eachPlayer
	@Team 1
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.MEDUSA] > 0
	@Condition eventPlayer.isDummy() == false
	eventPlayer.feetSlow = 0

	wait(0.08 * eventPlayer.getSlot())

	while phase == PHASE.SURVIVE:
		wait(0.192)
		if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), gorgonPos)) < 40:
			eventPlayer.feetSlow += 0.02 * threatStacks[THREATS.MEDUSA]
			eventPlayer.setMoveSpeed((1 - eventPlayer.feetSlow) * SpeedFormula(eventPlayer))
			damage(eventPlayer, gorgonPos, 3)
			if eventPlayer.feetSlow >= 1:
				smallMessage(eventPlayer, t"petrified! don't look at the gorgon!")
				eventPlayer.feetSlow = 1
				eventPlayer.setStatusEffect(gorgonPos, Status.FROZEN, 1.2)
				damage(eventPlayer, gorgonPos, 80)
				wait(1)
				eventPlayer.feetSlow = 0
				eventPlayer.setMoveSpeed(SpeedFormula(eventPlayer))
				wait(0.48)
		else:
			eventPlayer.feetSlow = 0
			eventPlayer.setMoveSpeed(SpeedFormula(eventPlayer))

	eventPlayer.feetSlow = 0
	eventPlayer.setMoveSpeed(SpeedFormula(eventPlayer))

macro grabDelay = 2.7 * (0.85 ** threatStacks[THREATS.GRAB])
rule "grab":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.GRAB] > 0
	wait(THREATS.GRAB * 0.032)

	# grabplayer changes between player, position, list of players
	createBeam(getAllPlayers(), Beam.MOIRA_GRASP_CONNECTED, LeftNip, grabLeft, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MOIRA_GRASP_CONNECTED, RightNip, grabRight, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.SIGMA_HYPERSPHERE, null, grabLeft,Vector.DOWN, 0.05,ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.SIGMA_HYPERSPHERE, null, grabRight,Vector.DOWN, 0.05,ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers() if grabLeftPlayer.z != null else null, Effect.BAD_AURA, Color.TEAM_2, grabLeftPlayer, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers() if grabRightPlayer.z != null else null, Effect.BAD_AURA, Color.TEAM_2, grabRightPlayer, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	while phase == PHASE.SURVIVE:
		grabLeft = LeftNip
		grabRight = RightNip
		# select
		grabLeftPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x > 0])
		grabRightPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x < 0])

		# attack
		if entityExists(grabLeftPlayer):
			grabLeftPlayer = grabLeftPlayer.getPosition() + Vector.UP * 0.5 + grabLeftPlayer.getVelocity() * vect(1,0,1) * 2.4
			chaseOverTime(grabLeft, grabLeftPlayer, 2.4, ChaseTimeReeval.NONE)
		if entityExists(grabRightPlayer) and grabLeftPlayer != grabRightPlayer:
			grabRightPlayer = grabRightPlayer.getPosition() + Vector.UP * 0.5 + grabRightPlayer.getVelocity() * vect(1,0,1) * 2.4
			chaseOverTime(grabRight, grabRightPlayer, 2.4, ChaseTimeReeval.NONE)

		wait(2.4)

		stopChasingVariable(grabLeft)
		stopChasingVariable(grabRight)

		if phase == PHASE.INTERMISSION:
			return

		# check landing
		grabLeftPlayer = getRealPlayersInRadius(grabLeft, 2, Team.1)
		grabLeftPlayer.startForcingPosition(grabLeft,true)
		smallMessage(grabLeftPlayer, t"grabbed by mauga!".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabLeft, 20)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabLeft, 20)

		grabRightPlayer = getRealPlayersInRadius(grabRight, 2, Team.1)
		grabRightPlayer.startForcingPosition(grabRight,true)
		smallMessage(grabRightPlayer, t"grabbed by mauga!".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabRight, 20)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabRight, 20)

		# pull
		chaseOverTime(grabLeft, LeftNip, 1.2, ChaseTimeReeval.NONE)
		chaseOverTime(grabRight, RightNip, 1.2, ChaseTimeReeval.NONE)

		grabLeftPlayer.startDamageOverTime(null, 1.2, 10)
		grabRightPlayer.startDamageOverTime(null, 1.2, 10)

		wait(1.2)
		stopChasingVariable(grabLeft)
		stopChasingVariable(grabRight)

		wait(0.08)
		grabLeftPlayer.stopForcingPosition()
		grabRightPlayer.stopForcingPosition()

rule "cage":
	@Event eachPlayer
	@Team 1
	@Condition phase == PHASE.SURVIVE
	@Condition eventPlayer.isAlive()
	@Condition eventPlayer.isDummy() == false
	@Condition threatStacks[THREATS.CHAIN]
	wait(eventPlayer.getSlot() * 0.016)

	while phase == PHASE.SURVIVE:
		if eventPlayer.getPosition().z < chainThreatZLimit and (eventPlayer.isCrouching() == false):
			eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition(), LeftNip if (eventPlayer.getSlot() % 2 == 0) else RightNip), 60 if eventPlayer.isOnGround() else 30, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
		wait(0.36)

rule "cage boundary":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.CHAIN]

	createBeam(getAllPlayers(), Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if localPlayer.getSlot() % 2 == 0 else RightNip), localPlayer, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	createBeam(getAllPlayers(), Beam.BAD, vect(-20,0.1,chainThreatZLimit), vect(20,0.1,chainThreatZLimit), Color.ROSE, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

#!define WallGap 2.4
#!define WallWidth 5
rule "milk wall + collision":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.WALL]
	wait(THREATS.WALL * 0.032)
	wallEffects = []
	while phase == PHASE.SURVIVE:
		wallPos = vect(random.uniform(-20, 20 - WallGap * WallWidth), 0, 20)
		for wallI in range(54):
			if phase == PHASE.INTERMISSION:
				goto lbl_wallskip
			createProjectile(Projectile.ECHO_STICKY_BOMB, nipman, LeftNip if wallI % 2 == 0 else RightNip, directionTowards(LeftNip if wallI % 2 == 0 else RightNip, wallPos + vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 0, 0, 0.1, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, 0.1, 50 * (1.1 ** threatStacks[THREATS.WALL]),
				magnitude((LeftNip if wallI % 2 == 0 else RightNip) - wallPos + (vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap)) / 120 /*0.6 - 0.002 * wallI ** 2*/, 0,0,0)
			wait(0.144 * (0.85 ** threatStacks[THREATS.WALL]))
			createProjectileEffect(getAllPlayers(), Projectile.ECHO_STICKY_BOMB, null, wallPos + evalOnce(vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap), Vector.BACKWARD, 0.1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
			wallEffects.append(getLastCreatedEntity())

		for wallI in range(3):
			playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR_SOUND, Color.TEAM_2, wallPos, 800)
			wait((3 - wallI) * 0.16)
		chaseOverTime(wallPos, wallPos + 90 * Vector.BACKWARD, 3.5, ChaseTimeReeval.NONE)
		# collision
		for wallI in range(25):
			if phase == PHASE.INTERMISSION:
				break
			wait(0.096)
			nipman.mobTarget = [p for p in getLivingPlayers(Team.1)
				if abs(p.getPosition().z - wallPos.z) < 1.3
				and p.getPosition().x > wallPos.x
				and p.getPosition().x < wallPos.x + WallWidth * WallGap
				and p.getPosition().y <= 54 / WallWidth * WallGap]
			nipman.mobTarget.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
			damage(nipman.mobTarget, null, 90) # multihits except when it doesn't

		lbl_wallskip:
		for wallI in range(len(wallEffects)):
			destroyEffect(wallEffects[wallI])
			wait()
		destroyEffect(wallEffects)
		wallEffects = []
		stopChasingVariable(wallPos)

#!define RainPosFormula vect((sin(getTotalTimeElapsed() / 3) * 20) * evalOnce((rainVar % 2) * 2 - 1), 0, evalOnce(16 - 8 * rainVar))
rule "rain":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.RAIN] > 0
	wait(THREATS.RAIN * 0.032)
	createEffect(getAllPlayers(), Effect.CLOUD, Color.GRAY, Vector.UP * 30, 40, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	for rainVar in range(5):
		createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIGHT_RED, RainPosFormula + Vector.DOWN * 21, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, RainPosFormula, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())

	while phase == PHASE.SURVIVE:
		for rainVar in range(5):
			if rainVar % 2 != 0: # reduce the cloud seeding fx
				createProjectile(Projectile.ECHO_STICKY_BOMB, null, LeftNip if rainVar == 1 else RightNip, directionTowards(nipman.getEyePosition(), vect(random.uniform(-10,10), 30, random.uniform(-15,19))), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 1,1,0,DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, DynamicEffect.TRACER_RECALL_REAPPEAR_SOUND, 0.05, 30, 1, 0,0,-5)
			wait(0.032)
			createProjectile(Projectile.MEI_ICICLE, null, RainPosFormula + Vector.UP * 30 + vect(random.uniform(-0.5,0.5),0,random.uniform(-0.5,0.5)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20 * threatStacks[THREATS.RAIN], 1,3.2,DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT, DynamicEffect.TRACER_RECALL_REAPPEAR_SOUND, 0.07, 200, 1,2,0,0)
			wait(0.024)

#!define NukeAoe 10
rule "nuke":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.NUKE]
	wait(THREATS.NUKE * 0.032)

	# debug
	# createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.ROSE, missilePos, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	while phase == PHASE.SURVIVE:
		missileFx = []
		missilePos = vect(0,1,20)
		chaseAtRate(missilePos, getRealClosestPlayer(missilePos, Team.1).getPosition() * vect(1,0,1) + Vector.UP, 5 * threatStacks[THREATS.NUKE], ChaseRateReeval.DESTINATION_AND_RATE)
		# chaser
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, null, missilePos, Vector.UP, 0.1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		missileFx.append(getLastCreatedEntity())
		wait()
		# closest player check, can't use wait until in case rule must break
		while missileFx != []:
			if phase == PHASE.INTERMISSION:
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
		if phase == PHASE.INTERMISSION:
			for missileTemp in range(len(missileFx)):
				destroyEffect(missileFx[missileTemp])
			return

		playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, Color.TEAM_2, LeftNip, 1)
		playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, Color.TEAM_2, RightNip, 1)
		createProjectile(Projectile.PHARAH_ROCKET, null, LeftNip, directionTowards(LeftNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 1, 1, NukeAoe, DynamicEffect.SOMBRA_EMP_EXPLOSION_EFFECT, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,20, 0,0)
		createProjectile(Projectile.PHARAH_ROCKET, null, RightNip, directionTowards(RightNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 1, 1, NukeAoe, DynamicEffect.SOMBRA_EMP_EXPLOSION_EFFECT, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,20, 0,0)
		wait(0.012 * distance(LeftNip, missilePos))
		# playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, missilePos, 1)
		# playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST, Color.TEAM_2, missilePos, 1)
		playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Color.TEAM_2, missilePos, 1)
		playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST, Color.TEAM_2, missilePos, 1)
		playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_2, missilePos, 400)
		destroyEffect(missileFx[0])
		missileFx = []
		missileTemp = getTotalTimeElapsed()
		wait()
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, missilePos + Vector.DOWN * 10, Vector.UP, 1, ProjectileEffectReeval.VISIBILITY)
		missileFx.append(getLastCreatedEntity())
		createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, missilePos, NukeAoe, EffectReeval.VISIBILITY)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos, missilePos + min(16, 20 * (getTotalTimeElapsed() - missileTemp)) * Vector.UP, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos + Vector.UP * 12, missilePos + Vector.UP * 12 + min(4, max(0.01, 20 * (getTotalTimeElapsed() - missileTemp - 0.6))) * Vector.LEFT, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.OMNIC_SLICER, missilePos + Vector.UP * 12, missilePos + Vector.UP * 12 + min(4, max(0.01, 20 * (getTotalTimeElapsed() - missileTemp - 0.6))) * Vector.RIGHT, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		missileFx.append(getLastCreatedEntity())

		# start damage while eva anim plays
		for missileTemp in range(20):
			damage(getPlayersInRadius(missilePos, NukeAoe, Team.1, LosCheck.OFF), null, 30)
			getPlayersInRadius(missilePos, NukeAoe, Team.1, LosCheck.OFF).setStatusEffect(null, Status.BURNING, 0.16)
			wait(0.112)

		for missileTemp in range(2,len(missileFx)):
			destroyEffect(missileFx[missileTemp])
		missileFx = missileFx.slice(0,2)
		# dot

		for missileTemp in range(50):
			damage(getPlayersInRadius(missilePos, NukeAoe, Team.1, LosCheck.OFF), null, 30)
			getPlayersInRadius(missilePos, NukeAoe, Team.1, LosCheck.OFF).setStatusEffect(null, Status.BURNING, 0.16)
			wait(0.128)
			if phase == PHASE.INTERMISSION:
				break
		for missileTemp in range(len(missileFx)):
			destroyEffect(missileFx[missileTemp])
		missileFx = []

rule "make ice":
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.ICE]
	while phase == PHASE.SURVIVE:
		wait(9)
		createProjectile(Projectile.MEI_ICICLE, nipman, LeftNip, directionTowards(LeftNip, random.choice(getLivingPlayers(Team.1))), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 70, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)
		wait(0.36)
		createProjectile(Projectile.MEI_ICICLE, nipman, RightNip, directionTowards(RightNip, random.choice(getLivingPlayers(Team.1))), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 70, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)

rule "ice impact":
	@Event playerTookDamage
	@Team 1
	@Condition eventAbility == null
	@Condition attacker == nipman
	@Condition threatStacks[THREATS.ICE]
	victim.setStatusEffect(nipman, Status.FROZEN, 1.2)

rule "ice effect init":
	@Event eachPlayer
	@Hero mauga
	@Team 2
	@Condition phase == PHASE.SURVIVE
	@Condition threatStacks[THREATS.ICE]
	@Condition (eventPlayer == nipman)
	createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, LeftNip/*+ eventPlayer.getFacingDirection() * 5.2/20 * (20 if eventPlayer == nipman else MiniScale)*/, eventPlayer.getFacingDirection(), 0.5, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, RightNip/*+ eventPlayer.getFacingDirection() * 5.2/20 * (20 if eventPlayer == nipman else MiniScale)*/, eventPlayer.getFacingDirection(), 0.5, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
