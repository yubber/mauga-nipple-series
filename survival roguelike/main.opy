settings {
	"main": {
        "description":"it's like rein invasion but with mauga's \"guns\"\n1984 blizzard\nworkshop.codes/ds2md\n^ see above to contribute translations\n\nyubz made it\nyubz 제작, Lonepier 번역\nグルメスパイザー\nでお願いします",
        "modeName": "mauga \'pepperoni\' roguelike survival"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 12,
        "team1Slots": 10,
        "team2Slots": 0
    },
    "gamemodes": {
        "elimination": {
            "enabledMaps": [
                "workshopExpanseNight"
            ],
            "perkEliminationCatchupLevelAmount%": 100,
            "perkGeneration%": 500
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
				"health%": 500
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
                "ultDuration%": 200
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
                "Angelic Descent": "Disabled",
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

#!include "herotweaks.opy"

globalvar nipman
globalvar timer
globalvar phase
globalvar threatFx
globalvar threatListText
globalvar boonListText
globalvar i

globalvar offeredChoices
globalvar rerollCost = 20

playervar mobTarget

enum PHASE:
	INTERMISSION,
	SURVIVE,

macro isShopRound = teamScore(Team.1) % 4 == 0
macro isThreatPickRound = teamScore(Team.1) % 4 == 2
macro selectBoons = phase == PHASE.INTERMISSION and isShopRound
macro selectThreats = phase == PHASE.INTERMISSION and isThreatPickRound

macro NipmanForcePosConst = vect(0,-17-2.8,35)
macro NipmanLeftConst = vect(2.93, 10.84-2.8, 26.15)
macro NipmanRightConst = vect(-7.19, 10.8-2.8, 30.27)

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
	heal(nipman, null, 999999)
	wait()
	nipman.setHealingReceived(0)
	nipman.setDamageReceived(50)
	wait()
	nipman.setHealth(72500)

	# huds
	hudSubheader(getAllPlayers(), "== threats ==", HudPosition.TOP, 1, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
	hudHeader(getAllPlayers(), threatListText, HudPosition.TOP, 1.1, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
	hudSubheader(getAllPlayers(), "== boons ==", HudPosition.TOP, 2, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
	hudHeader(getAllPlayers(), boonListText, HudPosition.TOP, 2.1, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
	wait()

	# iwts
	createInWorldText(getAllPlayers() if selectBoons else null, "shop", vect(0,4,-15), 4, Clip.NONE, WorldTextReeval.VISIBILITY, Color.SKY_BLUE)
	createInWorldText(getAllPlayers() if selectBoons else null, "exchange milk for global buffs!", vect(0,1,-15), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.WHITE)

	timer = 99999
	waitUntil(getPlayers(Team.1).hasSpawned(), 99999)
	phase = PHASE.INTERMISSION
	timer = 60

rule "round start":
	@Condition phase == PHASE.INTERMISSION
	@Condition timer <= 0
	timer = min(90, 30 + 2 * teamScore(Team.1))
	phase = PHASE.SURVIVE
	setMatchTime(4)

rule "round finish":
	@Condition phase == PHASE.SURVIVE
	@Condition timer <= 0
	addToTeamScore(Team.1, 1)
	setMatchTime(69)
	timer = 30
	phase = PHASE.INTERMISSION
	getDeadPlayers(Team.1).respawn()
	getPlayersOnHero(Hero.DMON, Team.1).respawn()
	getPlayersOnHero(Hero.DVA, Team.1).respawn()

rule "game over":
	@Condition phase == PHASE.SURVIVE
	if [x for x in getLivingPlayers(Team.1) if x.hasSpawned()] == []:
		bigMessage(getAllPlayers(), f"game over. survived {teamScore(Team.1)} rounds!")
		declareTeamVictory(Team.1)
	wait(1.2)
	if ruleCondition:
		loop()

rule "select boons / threats":
	@Condition phase == PHASE.INTERMISSION
	@Condition isShopRound or isThreatPickRound
	
