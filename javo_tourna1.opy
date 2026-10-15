globalvar MATCH 1

macro SMALL_ACTIVE = MATCH > 0
macro MED_ACTIVE = MATCH > 1
macro LARGE_ACTIVE = MATCH > 2
macro burstRadius = 2
macro baseExplodeDmg = 30
macro knockbackBase = 30
macro minToBurst = 1.5 # min scaling to burst
macro bigMaugaScale = 5
macro minionsBaseScale = 0.75 if LARGE_ACTIVE else 0.4
macro dmgInfl = 0.002
macro healInfl = 0.002

globalvar yubz
globalvar yubzEnemy
globalvar yubz_i

playervar yubzMauga
playervar yubzMinions
playervar yubzScale
playervar isMaugaMinion
playervar yubzMinionTarget = false

macro Player.scaling = self.yubzScale
macro minions = yubz.yubzMinions
macro mauga = yubz.yubzMauga

macro LeftNipLocalScaled = vect(-0.1465, 1.392, 0.4425) * bigMaugaScale
macro RightNipLocalScaled = vect( 0.3595, 1.39,  0.2365) * bigMaugaScale
macro NipPos(localvect):
	worldVector(localvect, mauga, Transform.ROTATION_AND_TRANSLATION)
macro burstRadiusFormula = burstRadius * eventPlayer.scaling

#!extension projectiles
#!extension energyExplosionEffects
#!extension spawnMoreDummyBots
#!extension beamEffects
#!extension explosionSounds

def inflChangeHandler():
	eventPlayer.startScalingSize(eventPlayer.scaling, false)
	eventPlayer.startModifyingVoicelinePitch(1 - 0.5 * eventPlayer.scaling, false)

rule "debug round no":
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	@Condition hostPlayer.isHoldingButton(Button.ULTIMATE)
	MATCH++

rule "detect yubz":
	@Condition isGameInProgress()
	@Condition entityExists(yubz) == false
	@Condition all([x.hasSpawned() for x in getAllPlayers()])
	yubz = [x for x in getAllPlayers() if f"{x}" == "OMGIDIED"][0]
	if yubz == null:
		wait(0.96)
		loop()

rule "detect enemy":
	@Condition isGameInProgress()
	@Condition entityExists(yubz)
	@Condition entityExists(yubzEnemy) == false
	yubzEnemy = [x for x in getPlayers(getOppositeTeam(yubz.getTeam())) if x.isDummy() == false][0]
	if yubzEnemy == null:
		wait(0.96)
		loop()

rule "player huds":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.isDummy() == false
	createEffect(getAllPlayers() if eventPlayer.scaling > minToBurst else [], Effect.RING, Color.ORANGE, eventPlayer.getPosition(), burstRadiusFormula, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createEffect(getAllPlayers() if eventPlayer.scaling > 5 else [], Effect.LIGHT_SHAFT, Color.RED, eventPlayer.getPosition(), burstRadiusFormula, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

rule "other player init":
	@Event eachPlayer
	@Condition eventPlayer.isAlive()
	eventPlayer.scaling = 1

rule "dmg inflation":
	@Event playerTookDamage
	@Condition not eventWasEnvironment
	eventPlayer.scaling += eventDamage * dmgInfl / 100
	inflChangeHandler()

rule "heal inflation":
	@Event playerReceivedHealing
	eventPlayer.scaling += eventHealing * healInfl / 100
	inflChangeHandler()

rule "hurt me, no you won't hurt me, i'm about to detonate, pull you close and then i'll be gone":
	@Event playerDied
	@Condition SMALL_ACTIVE
	@Condition eventPlayer.scaling > minToBurst
	playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.ROSE, eventPlayer.getPosition(), burstRadius * eventPlayer.scaling)
	playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getPosition(), burstRadius * eventPlayer.scaling / 20)

	createProjectile(Projectile.ORB, eventPlayer, Vector.UP * eventPlayer.scaling, Vector.DOWN, Relativity.TO_PLAYER, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), eventPlayer.scaling * baseExplodeDmg, 1, burstRadiusFormula, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 1, 0.08, knockbackBase * eventPlayer.scaling, 0, 0)

	eventPlayer.clearStatusEffect(Status.BURNING)
	eventPlayer.scaling = 1
	inflChangeHandler()

rule "spawn The mauga":
	@Event global
	@Condition isGameInProgress()
	@Condition entityExists(yubz)
	@Condition entityExists(mauga) == false
	createDummy(Hero.MAUGA, yubz.getTeam(), -1, yubz.getPosition(), Vector.UP)
	mauga = getLastCreatedEntity()
	mauga.disableEnvironmentCollision(true)
	mauga.disablePlayerCollision()
	mauga.setStatusEffect(null, Status.INVINCIBLE, 99999)
	mauga.setStatusEffect(null, Status.FROZEN, 99999)
	mauga.startFacing(yubz.getFacingDirection() * vect(1,0,1), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

macro HealAmt = (55 if MED_ACTIVE else 30) / 2 * 0.12
rule "healing milk":
	@Event global
	@Condition mauga.isAlive()
	createHomingProjectile(Projectile.ECHO_STICKY_BOMB, mauga, LeftNipLocalScaled * bigMaugaScale, Vector.FORWARD, Relativity.TO_PLAYER, ModifyHealth.HEAL, mauga.getTeam(), HealAmt, 1, 5, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0, 7, 5, 0, yubz, 1)
	wait(0.12)
	createHomingProjectile(Projectile.ECHO_STICKY_BOMB, mauga, RightNipLocalScaled * bigMaugaScale, Vector.FORWARD, Relativity.TO_PLAYER, ModifyHealth.HEAL, mauga.getTeam(), HealAmt, 1, 5, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0, 7, 5, 0, yubz, 1) * bigMaugaScale
	wait(0.12)
	if ruleCondition:
		loop()

rule "minions init":
	@Condition isGameInProgress()
	@Condition MED_ACTIVE
	for yubz_i in range(9):
		createDummy(Hero.MAUGA, yubz.getTeam(), -1, yubz.getPosition())
		minions.append(getLastCreatedEntity())
		minions.last().startFacing(directionTowards(evalOnce(minions.last()).getEyePosition(), yubzEnemy.getEyePosition()), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
		wait()

	minions.scaling = minionsBaseScale
	minions.isMaugaMinion = true
	minions.startScalingSize(minionsBaseScale, false)
	minions.startModifyingVoicelinePitch(1.25, false)
	minions.setDamageDealt(1)
	minions.setMaxHealth(25)
	minions.startForcingButton(Button.PRIMARY_FIRE)
	minions.startForcingThrottle(1,1,0,0,0,0)
	minions.setRespawnTime(4)

rule "minion control: stop shoot":
	@Condition yubz.isCommunicating(Comms.NO)
	minions.stopForcingButton(Button.PRIMARY_FIRE)
	minions.forceButtonPress(Button.RELOAD)
	waitUntil(yubz.isFiringPrimaryFire(), 10)
	minions.startForcingButton(Button.PRIMARY_FIRE)

rule "minion control: move here":
	@Condition yubz.isCommunicating(Comms.GROUP_UP)
	yubz.yubzMinionTarget = raycastHitPosition(yubz.getEyePosition(), yubz.getEyePosition() + yubz.getFacingDirection() * 50, null, null, false)
	waitUntil(yubz.isHoldingButton(Button.INTERACT), 99999)
	yubz.yubzMinionTarget = false

rule "minion movement ai":
	@Event eachPlayer
	@Hero mauga
	@Condition eventPlayer.isMaugaMinion
	wait(0.032 * eventPlayer.getSlot())
	while true:
		if yubz.yubzMinionTarget and isInLoS(eventPlayer.getEyePosition(), yubz.yubzMinionTarget):
			eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), yubz.yubzMinionTarget), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
		elif isInLoS(eventPlayer.getEyePosition(), yubzEnemy):
			eventPlayer.stopThrottleInDirection()
		else:
			eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), yubz.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
		wait(0.24)

rule "minions jump":
	@Condition yubz.isHoldingButton(Button.JUMP)
	minions.forceButtonPress(Button.JUMP)

rule "minions respawn":
	@Event eachPlayer
	@Condition eventPlayer.isMaugaMinion
	@Condition eventPlayer.isAlive()
	eventPlayer.scaling = minionsBaseScale
	eventPlayer.startScalingSize(minionsBaseScale, false)
	eventPlayer.teleport()

rule "minions chungus":
	@Condition LARGE_ACTIVE
	minions.setDamageDealt(1.2)
	minions.setMaxHealth(50)
	minions.scaling = minionsBaseScale
	minions.startScalingSize(minionsBaseScale, false)
