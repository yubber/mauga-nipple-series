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
        "team2Slots": 0
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
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableKillCam": false
        }
    },
    "heroes": {
		"team2": {
			"mauga": {
				"health%": 500,
				"healingReceived%": 500
			}
		},
        "allTeams": {
            "ashe": {
                "ability1Cooldown%": 70,
                "ability2Cooldown%": 50,
				"projectileGravity%": 0,
				"projectileSpeed%": 50,
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
                "movementGravity%": 175
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
                "movementGravity%": 125,
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
            "disabledHeroes": [
                "jetpackCat"
            ],
            "general": {
                "healingReceived%": 25,
                "jumpVerticalSpeed%": 130,
            	# "Tank Passive Health Bonus": "disabled"
            }
        }
    }
}

#!translations en

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
globalvar boonListText
globalvar i
globalvar teamLives
globalvar antiCrashOn

playervar offeredChoices
playervar rerollCost = 20 # nipman's = round reward
playervar bought
playervar i
playervar ready
playervar milk # nipman's = total milk given to 1 player

playervar mobTarget

enum PHASE:
	NULL,
	INTERMISSION,
	SURVIVE,

macro isShopRound = teamScore(Team.1) % 4 == 3
macro isThreatPickRound = teamScore(Team.1) % 4 != 3
macro selectBoons = phase == PHASE.INTERMISSION and isShopRound
macro selectThreats = phase == PHASE.INTERMISSION and isThreatPickRound

macro NipmanForcePosConst = vect(0,-17-2.8,35)
macro NipmanLeftConst = vect(2.93, 10.84-2.8, 26.15)
macro NipmanRightConst = vect(-7.19, 10.8-2.8, 30.27)

macro Player.isFixedMauga = self.getPosition().y < -10 and self.getEyePosition().y > 0

#!define LeftNip NipmanLeftConst
#!define RightNip NipmanRightConst

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
	nipman.setHealingReceived(99999)
	nipman.setDamageReceived(150)
	wait()
	nipman.setHealth(72500)
	nipman.milk = 0
	nipman.rerollCost = 10
	setMatchTime(3)
	waitUntil(isAssemblingHeroes() == false)

	# huds
	hudSubheader(getAllPlayers(), "== threats ==", HudPosition.TOP, 1, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
	hudHeader(getAllPlayers(), threatListText, HudPosition.TOP, 1.1, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
	hudSubheader(getAllPlayers(), "== boons ==", HudPosition.TOP, 2, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
	hudHeader(getAllPlayers(), boonListText, HudPosition.TOP, 2.1, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
	wait()

	debug(phase)
	debug(localPlayer.offeredChoices)
	debug(threatStacks)
	setMatchTime(99999)
	teamLives = 3
	waitUntil(any([x.hasSpawned() for x in getPlayers(Team.1)]), 99999)
	phase = PHASE.INTERMISSION
	setMatchTime(60)

rule "player init":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	# getAllPlayers().disableGamemodeHud()

rule "round start, add threats":
	@Condition phase == PHASE.INTERMISSION
	@Condition getMatchTime() <= 0
	threatFx = []
	nipman.startForcingHero(Hero.MAUGA)
	wait()
	phase = PHASE.SURVIVE
	getPlayers(Team.1).ready = false
	if isThreatPickRound:
		# get max vote number, excl abstains
		for i in range(len(nipman.offeredChoices)):
			nipman.ready = max(nipman.ready, nipman.bought[i])
		# random pick from any tied winners
		nipman.bought = random.choice([x for x in nipman.offeredChoices if x == nipman.ready])
		threatStacks[nipman.bought]++
		bigMessage(getAllPlayers(), f"added threat: {threatIcons[nipman.bought]} {threatNames[nipman.bought]}")
	setMatchTime(3)
	wait(3.9)
	getPlayers(Team.1).respawn()
	bigMessage(getAllPlayers(), "round start!")
	setMatchTime(min(90, 10 + 2 * teamScore(Team.1)))

rule "round finish":
	@Condition phase == PHASE.SURVIVE
	@Condition getMatchTime() <= 0
	addToTeamScore(Team.1, 1)
	setMatchTime(69)
	destroyEffect(threatFx)
	setMatchTime(30)
	phase = PHASE.INTERMISSION
	getPlayers(Team.1).milk += nipman.rerollCost
	if isShopRound:
		nipman.startForcingHero(Hero.VENTURE)
	getDeadPlayers(Team.1).respawn()
	getPlayersOnHero(Hero.DMON, Team.1).respawn()
	getPlayersOnHero(Hero.DVA, Team.1).respawn()
	bigMessage(getAllPlayers(), "round complete!")

rule "all dead":
	@Condition phase == PHASE.SURVIVE
	if [x for x in getLivingPlayers(Team.1) if x.hasSpawned()] == []:
		teamLives--
		if teamLives == 0:
			bigMessage(getAllPlayers(), tf"game over. survived {teamScore(Team.1)} rounds!")
			declareTeamVictory(Team.1)
		else:
			bigMessage(getAllPlayers(), tf"everybody's dead! {teamLives} team lives left.")
			getPlayers(Team.1).respawn()

	wait(0.36)
	if ruleCondition:
		loop()

# shop
macro shopOptionPos(itemI, y=0, z=15):
	vect(evenSpaceCentered(itemI, 4, 30), y, z)
macro shopOptionRad = 4
macro heroSwapPos(y=0):
	vect(0,y,-10)

def rerollItems():
	if isShopRound:
		eventPlayer.offeredChoices = [random.randint(0, BOONS.TIME_OFF), random.randint(0, BOONS.TIME_OFF)]
		eventPlayer.bought = [false, false]
		while eventPlayer.offeredChoices[0] == eventPlayer.offeredChoices[1]:
			# no boon limit check
			eventPlayer.offeredChoices[1] = (random.randint(0, BOONS.TIME_OFF))
			wait(0.032)

rule "shop / threat select huds":
	# shop: 2 items, reroll, ready
	for i in range(2):
		wait(0.24)
		# ring
		createEffect(getAllPlayers() if selectBoons else null, Effect.RING, Color.SKY_BLUE, shopOptionPos(i), shopOptionRad, EffectReeval.VISIBILITY)
		# icon
		createInWorldText(getAllPlayers() if selectBoons else null, boonIcons[localPlayer.offeredChoices[evalOnce(i)]], shopOptionPos(i, 10, 18), 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# title
		createInWorldText(getAllPlayers() if selectBoons else null, boonNames[localPlayer.offeredChoices[evalOnce(i)]], shopOptionPos(i, 8, 18), 2.6, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.SKY_BLUE)
		# desc
		createInWorldText(getAllPlayers() if selectBoons else null, boonDescs[localPlayer.offeredChoices[evalOnce(i)]], shopOptionPos(i, 4, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# buy
		createInWorldText(getAllPlayers() if selectBoons else null, ft"{iconString(Icon.CHECKMARK)} bought!" if localPlayer.bought[evalOnce(i)] else tf"buy: {boonCost(localPlayer.offeredChoices[evalOnce(i)])} milk", shopOptionPos(i, 1, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.GRAY if localPlayer.bought[evalOnce(i)] else Color.WHITE)
	# reroll
	createInWorldText(getAllPlayers() if selectBoons else null, ft"{buttonToString(Button.INTERACT)} - reroll ({localPlayer.rerollCost} milk)", shopOptionPos(2, 5, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)
	# ready
	createInWorldText(getAllPlayers() if selectBoons else null, "{} - {}".format(buttonToString(Button.INTERACT), t"cancel ready" if localPlayer.ready else t"ready up"), shopOptionPos(3, 5, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE)

	# threats: 3, abstain
	for i in range(4):
		# ring
		createEffect(getAllPlayers() if selectThreats else null, Effect.RING, Color.ORANGE, shopOptionPos(i), shopOptionRad, EffectReeval.VISIBILITY)
	for i in range(3):
		wait()
		# icon
		createInWorldText(getAllPlayers() if selectThreats else null, threatIcons[nipman.offeredChoices[i]], shopOptionPos(i, 10, 18), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE)
		# title
		createInWorldText(getAllPlayers() if selectThreats else null, evalOnce(threatNames[nipman.offeredChoices[i]]), shopOptionPos(i, 8, 18), 2.6, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE)
		# desc
		createInWorldText(getAllPlayers() if selectThreats else null, evalOnce(threatDescs[nipman.offeredChoices[i]]), shopOptionPos(i, 4, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)
		# buy
		createInWorldText(getAllPlayers() if selectThreats else null, ft"{iconString(Icon.CHECKMARK)} voted!" if localPlayer.bought == evalOnce(i) else tf"{buttonToString(Button.INTERACT)} - vote", shopOptionPos(i, 1, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)

	createInWorldText(getAllPlayers() if selectThreats else null, ft"{iconString(Icon.CHECKMARK)} abstained!" if localPlayer.bought == 3 else tf"{buttonToString(Button.INTERACT)} - abstain", shopOptionPos(i, 1, 18), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE)

	# change hero
	createEffect(getAllPlayers() if phase == PHASE.INTERMISSION else null, Effect.RING, Color.GRAY, heroSwapPos(0), 4, EffectReeval.VISIBILITY)
	createInWorldText(getAllPlayers() if phase == PHASE.INTERMISSION else null, tf"{buttonToString(Button.INTERACT)} - swap hero", heroSwapPos(1), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.LIGHT_VIOLET)

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
	nipman.bought = threatStacks.map(lambda elem, index: index).filter(lambda e: threatStacks[e] < threatMaxStacks[e])
	smallMessage(getAllPlayers(),nipman.bought)
    nipman.offeredChoices = random.shuffle(nipman.bought).slice(0, 3)
	getPlayers(Team.1).bought = -1
	nipman.bought = [0,0,0,0]

rule "shop select":
	@Event eachPlayer
	@Condition phase == PHASE.INTERMISSION
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
	wait(0.12)
	if distance(eventPlayer.getPosition(), heroSwapPos()) <= 4:
		eventPlayer.setAllowedHeroes(getTankHeroes().exclude(eventPlayer.getHero()))
		wait()
		eventPlayer.setAllowedHeroes(getAllHeroes())
	elif isShopRound:
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
							playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, shopOptionPos(2), 5)
							rerollItems()
						break
					default: # buy
						if eventPlayer.milk < boonCost(eventPlayer.i):
							smallMessage(eventPlayer, "can't afford this!")
						elif eventPlayer.bought[i]:
							smallMessage(eventPlayer, "already bought this round.")
						else:
							eventPlayer.boonStacks[eventPlayer.i]++
							playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer, 20)
							playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, shopOptionPos(eventPlayer.i), 5)
							eventPlayer.milk -= boonCost(eventPlayer.i)
							eventPlayer.bought[i] = true
						break
				return
	elif isThreatPickRound:
		for eventPlayer.i in range(4):
			if distance(eventPlayer.getPosition(), shopOptionPos(eventPlayer.i)) <= shopOptionRad:
				if eventPlayer.bought == eventPlayer.i:
					return
				elif eventPlayer.bought != -1:
					nipman.bought[eventPlayer.i]--
				else:
					eventPlayer.ready = true
					eventPlayer.communicate(Comms.READY)
				nipman.bought[eventPlayer.i]++
				eventPlayer.bought = eventPlayer.i
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
