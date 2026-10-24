settings {
    "lobby": {
        "team1Slots": 1,
        "team2Slots": 1
    },
    "gamemodes": {
        "elimination": {
        }
    }
}
globalvar ROUNDCHANGEDEBUG

globalvar MATCH 0 = createWorkshopSettingInt("match", "match no", 1, 1, 3, 0)
macro roundChange = isMatchBetweenRounds() or ROUNDCHANGEDEBUG
macro yubzBuffPlayerName = "AussieMedic"
macro DEBUG = false

macro SMALL_ACTIVE = MATCH > 0
macro MED_ACTIVE = MATCH > 1
macro LARGE_ACTIVE = MATCH > 2
macro burstRadius = 2
macro baseExplodeDmg = 35
macro knockbackBase = 5
macro minToBurst = 1.5 # min scaling to burst
macro bigMaugaScale = 2
macro minionsBaseScale = 0.75 if LARGE_ACTIVE else 0.4
macro dmgInfl = 0.12
macro healInfl = 0.12
macro TinyMaugaDmgPct = 1

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

macro attachOffset = vect(0,1.5,-2)
def spawnBigMauga():
	destroyDummy(mauga.getTeam(), mauga.getSlot())
	if entityExists(mauga) == false or mauga == null:
		smallMessage(yubz, "mauga")
		createDummy(Hero.MAUGA, yubz.getTeam(), -1, yubz.getPosition(), Vector.UP)
		mauga = getLastCreatedEntity()
		wait(0.16)
		mauga.disableEnvironmentCollision(true)
		mauga.disablePlayerCollision()
		mauga.setStatusEffect(null, Status.INVINCIBLE, 99999)
		mauga.startScalingSize(bigMaugaScale, false)
		mauga.startFacing(yubz.getFacingDirection() * vect(1,0,1), 999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
		mauga.attachTo(yubz, attachOffset)

def inflChangeHandler():
	eventPlayer.startScalingSize(eventPlayer.scaling, false)
	eventPlayer.startModifyingVoicelinePitch(0.99 - 0.33 * eventPlayer.scaling, false)
	if eventPlayer.scaling > 1.8:
		eventPlayer.disableEnvironmentCollision(false)

rule "debug round no":
	@Condition yubz == hostPlayer
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	@Condition hostPlayer.isHoldingButton(Button.ULTIMATE)
	MATCH++
	ROUNDCHANGEDEBUG = true
	waitUntil(hostPlayer.isHoldingButton(Button.INTERACT) == false, 30)
	ROUNDCHANGEDEBUG = false

rule "debug nip pos":
	@Condition yubz.isHoldingButton(Button.INTERACT)
	yubz.startCamera(mauga.getEyePosition() + yubz.getFacingDirection() * 4, NipPos(LeftNipLocalScaled), 99)
	waitUntil(yubz.isHoldingButton(Button.INTERACT) == false, 30)
	yubz.stopCamera()

rule "detect yubz":
	@Condition entityExists(yubz) == false
	@Condition all([x.hasSpawned() for x in getAllPlayers()])
	yubz = [x for x in getAllPlayers() if f"{x}" == yubzBuffPlayerName][0]
	wait(0.96)
	if yubz == null:
		loop()
	else:
		wait(2.4)
		spawnBigMauga()

rule "detect enemy":
	@Condition entityExists(yubz)
	@Condition entityExists(yubzEnemy) == false
	if DEBUG:
		createDummy(Hero.REINHARDT, getOppositeTeam(yubz.getTeam()), -1, yubz.getPosition(), Vector.FORWARD)
		yubzEnemy = getLastCreatedEntity()
		yubzEnemy.startForcingButton(Button.PRIMARY_FIRE)
	else:
		yubzEnemy = [x for x in getPlayers(getOppositeTeam(yubz.getTeam())) if x.isDummy() == false][0]
	wait(0.96)
	if yubzEnemy == null:
		loop()

rule "player huds":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.isDummy() == false
	createEffect(getAllPlayers() if eventPlayer.scaling > minToBurst else [], Effect.RING, Color.ORANGE, eventPlayer.getPosition(), burstRadiusFormula, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createEffect(getAllPlayers() if eventPlayer.scaling > 5 else [], Effect.LIGHT_SHAFT, Color.RED, eventPlayer.getPosition(), burstRadiusFormula, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

rule "other player init: on alive":
	@Event eachPlayer
	@Condition eventPlayer.isAlive()
	eventPlayer.scaling = 1
	eventPlayer.enableEnvironmentCollision()
	inflChangeHandler()

rule "dmg inflation":
	@Event playerTookDamage
	@Condition not eventWasEnvironment
	@Condition eventPlayer != mauga
	eventPlayer.scaling += eventDamage * dmgInfl / 100
	inflChangeHandler()

rule "heal inflation":
	@Event playerReceivedHealing
	eventPlayer.scaling += eventHealing * healInfl / 100
	inflChangeHandler()

rule "global init":
	hudText(getAllPlayers(), iconString(Icon.ARROW_UP), "your size", localPlayer.scaling, HudPosition.ACTUALLY_LEFT, 0, Color.ORANGE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	createIcon(yubz, yubz.yubzMinionTarget, Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.ROSE, true)
	debug(MATCH)
	debug(mauga)
	debug(entityExists(mauga))
	debug(minions)
	debug(roundChange)

rule "explode notif":
	@Event eachPlayer
	@Condition eventPlayer.scaling > minToBurst
	smallMessage(eventPlayer, "you are full enough to explode on death!")

rule "round reset":
	@Condition roundChange
	smallMessage(yubz, "round change")
	getAllPlayers().scaling = 1
	getAllPlayers().exclude(mauga).stopScalingSize()
	minions.enableRespawn()
	getAllPlayers().exclude(mauga).enableEnvironmentCollision()
	getAllPlayers().stopModifyingVoicelinePitch()

rule "hurt me, no you won't hurt me, i'm about to detonate, pull you close and then i'll be gone":
	@Event playerDied
	@Condition SMALL_ACTIVE
	@Condition eventPlayer.scaling > minToBurst
	eventPlayer.setDamageDealt(100)
	wait()
	playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.ROSE, eventPlayer.getPosition(), burstRadius * eventPlayer.scaling)
	if eventPlayer.isDummy():
		playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), burstRadius * eventPlayer.scaling / 5)
	else:
		playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), burstRadius * eventPlayer.scaling / 2)

	createProjectile(Projectile.ORB, eventPlayer, Vector.UP * eventPlayer.scaling, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), eventPlayer.scaling * baseExplodeDmg, 1, burstRadiusFormula, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 999, 2, knockbackBase * eventPlayer.scaling, 0, 0)

	eventPlayer.clearStatusEffect(Status.BURNING)
	eventPlayer.scaling = 1
	inflChangeHandler()

rule "spawn The mauga":
	@Condition yubz
	@Condition yubz.hasSpawned()
	@Condition entityExists(mauga) == false or mauga == null
	spawnBigMauga()
	wait(99999, Wait.IGNORE_CONDITION)

rule "respawn The mauga":
	@Event global
	@Condition entityExists(yubz)
	@Condition yubz.hasSpawned()
	@Condition entityExists(mauga) == false or mauga == null
	@Condition roundChange
	spawnBigMauga()

rule "beeg mauga ded":
	@Event playerDied
	@Hero mauga
	@Condition eventPlayer == mauga
	if eventWasEnvironment and yubz.isAlive():
		mauga.respawn()

rule "sacrifice":
	@Condition yubz.isDead()
	if entityExists(mauga) and mauga.isAlive():
		kill(mauga, yubz)
		yubz.resurrect()
		yubz.enableEnvironmentCollision()
	else:
		kill(minions, null)

macro HealAmt = (55 if MED_ACTIVE else 35) / 2 * 0.12
rule "healing milk":
	@Event global
	@Condition entityExists(mauga)
	@Condition mauga.isAlive()
	createHomingProjectile(Projectile.ECHO_STICKY_BOMB, mauga, LeftNipLocalScaled, Vector.FORWARD + Vector.DOWN * 0.2, Relativity.TO_PLAYER, ModifyHealth.HEAL, mauga.getTeam(), HealAmt, 1, 5, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0, 14, 10, 0, yubz, 1)
	wait(0.12)
	createHomingProjectile(Projectile.ECHO_STICKY_BOMB, mauga, RightNipLocalScaled, Vector.FORWARD + Vector.DOWN * 0.2, Relativity.TO_PLAYER, ModifyHealth.HEAL, mauga.getTeam(), HealAmt, 1, 5, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0, 14, 10, 0, yubz, 1)
	wait(0.12)
	if ruleCondition:
		loop()

rule "minions init":
	@Condition yubz.hasSpawned()
	@Condition MED_ACTIVE
	@Condition minions == null or minions == []
	smallMessage(yubz, "minions")
	wait(0.64)
	for yubz_i in range(9):
		createDummy(Hero.MAUGA, yubz.getTeam(), -1, yubz.getPosition())
		minions.append(getLastCreatedEntity())
		wait()

	minions.scaling = minionsBaseScale
	minions.isMaugaMinion = true
	minions.startScalingSize(minionsBaseScale, false)
	minions.startModifyingVoicelinePitch(1.25, false)
	minions.setDamageDealt(TinyMaugaDmgPct)
	minions.setMaxHealth(25)
	minions.startForcingButton(Button.PRIMARY_FIRE)
	minions.disablePlayerCollision()
	minions.startForcingName("niplet")
	minions.setMoveSpeed(130)
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
			eventPlayer.stopForcingThrottle()
			eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), yubz.yubzMinionTarget), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
		elif isInLoS(eventPlayer.getEyePosition(), yubzEnemy.getEyePosition()):
			eventPlayer.stopThrottleInDirection()
			eventPlayer.startForcingThrottle(1,1,0,0,0,0)
		elif distance(eventPlayer.getPosition(), yubz.getPosition()) > 3:
			eventPlayer.stopForcingThrottle()
			eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), yubz.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
		else:
			eventPlayer.stopForcingThrottle()
			eventPlayer.stopThrottleInDirection()
		wait(0.24)

rule "minions jump":
	@Condition yubz.isHoldingButton(Button.JUMP)
	minions.forceButtonPress(Button.JUMP)

rule "unkill minions":
	@Event playerDied
	@Hero mauga
	@Condition eventPlayer.isMaugaMinion
	wait()
	eventPlayer.stopFacing()
	if mauga.isAlive() and entityExists(mauga):
		wait(4)
		eventPlayer.respawn()

rule "minions respawn":
	@Event eachPlayer
	@Condition eventPlayer.isMaugaMinion
	@Condition eventPlayer.isAlive()
	# if mauga.isDead() or (entityExists(mauga) == false):
	# 	eventPlayer.disableRespawn()
	eventPlayer.scaling = minionsBaseScale
	eventPlayer.setDamageDealt(TinyMaugaDmgPct)
	eventPlayer.startScalingSize(minionsBaseScale, false)
	eventPlayer.teleport(NipPos(LeftNipLocalScaled if eventPlayer.getSlot() % 2 == 0 else RightNipLocalScaled))
	eventPlayer.applyImpulse(yubz.getFacingDirection(), 30, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
	eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), yubzEnemy.getEyePosition()), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

rule "minions chungusfy":
	@Condition LARGE_ACTIVE
	minions.setMaxHealth(50)
	minions.scaling = minionsBaseScale
	minions.startScalingSize(minionsBaseScale, false)

rule "kill stranded minion":
	@Event eachPlayer
	@Hero mauga
	@Condition eventPlayer.isMaugaMinion
	@Condition eventPlayer.isAlive()
	if distance(eventPlayer.getPosition(), yubz.getPosition()) > 30:
		kill(eventPlayer)
	wait(4.8)
	loop()

rule "freeze mauga":
	mauga.setStatusEffect(null, Status.FROZEN, 99999)
	mauga.attachTo(yubz, attachOffset)
	wait(1)
	loop()