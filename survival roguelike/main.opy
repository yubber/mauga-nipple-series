macro maxPlayers = 10
settings {
	"main": {
        "description":"inspired by chaos central\n\nyubz made it",
        "modeName": "mauga \'pepperoni\' roguelike bullet hell"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 12,
        "team1Slots": maxPlayers,
        "team2Slots": 0,
        "returnToLobby": "never"
    },
    "gamemodes": {
        "tdm": {
            "enabledMaps": [
                "workshopIslandNight"
            ],
            "perkEliminationCatchupLevelAmount%": 100,
            "perkGeneration%": 250
        },
        "general": {
			"enablePerks": true,
            "tankPassiveHealthBonus": "Disabled",
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableKillCam": false,
			"needsImbalancedTeamScoreToWin": true,
            "team1ScoreToWin": 1,
            "team2ScoreToWin": 200
        }
    },
    "heroes": {
		"team2": {
			"mauga": {
				"health%": 500,
				"healingReceived%": 500
			}
		},
        "team1": {
            "ashe": {
                "ability1Cooldown%": 70,
                "ability2Cooldown%": 50,
				"projectileGravity%": 0,
				"projectileSpeed%": 20,
            },
            "baptiste": {
                "jumpVerticalSpeed%": 100,
                "ultDuration%": 200,
				"movementGravity%": 200,
            },
            "brigitte": {
                "movementSpeed%": 85
            },
            "doctrine": {
                "Infuse Cooldown Time": "120%"
            },
            "echo": {
                "enablePassive": false
            },
            "freja": {
                "ability2Cooldown%": 150,
                "ability2Height%": 75
            },
            "hanzo": {
                "ability3Distance%": 150,
                "ability2Quantity%": 12
            },
            "juno": {
                "ability1Cooldown%": 200,
                "ability1Duration%": 70,
                "movementSpeed%": 80
            },
            "kiriko": {
                "ability2Cooldown%": 200,
                "ability1Cooldown%": 200
            },
            "lifeweaver": {
                "primaryFireRange%": 200,
                "secondaryFireCooldown%": 500
            },
            "mauga": {},
            "mei": {
                "ability1Cooldown%": 150
            },
            "mercy": {
                "Angelic Descent": "Off",
                "Flash Heal Cooldown Time": "200%",
                "health%": 60,
                "ultGen%": 50
            },
            "pharah": {
                "passiveMaxTime%": 50,
                "passiveRechargeRate%": 40
            },
            "symmetra": {
                "ability1Cooldown%": 25
            },
            "torbjorn": {
                "ability1Cooldown%": 0,
                "ability2Cooldown%": 25,
                "ability2Duration%": 25
            },
            "tracer": {
                "health%": 60
            },
            "vendetta": {
                "ultGen%": 300,
                "secondaryFireRechargeRate%": 500
            },
            "venture": {
                "ability1Cooldown%": 75,
                "ability1Duration%": 20
            },
            "wreckingBall": {
                "secondaryFireCooldown%": 350,
                "health%": 50
            },
            "wuyang": {
                "ability1Duration%": 500,
                "ultGen%": 200
            },
            "roadhog": {
                "movementSpeed%": 75,
            },
            "disabledHeroes": [
                "jetpackCat"
            ],
            "general": {
                "healingReceived%": 25,
                "jumpVerticalSpeed%": 130,
            	"movementSpeed%": 110
            }
        }
    }
}

#!translations en ko

#!extension beamEffects
#!extension buffStatusEffects
#!extension energyExplosionEffects
#!extension explosionSounds
#!extension spawnMoreDummyBots
#!extension projectiles

#!setupTags
#!define ScreenPos(x, y, CamPos, LookPos, dist) __script__("../screenPos.js")
macro evenSpaceCentered(itmI, itemCount, span, center=0):
	((itmI / (itemCount - 1) - 0.5) * span + center)
macro getSpawnedLivingPlayers(Team):
	[x for x in getLivingPlayers(Team.1) if x.hasSpawned()]

#!include "herotweaks.opy"

globalvar nipman
globalvar phase
globalvar threatFx
globalvar threatListText
globalvar i
globalvar teamLives
globalvar antiCrashOn

playervar offeredChoices
playervar rerollCost = 20 # nipman's = round reward
playervar bought
playervar i
playervar ready
playervar milk # nipman's = total milk given to 1 player
playervar boonListText

# 3rd person - https://workshop.codes/DE8A7/snippet by jeshaal
playervar Camera_Distance
playervar WorldVector_Offset
macro Player.Facing_Distance = 22

# humans: is 3rd person
playervar mobTarget

enum PHASE:
	NULL,
	INTERMISSION,
	SURVIVE,

macro isShopRound = teamScore(Team.1) % 4 == 3
macro isThreatPickRound = teamScore(Team.1) % 4 != 3
macro selectBoons = phase == PHASE.INTERMISSION and isShopRound
macro selectThreats = phase == PHASE.INTERMISSION and isThreatPickRound
macro fadeoutLookAway(pos,r=220,g=220,b=220):
	rgba(r,g,b,min(255, 360 - 20 * angleBetweenVectors(localPlayer.getFacingDirection() * vect(1,0,1), directionTowards(localPlayer.getEyePosition(), pos) * vect(1,0,1))))

macro NipmanForcePosConst = vect(0,-17-2.8,35)
macro NipmanLeftConst = vect(2.93, 10.84-2.8, 26.15)
macro NipmanRightConst = vect(-7.19, 10.8-2.8, 30.27)

macro Player.isFixedMauga = self.getPosition().y < -10 and self.getEyePosition().y > 0

#!define LeftNip NipmanLeftConst
#!define RightNip NipmanRightConst

#!define tabularTranslateFix(vars, wrapTranslate, arr) __script__("tabularTranslateFix.js")
#!define dynamicConcatter(strin, n, literals, replaceI) __script__("dynamicConcatter.js")

#!include "boons.opy"
#!include "threats.opy"

rule "global init":
	# spawn mauga
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	nipman = getLastCreatedEntity()
	nipman.startForcingPosition(NipmanForcePosConst, false)
	nipman.startFacing(Vector.BACKWARD, 999, Relativity.TO_WORLD, FacingReeval.NONE)
	nipman.disablePlayerCollision()
	nipman.disableEnvironmentCollision(true)
	nipman.startScalingSize(20, false) # max size
	wait(0.08)
	nipman.setMaxHealth(10000)
	kill(nipman, null) # this is to fill hp and reset his pose
	nipman.setKnockbackReceived(0)
	disableGamemodeCompletion()
	disableScoring()
	disableAnnouncer()
	heal(nipman, null, 999999)
	wait()
	threatListText = ""
	nipman.setHealingReceived(99999)
	nipman.setDamageReceived(150)
	wait()
	nipman.setHealth(72500)
	nipman.milk = 0
	nipman.rerollCost = 10
	milkGainMod = 1
	setMatchTime(3)
	waitUntil(isAssemblingHeroes() == false)

	# huds
	hudSubheader(getAllPlayers(), "== threats ==", HudPosition.TOP, 1, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(), threatListText, null, " \n ", HudPosition.TOP, 1.1, Color.ORANGE, reevaluation=HudReeval.VISIBILITY_AND_STRING)
	hudSubheader(getAllPlayers(), "== boons ==", HudPosition.TOP, 2, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(),
		fb"\&fullwidth_space; " dynamicConcatter("{'  ' if localPlayer.boonStacks[%] and % != 0 else ''}{boonIcons[%] if localPlayer.boonStacks[%] else ''}{localPlayer.boonStacks[%] if localPlayer.boonStacks[%] else ''}",20, "", "%") " \&fullwidth_space;",
		null, " \n ", HudPosition.TOP, 2.1, Color.SKY_BLUE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	# time and alive players
	hudSubtext(getAllPlayers() if phase == PHASE.SURVIVE else null, f"<tx0C0000000001935F> {getMatchTime()} | <tx0C0000000002A917> {getNumberOfLivingPlayers(Team.1)}", HudPosition.TOP, 3, rgb(255, sin(getTotalTimeElapsed() * (4 - getNumberOfLivingPlayers(Team.1))), sin(getTotalTimeElapsed() * (4 - getNumberOfLivingPlayers(Team.1)))) if getNumberOfLivingPlayers(Team.1) < 3 else Color.WHITE, HudReeval.VISIBILITY_STRING_AND_COLOR)
	# time and milk
	hudSubtext(getAllPlayers() if phase == PHASE.INTERMISSION else null, ft"<tx0C0000000001935F> {getMatchTime()} | {floor(localPlayer.milk)} milk", HudPosition.TOP, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	# hero tweaks
	hudText(localPlayer if localPlayer.getHero() in heroTweakHero else null, heroIcon(localPlayer.getHero()), t"hero tweaks", heroTweakDesc[heroTweakHero.index(localPlayer.getHeroOfDuplication() if localPlayer.isDuplicatingAHero() else localPlayer.getHero())], HudPosition.ACTUALLY_LEFT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	# lives
	hudText(getAllPlayers(), null, t"team lives", '♥♥♥♥♥♥♥♥♥♥♥♥'.substring(0, teamLives), HudPosition.RIGHT, 0, Color.ROSE,Color.ROSE,Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
	wait()

	debug(HealthFormula(localPlayer))
	debug(localPlayer.boonStacks)
	setMatchTime(99999)
	teamLives = 3
	waitUntil(any([x.hasSpawned() for x in getPlayers(Team.1)]), 99999)
	phase = PHASE.INTERMISSION
	setMatchTime(60)

rule "player init":
	@Event eachPlayer
	@Team 1
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.isDummy() == false
	getAllPlayers().disableGamemodeHud()
	eventPlayer.disableRespawn()
	eventPlayer.boonStacks = [0 for x in boonScores]
	eventPlayer.Camera_Distance = -4
	eventPlayer.milk = nipman.milk
	applyStatBoons()
	if phase == PHASE.SURVIVE:
		kill(eventPlayer, null)
		smallMessage(eventPlayer, t"you will join next round.")

rule "round start, add threats":
	@Condition phase == PHASE.INTERMISSION
	@Condition getMatchTime() <= 1
	wait(1, Wait.ABORT_WHEN_FALSE)
	threatFx = []
	nipman.startForcingHero(Hero.MAUGA)
	wait()
	getPlayers(Team.1).ready = false
	# add threat
	if isThreatPickRound:
		# nipman.ready =  max vote number, excl abstains
		for i in range(len(nipman.offeredChoices)):
			nipman.ready = max(nipman.ready, nipman.bought[i])
		# random pick from any tied winners
		nipman.bought = random.choice(nipman.offeredChoices.filter(lambda e, idx: nipman.bought[idx] == nipman.ready))
		threatStacks[nipman.bought]++
		nipman.rerollCost += threatMilkBonus(nipman.bought)
		bigMessage(getAllPlayers(), f"added threat:  {threatIcons[nipman.bought]} {_(threatNames[nipman.bought])}")
	getPlayers(Team.1).respawn()
	bigMessage(getAllPlayers(), "round start!")
	wait(0.8)
	# threat text
	threatListText = fb"\&fullwidth_space; " dynamicConcatter("{'  ' if threatStacks[%] and % != 0 else ''}{threatIcons[%] if threatStacks[%] else ''}{threatStacks[%] if threatStacks[%] else ''}",20, "", "%") " \&fullwidth_space;"
	# calc global buffs and reset speed
	nipman.boonStacks = [0 for x in boonScores]
	for i in range(getNumberOfPlayers(Team.1)):
		getPlayersInSlot(i, Team.1).setMoveSpeed(SpeedFormula(getPlayersInSlot(i, Team.1)))
		nipman.boonStacks[BOONS.MILK] += getPlayersInSlot(i, Team.1).boonStacks[BOONS.MILK]
		nipman.boonStacks[BOONS.OVERTIME] += getPlayersInSlot(i, Team.1).boonStacks[BOONS.OVERTIME]
		nipman.boonStacks[BOONS.TIME_OFF] += getPlayersInSlot(i, Team.1).boonStacks[BOONS.TIME_OFF]
	setMatchTime(min(180, (10 + 2 * teamScore(Team.1)) + nipman.boonStacks[BOONS.OVERTIME] * 20) * 0.8 ** nipman.boonStacks[BOONS.TIME_OFF])
	setTeamScore(Team.2, 199)
	wait(0.24)
	phase = PHASE.SURVIVE

rule "round finish":
	@Condition phase == PHASE.SURVIVE
	@Condition getMatchTime() <= 1
	wait(1, Wait.ABORT_WHEN_FALSE)
	addToTeamScore(Team.1, 1)
	setMatchTime(69)
	destroyEffect(threatFx)
	setMatchTime(30)
	for i in range(len(threatDummies)):
		destroyDummy(threatDummies[i].getTeam(), threatDummies[i].getSlot())
	threatDummies = []
	phase = PHASE.INTERMISSION
	getPlayers(Team.1).milk += (nipman.rerollCost + 30 * nipman.boonStacks[BOONS.OVERTIME]) * (1 + 0.15 * nipman.boonStacks[BOONS.MILK])
	nipman.milk += (nipman.rerollCost + 30 * nipman.boonStacks[BOONS.OVERTIME]) * (1 + 0.15 * nipman.boonStacks[BOONS.MILK])
	if isShopRound:
		nipman.startForcingHero(Hero.VENTURE)
	getDeadPlayers(Team.1).respawn()
	getPlayersOnHero(Hero.DMON, Team.1).respawn()
	getPlayersOnHero(Hero.DVA, Team.1).respawn()
	bigMessage(getAllPlayers(), "round complete!")
	# milk fx
	for nipman.i in range(min(100 / getNumberOfPlayers(Team.1), teamScore(Team.1) * 3)): # max 100 split btwn players
		for i in range(getNumberOfPlayers(Team.1)):
			createHomingProjectile(Projectile.ECHO_STICKY_BOMB, null, LeftNip if nipman.i % 2 else RightNip, directionFromAngles(180 + random.uniform(-60, 60), random.uniform(-50, 50)), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 99999, 0, 15, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, 0, 15, 10, 0, getPlayersInSlot(i, Team.1))
		wait(0.096)
	setTeamScore(Team.2, 0)
	getPlayers(Team.1).setMoveSpeed(250)

rule "all dead":
	@Condition phase == PHASE.SURVIVE
	if [x for x in getLivingPlayers(Team.1) if x.hasSpawned()] == []:
		getPlayersOnHero(Hero.ANRAN, Team.1).forceButtonPress(Button.ULTIMATE)
		wait(1.2)
		if [x for x in getLivingPlayers(Team.1) if x.hasSpawned()] == []:
			teamLives--
			if teamLives <= 0:
				bigMessage(getAllPlayers(), tf"game over. survived {teamScore(Team.1)} rounds!")
				declareTeamVictory(Team.1)
				return
			else:
				bigMessage(getAllPlayers(), tf"everybody's dead! {teamLives} team lives left.")
				getPlayers(Team.1).respawn()
	wait(0.36)
	if ruleCondition:
		loop()

rule "heels broke = died":
	@Event playerDied
	@Team 1
	if phase == PHASE.INTERMISSION:
		eventPlayer.respawn()

# shop
macro shopOptionPos(itemI, y=0, z=15):
	vect(evenSpaceCentered(itemI, 4, 30), y, z)
macro shopOptionRad = 4
macro heroSwapPos(y=0):
	shopOptionPos(0, y, -15)
macro shopZOffset = 30
globalvar configItemNames = [___("swap hero"), ___("toggle 3rd person"), ___("change camera distance"), ___("swap camera shoulder")]
macro configItemIcons = ["<tx0C0000000002A917>", iconString(Icon.EYE), "<tx0C0000000002AA00>", "\&horizontal_arrow;"]

def rerollItems():
	if isShopRound:
		eventPlayer.offeredChoices = [random.randint(0, BOONS.TIME_OFF), random.randint(0, BOONS.TIME_OFF)]
		eventPlayer.bought = [false, false]
		while eventPlayer.offeredChoices[0] == eventPlayer.offeredChoices[1]:
			# no boon limit check
			eventPlayer.offeredChoices[1] = (random.randint(0, BOONS.TIME_OFF))
			wait(0.032)

rule "shop / threat select / cam / hero select huds":
	### shop: 2 items, reroll, ready
	for i in range(4):
		# ring
		createEffect(getAllPlayers() if selectBoons else null, Effect.RING, Color.SKY_BLUE, shopOptionPos(i), shopOptionRad, EffectReeval.VISIBILITY)
	for i in range(2):
		wait(0.24)
		# icon
		createInWorldText(getAllPlayers() if selectBoons else null, boonIcons[localPlayer.offeredChoices[evalOnce(i)]], shopOptionPos(i, 6.5, shopZOffset), 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# title
		createInWorldText(getAllPlayers() if selectBoons else null, _(boonNames[localPlayer.offeredChoices[evalOnce(i)]]), shopOptionPos(i, 5, shopZOffset), 2.6, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.SKY_BLUE)
		# desc
		createInWorldText(getAllPlayers()if selectBoons else null, _(boonDescs[nipman.offeredChoices[evalOnce(i)]]), shopOptionPos(i, 2.7, shopZOffset), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, fadeoutLookAway(evalOnce((shopOptionPos(i, 3, shopZOffset)))))
		# buy
		createInWorldText(getAllPlayers() if selectBoons else null, ft"{iconString(Icon.CHECKMARK)} bought!" if localPlayer.bought[evalOnce(i)] else tf"buy: {boonCost(localPlayer.offeredChoices[evalOnce(i)])} milk", shopOptionPos(i, 1, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.GRAY if localPlayer.bought[evalOnce(i)] else Color.WHITE)
	# reroll
	createInWorldText(getAllPlayers() if selectBoons else null, iconString(Icon.RECYCLE), shopOptionPos(2, 2, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)
	createInWorldText(getAllPlayers() if selectBoons else null, ft"{buttonToString(Button.INTERACT)} - reroll ({localPlayer.rerollCost} milk)", shopOptionPos(2, 1, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)
	# ready
	createInWorldText(getAllPlayers() if selectBoons else null, iconString(Icon.CHECKMARK) if localPlayer.ready else iconString(Icon.EXCLAMATION_MARK), shopOptionPos(3, 2, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)
	createInWorldText(getAllPlayers() if selectBoons else null, tf"{buttonToString(Button.INTERACT)} - cancel ready" if localPlayer.ready else tf"{buttonToString(Button.INTERACT)} - ready up", shopOptionPos(3, 1, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)

	### threats: 3, abstain
	for i in range(4):
		# ring
		createEffect(getAllPlayers() if selectThreats else null, Effect.RING, Color.ORANGE, shopOptionPos(i), shopOptionRad, EffectReeval.VISIBILITY)
	for i in range(3):
		wait(0.24)
		# icon
		createInWorldText(getAllPlayers() if selectThreats else null, threatIcons[nipman.offeredChoices[evalOnce(i)]], shopOptionPos(i, 7, shopZOffset), 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# title
		createInWorldText(getAllPlayers() if selectThreats else null, _(threatNames[nipman.offeredChoices[evalOnce(i)]]), shopOptionPos(i, 5.5, shopZOffset), 2.6, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE)
		# desc
		createInWorldText(getAllPlayers()if selectThreats else null, _(threatDescs[nipman.offeredChoices[evalOnce(i)]]), shopOptionPos(i, 2.7, shopZOffset), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, fadeoutLookAway(evalOnce((shopOptionPos(i, 3, shopZOffset)))))
		# milk bonus
		createInWorldText(getAllPlayers()if selectThreats else null, tf"+{threatMilkBonus(evalOnce(i))} milk per round", shopOptionPos(i, 1.7, shopZOffset), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# buy
		createInWorldText(getAllPlayers() if selectThreats else null, ft"{iconString(Icon.CHECKMARK)} voted!" if localPlayer.bought == evalOnce(i) else tf"{buttonToString(Button.INTERACT)} - vote", shopOptionPos(i, 1, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)

	createInWorldText(getAllPlayers() if selectThreats else null, ft"{iconString(Icon.CHECKMARK)} abstained!" if localPlayer.bought == 3 else tf"{buttonToString(Button.INTERACT)} - abstain", shopOptionPos(i, 1, shopZOffset), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)

	### misc: hero, cam settings
	for i in range(4):
		createEffect(getAllPlayers() if phase == PHASE.INTERMISSION else null, Effect.RING, Color.LIGHT_GRAY, shopOptionPos(i, 0, -15), 4, EffectReeval.VISIBILITY)
		createInWorldText(getAllPlayers() if phase == PHASE.INTERMISSION else null, _(configItemNames[evalOnce(i)]), shopOptionPos(i, 1, -15), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		createInWorldText(getAllPlayers() if phase == PHASE.INTERMISSION else null, configItemIcons[i], shopOptionPos(i, 5, -15), 2.6, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE)

rule "init select boons":
	@Event eachPlayer
	@Condition selectBoons
	wait(eventPlayer.getSlot() * 0.016)
	# check: limit, appear level, dupe
	eventPlayer.offeredChoices = []
	if isShopRound:
		eventPlayer.bought = [false, false]
		rerollItems()

rule "init select threats":
	@Condition selectThreats
	nipman.bought = threatStacks.map(lambda elem, index: index).filter(lambda e: threatStacks[e] < threatMaxStacks[e] and teamScore(Team.1) >= threatMinRound(e))
    nipman.offeredChoices = random.shuffle(nipman.bought).slice(0, 3)
	getPlayers(Team.1).bought = -1
	nipman.bought = [0,0,0,0]

rule "shop select":
	@Event eachPlayer
	@Condition phase == PHASE.INTERMISSION
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
	wait(0.12)
	for eventPlayer.i in range(4): # settings
		if distance(eventPlayer.getPosition(), shopOptionPos(eventPlayer.i, 0, -15)) <= 4:
			switch eventPlayer.i:
				case 0: # hero
					eventPlayer.setAllowedHeroes(getTankHeroes().exclude(eventPlayer.getHero()))
					wait()
					eventPlayer.setAllowedHeroes(getAllHeroes().exclude(Hero.JETPACK_CAT))
					break
				case 1: # 3p toggle
					eventPlayer.mobTarget = not eventPlayer.mobTarget
					eventPlayer.stopCamera()
					wait()
					if eventPlayer.mobTarget:
						eventPlayer.startCamera(raycastHitPosition(eventPlayer + (eventPlayer.getEyePosition() - eventPlayer.getPosition()), eventPlayer + (eventPlayer.getEyePosition() - eventPlayer.getPosition()) + eventPlayer.getFacingDirection() * eventPlayer.Camera_Distance + worldVector(eventPlayer.WorldVector_Offset, eventPlayer, Transform.ROTATION), null, eventPlayer, false) + eventPlayer.getFacingDirection() * 0.3, eventPlayer + (eventPlayer.getEyePosition() - eventPlayer.getPosition()) + (eventPlayer.getFacingDirection() * eventPlayer.Facing_Distance * (ceil((distance(eventPlayer + (eventPlayer.getEyePosition() - eventPlayer.getPosition()), raycastHitPosition(eventPlayer + (eventPlayer.getEyePosition() - eventPlayer.getPosition()), eventPlayer + eventPlayer.getEyePosition() + eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 1000, null, eventPlayer, false))) / eventPlayer.Facing_Distance))), 800)
						#Offset
						eventPlayer.WorldVector_Offset = vect(-0.6, 1, 0)
						#Rather than a flat number or a raycast, the distance between eye position and facing direction*distance only updates every (Facing_Distance) meters.
					break
				case 2: # cam distance
					eventPlayer.Camera_Distance = eventPlayer.Camera_Distance % 6
					eventPlayer.Camera_Distance -= 0.5
					break
				case 3: # cam shoulder
    				eventPlayer.WorldVector_Offset = vect(eventPlayer.WorldVector_Offset.x * -1, eventPlayer.WorldVector_Offset.y, eventPlayer.WorldVector_Offset.z)
					break
			playEffect(eventPlayer, DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR_SOUND, Color.TEAM_1, eventPlayer, 10)
			return
	if isShopRound: # shop
		for eventPlayer.i in range(4):
			if distance(eventPlayer.getPosition(), shopOptionPos(eventPlayer.i)) <= shopOptionRad:
				switch eventPlayer.i:
					case 3: # ready
						eventPlayer.ready = not eventPlayer.ready
						if eventPlayer.ready:
							eventPlayer.communicate(Comms.READY)
						break
					case 2: # reroll
						if eventPlayer.milk < eventPlayer.rerollCost:
							smallMessage(eventPlayer, "can't afford this!")
						else:
							eventPlayer.milk -= eventPlayer.rerollCost
							playEffect(eventPlayer, DynamicEffect.SOMBRA_LOGO_SOUND, Color.TEAM_1, eventPlayer, 20)
							playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, shopOptionPos(2), 15)
							rerollItems()
							eventPlayer.rerollCost += 20
						break
					default: # buy
						if eventPlayer.milk < boonCost(eventPlayer.offeredChoices[eventPlayer.i]):
							smallMessage(eventPlayer, "can't afford this!")
						elif eventPlayer.bought[eventPlayer.i]:
							smallMessage(eventPlayer, "out of stock.")
						else:
							eventPlayer.boonStacks[eventPlayer.offeredChoices[eventPlayer.i]]++
							playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer, 20)
							playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, shopOptionPos(eventPlayer.i), 15)
							eventPlayer.milk -= boonCost(eventPlayer.offeredChoices[eventPlayer.i])
							eventPlayer.bought[eventPlayer.i] = true
							for eventPlayer.i in range(5):
								createHomingProjectile(Projectile.ECHO_STICKY_BOMB, eventPlayer, eventPlayer, directionFromAngles(random.uniform(-30, 30), random.uniform(0, -90)), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.2, 1, 0, 15, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, 0, 15, 10, 0, nipman)
								wait(0.096)
							applyStatBoons()
						break
				return
	elif isThreatPickRound: # threat
		for eventPlayer.i in range(4):
			if distance(eventPlayer.getPosition(), shopOptionPos(eventPlayer.i)) <= shopOptionRad:
				if eventPlayer.bought == eventPlayer.i:
					return
				elif eventPlayer.bought != -1: # remove old vote
					nipman.bought[eventPlayer.i]--
				else:
					eventPlayer.ready = true
					eventPlayer.communicate(Comms.READY)
				nipman.bought[eventPlayer.i]++
				eventPlayer.bought = eventPlayer.i
				playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.TEAM_1, eventPlayer, 20)
				return

rule "ready skip":
	@Condition phase == PHASE.INTERMISSION
	wait(1.2, Wait.ABORT_WHEN_FALSE)
	# maybe have a more advanced early vote calling system for threat picking sometime
	if all([x.ready for x in getPlayers(Team.1)]):
		setMatchTime(1)
	else:
		loop()

# wingstop
rule "lobby size balancing, big mauga status check":
	wait(1.6)
	getPlayers(Team.1).setDamageReceived(100 - 0.45 * (maxPlayers - getNumberOfPlayers(Team.1)) ** 2)
	if nipman.getHero() == Hero.MAUGA:
		nipman.setStatusEffect(null, Status.FROZEN, 99999)
	nipman.setStatusEffect(null, Status.UNKILLABLE, 99999)
	nipman.disableNameplatesFor(getAllPlayers())
	heal(nipman, null, 99999)
	loop()

rule "wake up":
	@Event eachPlayer
	@Team 2
	@Hero mauga
	@Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN)
	eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
	wait(0.112)
	if ruleCondition:
		loop()

rule "get up":
	@Event eachPlayer
	@Team 2
	@Hero mauga
	@Condition eventPlayer.hasStatusEffect(Status.ASLEEP)
	eventPlayer.clearStatusEffect(Status.ASLEEP)
	wait(0.112)
	if ruleCondition:
		loop()

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
	wait(5, Wait.ABORT_WHEN_FALSE)
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	nipman = getLastCreatedEntity()
	nipman.startForcingPosition(NipmanForcePosConst, false)
	nipman.startFacing(Vector.BACKWARD, 999, Relativity.TO_WORLD, FacingReeval.NONE)
	nipman.disablePlayerCollision()
	nipman.startScalingSize(50, false)
	wait(0.08)
	nipman.setMaxHealth(10000)
	# kill(nipman, null) # this is to fill hp and reset his pose
	nipman.setKnockbackReceived(0)
	disableGamemodeCompletion()
	disableScoring()
	heal(nipman, null, 999999)
	wait()
	nipman.setHealingReceived(99999)
	wait()
	wait(1, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		goto RULE_START

rule "charge no breaky":
	@Event eachPlayer
	@Hero reinhardt
	@Condition eventPlayer.isUsingAbility1()
	@Condition eventPlayer.getPosition().z > 17
	@Condition eventPlayer.getFacingDirection().z > -0.7
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, t"do not the mauga")

rule "charge no breaky more maugas":
	@Event eachPlayer
	@Hero reinhardt
	@Condition threatStacks[THREATS.MORE]
	@Condition eventPlayer.isUsingAbility1()
	@Condition ((eventPlayer.getPosition().z < -17 and eventPlayer.getFacingDirection().z < 0.7)
	or (eventPlayer.getPosition().x < -17 and eventPlayer.getFacingDirection().x < 0.7)
	or (eventPlayer.getPosition().x > 17 and eventPlayer.getFacingDirection().x > -0.7))
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, t"do not the mauga")

rule "echo charge no breaky":
	# bug found by https://x.com/mtndewmpdgirl/status/1923835540371034434
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.REINHARDT
	@Condition eventPlayer.isUsingAbility1()
	@Condition eventPlayer.getPosition().z > 18
	@Condition eventPlayer.getFacingDirection().z > -0.7
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, t"do not the mauga")

rule "echo charge no breaky more maugas":
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.REINHARDT
	@Condition threatStacks[THREATS.MORE]
	@Condition eventPlayer.isUsingAbility1()
	@Condition ((eventPlayer.getPosition().z < -18 and eventPlayer.getFacingDirection().z < 0.7)
		or (eventPlayer.getPosition().x < -18 and eventPlayer.getFacingDirection().x < 0.7)
		or (eventPlayer.getPosition().x > 18 and eventPlayer.getFacingDirection().x > -0.7))
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, t"do not the mauga")

rule "flux no breaky":
	@Event playerDealtDamage
	@Hero sigma
	@Condition eventAbility == Button.ULTIMATE
	@Condition victim == nipman or victim.isFixedMauga
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, "do not the mauga")
	wait(0.8)
	eventPlayer.setUltCharge(100)
rule "punch unbreaky":
	@Event playerDealtDamage
	@Hero doomfist
	@Condition victim == nipman # or (obj == OBJ.MORE and victim in objPos)
	@Condition eventAbility == Button.SECONDARY_FIRE
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)

rule "echo punch unbreaky":
	@Event playerDealtDamage
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.DOOMFIST
	@Condition victim == nipman # or (obj == OBJ.MORE and victim in objPos)
	@Condition eventAbility == Button.SECONDARY_FIRE
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)
rule "hook unbreaky":
	@Event playerDealtDamage
	@Hero roadhog
	@Condition victim == nipman or victim.isFixedMauga
	@Condition eventAbility == Button.ABILITY_1
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)
rule "echo hook unbreaky":
	@Event playerDealtDamage
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.ROADHOG
	@Condition victim == nipman or victim.isFixedMauga
	@Condition eventAbility == Button.ABILITY_1
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)
