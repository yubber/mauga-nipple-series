settings {
    "main": {
        "description":"it's like rein invasion but with mauga's milkers\nDS2MD\n\nyubz made it\nyubz 제작, Lonepier 번역",
        "modeName": "mauga n!pple pve"
		# "description": "마우가의 찌!찌!를 공략하는 보스레이드\nDS2MD\n\nyubz 제작, Lonepier 번역",
        # "modeName": "마우가 찌!찌! pve"
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
            ],
			"enablePerks": true,
            "perkEliminationCatchupLevelAmount%": 100,
            "perkGeneration%": 500
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
            # "winston": {
            #     "ammoClipSize%": 40,
            # },
            "lifeweaver": {
                "primaryFireRange%": 200,
                "ultHealth%": 300
            },
            "widowmaker": {
                "ability2Cooldown%": 10
            },
			"venture": {
                "ability1Cooldown%": 120
            },
			"echo": {
                "ability1Cooldown%": 120
            },
			# "roadhog": {
            #     "ultGen%":
            # },
			"zarya": {
                "ultGen%": 25,
				"ability1Cooldown%": 65,
				"ability2Cooldown%": 65
            },
			"cassidy":{
				"damageDealt%": 85,
                "ultGen%": 70
			},
			"doomfist":{
				"ammoRegenerationTime%": 33,
                "ability1Cooldown%": 50,
                "ability2Cooldown%": 50,
                "secondaryFireCooldown%": 60,
			},
			"lucio":{
				"damageDealt%": 150,
                "ammoClipSize%": 300
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
                "ammoClipSize%": 30,
                "health%": 80
            },
			"mauga": {
                "ability1Cooldown%": 0,
                "passiveHealthRegen": false
            },
			"wreckingBall": {
                "enableRollOnly": true
            },
			"general": {
                "passiveHealthRegen": false,
				"healingDealt%": 10
            }
        },
        "allTeams": {
            # "mercy": {
            #     "ability2Cooldown%": 0
            # }
        }
    }
}

# #!translateWithPlayerVar
# this var is still used for the server side translation (nipman.__languageIndex__)
playervar __languageIndex__
globalvar nipman
#!define serverSideTranslate(x) x[nipman.__languageIndex__]

rule "want to contribute a translation? please visit https://github.com/yubber/mauga-nipple-series/, it's easier to make translations for the overpy source file.":
	@Delimiter

### TRANSLATORS' SECTION
# refer to README.MD for a guide.
# general pointers:
# - please only edit stuff inside quotation marks. if you add double quote " characters they must be escaped, like: \"
# - to avoid censors, you can use zero-width spaces "​". cyrillic characters also work for the latin script, but they will cause the font to change.

# ! add language code here, and the translation workshop uses for white. maintain the same order!
#!translations en ko
#!define LANG_LIST ["White", "흰색"]

# the mode name and description are in settings -> main, at the very top of this file.

# these are names for the dummy bots used in threats, e.g. overheating glands (torbjorn), slenderman
# since they're in bot names i can't use the translation features
# ! add translated names here, in the same format and following the order of the language codes
#!define BOTNAME_SLENDY serverSideTranslate(["slenderman", "슬렌더맨"])
#!define BOTNAME_TORBS serverSideTranslate(["overheating glands", "과열된 돌출부"])
#!define BOTNAME_SNIPERS serverSideTranslate(["s-nip-ers", "젖-격수"])
#!define BOTNAME_NIPLETS serverSideTranslate(["niplets", "젖먹이"])
#!define BOTNAME_ILLARIS serverSideTranslate(["sunkissed nips", "아침에젖스"])
#!define BOTNAME_TOEPPLES serverSideTranslate(["toepples", "발꼭지"])
#!define BOTNAME_DRAGONIPS serverSideTranslate(["dragoniррles", "용의 일겨헉♥"])
#!define BOTNAME_WEAK_SPOT serverSideTranslate(["sensitive spot", "약점♥"])
#!define BOTNAME_MAUGA_JR serverSideTranslate(["mauga jr.", "마우가 JR."])
#!define BOTNAME_MINIBOSS serverSideTranslate(["miniboss", "미니보스"])
# */
# these are descriptions for custom settings.
# gameplay category of settings
# /*
#!define SETTING_GAMEPLAY "gameplay | 게임플레이"
#!define SETTING_PLAYERSCALE "increase player damage per missing player | 없는 플레이어당 주는 대미지 증가"
#!define SETTING_DIFFICULTY "difficulty | 난이도"
#!define SETTING_HARDCORE "respawn players only when round ends | 라운드가 끝난 이후에만 리스폰"
# */
/*
#!define SETTING_GAMEPLAY "게임플레이"
#!define SETTING_PLAYERSCALE "없는 플레이어당 주는 대미지 증가"
#!define SETTING_DIFFICULTY "난이도"
#!define SETTING_HARDCORE "라운드가 끝난 이후에만 리스폰"
*/

### !!! END. the following strings are already translated in the .po file.
# thank you for translating!

# please preserve the order of these lists.
globalvar objDescs = [___("collect pages"), ___("defeat the mini maugas"), ___("slay enemies"), ___("slay the miniboss"), ___("capture the point")] # keep point as last
globalvar threatNames = [___("slenderman"), ___("more maugas"), ___("frosty nips"), /*"the third nipact",*/ ___("dragon stimulation"), ___("toepples"), ___("grabbyteats"), ___("niplets"), ___("cup fight"), ___("tiddy twister"), ___("lactic hail"), ___("n!pple nuke"), ___("dairy deaths"), ___("milk wall"), ___("mending milk"), ___("scalding discharge"), ___("s-nip-ers"), ___("boobsted mobs"), ___("booblet hell"), ___("gravitatas"), ___("sun exposure"), ___("lazer")]

# these are references to strings in other parts of the program. i've moved them here for your convenience.
# if you would like context for where these strings are used, you can CTRL+F the PART_AFTER_DEFINE.
#!define STR_OBJCOUNTDOWN t"next objective in 3 seconds!"
#!define STR_ROUNDSTART t"round start!"
#!define STR_MAUGAVULNERABLE t"objective complete! mauga is vulnerable!"
# leave the {} there. these are for warning icons.
#!define STR_MAUGASCHARGING t"{0} deadly attack incoming! attack the sensitive spots! {0}"
#!define STR_MAUGASFAILED t"{} failed to stop the attack. brace for impact!"
# here, {} is the player who found the page. this is for the slenderman objective.
#!define STR_PAGEFOUND t" {} found a page!"
#!define STR_ALLDEAD t"game over. all players died."
# this string is for players that try to hook/charge the mauga. write whatever's funniest in the target language.
#!define STR_CHIDING t"do not the mauga"
# if you are translating the petrified text, delete the next line and use the line after it instead. also get rid of the "# " at the start.
#!define STR_PETRIFIED t"{} petrified! {} {} {}".format(iconString(Icon.EYE), l"Avoid", l"Facing", Hero.SIGMA)
# #!define STR_PETRIFIED t"petrified! avoid facing sigma.".format(iconString(Icon.EYE))
# {} is mauga's icon
#!define STR_DRAGONTRIGGER t"{} heehee, stop tickling me! dragon lactation initation!"
#!define STR_PAGEGUNS t"remember to check inside mauga's guns for the pages."
#!define MESSAGE_GRABBED t"{} you were grabbed!"

#!define MESSAGE_MAUGA_GONE t"something went wrong. skipping phase..."
#!define MESSAGE_TIMEOUT t"timeout exceeded, skipping phase in case of softlock."

# total deaths in the team.
#!define HUD_TEAMDEATHS t"team deaths"
#!define HUD_ROUNDS t"rounds elapsed"
#!define HUD_TIME t"time elapsed"
#!define HUD_HC t"hardcore mode is on"
#!define HUD_HCDESC t"no respawning until round ends"
# \n is a newline, because text doesn't wrap automatically i think
#!define HUD_SPECTATORS __("spectators, please turn off team 1 & 2 heroes\nand game mode hud in spectator options\n(press b)")
# supposed to show the korean flag but no worky
#!define HUD_KR_MODE (t"\n{}TX 000000009D14> 한국어: K08WD".format(bracket))
#!define HUD_IMPORT_CODE t"use code DS2MD for the latest version"
#!define HUD_LOAD_1 t"peak: {} | average: {}"
#!define HUD_LOAD_2 t"server load: {}\n"

/*
TODO

known issues
- more maugas hp bar starts depleted (tank passive grrr)

broken perks
- zarya grav

right -0.16, 1.32, 0.56 | left 0.43, 1.31, 0.31
scaled at 0 -15 30: righ 4.46, 24.61, 21.40 | left -6.51, 24.36, 24.04
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
	# NIPACT,
	DRAGON,
	TOES,
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
#!define NipmanForcePosConst vect(0,-17-2.8,35)
#!define NipmanLeftConst vect(2.93, 10.84-2.8, 26.15)
#!define NipmanRightConst vect(-7.19, 10.8-2.8, 30.27)

globalvar bracket
#!define LeftNip (nipman.smallLNip)
#!define RightNip (nipman.smallRNip)
# globalvar LeftNip = vect(4.46, 21.7, 26.40) # phased out & floating values
# globalvar RightNip = vect(-6.51, 22.1, 29.04)
globalvar obj
globalvar objWeights = [0.08, 0.12, 0.3, 0.3, 0.20]
globalvar lastObj

globalvar objProg
globalvar objGoal
globalvar objPos # used for miniboss entity
globalvar roundNo
globalvar threatList = []
# threats that use dummy bots. more not included - hammond bots cancel out absence of mobs
globalvar dummyThreats = [THREATS.COOM, THREATS.SNIPER, THREATS.SUN, THREATS.FRACTAL, THREATS.DRAGON/*THREATS.TOES/*, THREATS.KITSUNIPS*/]
# threats that don't scale in more maugas. ie threats that cannot share global variables, affect mobs only or won't scale in fun ways
# globalvar moreBlacklist = [THREATS.BOOST, THREATS.DD, THREATS.CAGE, THREATS.GRAB, THREATS.GRAV, THREATS.WALL, THREATS.TWISTER, THREATS.RAIN, THREATS.NUKE]

# threats that have extra behavior in more maugas
globalvar moreFunThreats = [THREATS.ICE, THREATS.COOM, THREATS.DAKKA, /*THREATS.FRACTAL,*/ THREATS.HEAL, THREATS.SNIPER, THREATS.SUN]
# niplets can't be there because they block weak spots

# keep lazer as last and frosty as 1st after slender
globalvar threatIcons = [heroIcon(Hero.REAPER), abilityIconString(Hero.MAUGA, Button.ABILITY_1), abilityIconString(Hero.MEI, Button.ULTIMATE), abilityIconString(Hero.HANZO, Button.ULTIMATE), /*abilityIconString(Hero.JUNO, Button.ABILITY_1),*/ heroIcon(Hero.SIGMA), abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), abilityIconString(Hero.SIGMA, Button.ABILITY_1), abilityIconString(Hero.MAUGA, Button.ULTIMATE), abilityIconString(Hero.JUNKER_QUEEN, Button.ULTIMATE), abilityIconString(Hero.HAZARD, Button.ULTIMATE), iconString(Icon.RADIOACTIVE), abilityIconString(Hero.REAPER, Button.ULTIMATE), abilityIconString(Hero.MEI, Button.ABILITY_2), iconString(Icon.PLUS), abilityIconString(Hero.TORBJORN, Button.ULTIMATE), abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), abilityIconString(Hero.ANA, Button.ULTIMATE), abilityIconString(Hero.PHARAH, Button.ULTIMATE), abilityIconString(Hero.ZARYA, Button.ULTIMATE), abilityIconString(Hero.ILLARI, Button.ULTIMATE), abilityIconString(Hero.ECHO, Button.ABILITY_2)]
#kitsunip rush, milk wall, mini mauga, tanky mobs 1 kill, heal, dd, milk rain (moving pillar beams), spoiled milk titties (global/big chasing dot?), maven degen like (chases then explodes after delay), restrict to 1 square of arena

# globalvar threatText = ""
globalvar enemies = [Hero.WINSTON, Hero.TORBJORN, Hero.REINHARDT, Hero.MAUGA]
globalvar mobDmg = [90, 130, 75, 60]
# globalvar enemies = [Hero.MAUGA]
# globalvar mobDmg = [100]
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

globalvar iMores
globalvar moreFx
globalvar attackingClone
globalvar weakSpots = []

globalvar isun

globalvar threatSnipers
globalvar threatLactaters
globalvar threatSuns
globalvar threatNiplets
globalvar threatToes
globalvar threatDragons
# globalvar threatTwinks
globalvar mobs = []
# persistent effects only (not destroyed until round end)
globalvar threatFx
globalvar antiCrashOn

globalvar isHardcore = createWorkshopSettingBool(SETTING_DIFFICULTY, SETTING_HARDCORE, false, 0)

playervar mobTarget # also used for sniper target, milk wall victims (nipman.mobTarget)
playervar cacheA
playervar cacheB
playervar cacheC
playervar botA
playervar botB

#!define chainSetup (nipman.cacheC)

# feetpples
#!define feetSlow cacheA

# dragons' vars
#!define tickleCounter cacheA
#!define iDragon cacheA

# big and small maugas' nip pos. world vect
#!define smallLNip cacheA
#!define smallRNip cacheB
#!define hpBar cacheC

# event player.
#!define nipletsPosList botA.cacheA
playervar iniplets

# choose 1 clone
#!define cycledClone objPos[getTotalTimeElapsed() % len(objPos)]

#!define MiniScale 15

rule "guide to adding threats":
	@Delimiter
	@Condition false
	# too long to show on workshop. please find the overpy source in github from workshop.codes/DS2MD
	null.respawn()

rule "hey... wanna play some secret gamemodes?":
	@Delimiter
	@Condition false
	# inflation gamemode (pvp or add bots): 9YX9G
	null.respawn()
	# [!] the following games are extremely vulgаr and sехuаl. may be upsetting to viewers. [!]
	# kiriko рrоstate exam sim: 032QT
	null.respawn()
	# the below mode also features extreme fеtish content, sеxually aggressive behavior and a mention of pеdophiliа. viewer discretion advised.
	# overwatch dating sim: 7GRX3
	null.respawn()

rule "init":
	# set up TX bracket

    #Script Created By Zezombye.
    #More Info: https://workshop.codes/wiki/articles/tx-reference-sheet
    createDummy(getAllHeroes(), Team.1 if getNumberOfSlots(Team.1) else Team.2 if getNumberOfSlots(Team.2) else true, false, null, null)
    getLastCreatedEntity().startForcingName("\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z〼")
    bracket = getLastCreatedEntity()[0].split([])
    getLastCreatedEntity().startForcingName("\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\zࡀ")
    bracket = "\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z\z〼".replace(bracket, getLastCreatedEntity()[0]).substring(63, true)
    destroyAllDummies()

	wait()
	# print(len(getPlayers(Team.2)))
	# hudText(hostPlayer, iconString(Icon.EYE), "eye position", localPlayer.getEyePosition(), HudPosition.LEFT, 0, Color.SKY_BLUE, Color.SKY_BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), null,  "peak: {} | average: {}".format(getPeakServerLoad(), getAverageServerLoad()), HUD_LOAD_2.format(getServerLoad()), HudPosition.RIGHT, -2, Color.ORANGE, Color.GRAY, Color.GRAY, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), t"use code DS2MD for the latest version", HudPosition.RIGHT, -1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	disableInspector()

	obj = OBJ.INTERMISSION
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	nipman = getLastCreatedEntity()
	nipman.startForcingPosition(NipmanForcePosConst, false)
	nipman.startFacing(Vector.BACKWARD, 999, Relativity.TO_WORLD, FacingReeval.NONE)
	nipman.disablePlayerCollision()
	nipman.disableEnvironmentCollision(true)
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

	nipman.smallLNip = NipmanLeftConst
	nipman.smallRNip = NipmanRightConst

	# score huds
	hudText(getAllPlayers(), abilityIconString(Hero.LUCIO, Button.ABILITY_2), HUD_TIME, "{}:{}".format(floor(getTotalTimeElapsed() / 60), getTotalTimeElapsed() % 60), HudPosition.LEFT, 1, Color.SKY_BLUE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(), iconString(Icon.SKULL), HUD_TEAMDEATHS, teamScore(Team.2), HudPosition.LEFT, 2, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers(), iconString(Icon.FLAG), HUD_ROUNDS, roundNo, HudPosition.LEFT, 2, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	# hudText(getAllPlayers(), abilityIconString(Hero.CASSIDY, Button.ULTIMATE), "total kills", kills, HudPosition.LEFT, 2, Color.ROSE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	hudText(getAllPlayers() if isHardcore else null, iconString(Icon.EXCLAMATION_MARK), HUD_HC, HUD_HCDESC, HudPosition.LEFT, 3, Color.BLACK, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
	createEffect(getAllPlayers() if obj != OBJ.INTERMISSION else [], Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED, Color.TEAM_2, nipman, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# createEffect([] if obj != OBJ.INTERMISSION else getAllPlayers(), Effect., Color.TEAM_1, nipman, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

	hudSubtext(null if (localPlayer in getPlayers(Team.1)) else getAllPlayers(), HUD_SPECTATORS, HudPosition.LEFT, 9, Color.GRAY, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
	# hudSubtext(getAllPlayers() if obj == OBJ.INTERMISSION else null, HUD_KR_MODE, HudPosition.LEFT, 10, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)


	# createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, LeftNip, 1, EffectReeval.VISIBILITY)
	# createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, RightNip, 1, EffectReeval.VISIBILITY)

	# objective effects
	createEffect(getAllPlayers() if obj == OBJ.PAGES else [], Effect.BAD_AURA, Color.GRAY, Vector.UP, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	for i in range(6):
		createEffect(getAllPlayers() if obj == OBJ.PAGES else [], Effect.CLOUD, Color.GRAY, Vector.UP * i * 0.1 - 0.7, 50, EffectReeval.VISIBILITY)
		wait()
	createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, objPos if obj == OBJ.PAGES else Vector.DOWN, 0.7, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createEffect(getAllPlayers(), Effect.RING, Color.BLUE, objPos if obj == OBJ.CAPTURE else Vector.DOWN * getTotalTimeElapsed(), 12, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	createIcon(getAllPlayers() if obj == OBJ.CAPTURE else [], objPos, Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.TEAM_1, true)

	# threat fx
	# createProjectileEffect(getAllPlayers() if THREATS.ICE in threatList else [], Projectile.MEI_ICICLE, null, LeftNip + Vector.FORWARD * 5.8, Vector.BACKWARD, 0.5, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.ICE in threatList else [], Projectile.MEI_ICICLE, null, RightNip + Vector.FORWARD * 5.8, Vector.BACKWARD, 0.5, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.GRAV in threatList else [], Projectile.ZARYA_GRAVITON, null, LeftNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.GRAV in threatList else [], Projectile.ZARYA_GRAVITON, null, RightNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, LeftNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, RightNip, Vector.BACKWARD, 0.02, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.HEAL in threatList else [], Projectile.MOIRA_HEAL_ORB, null, LeftNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)
	# createProjectileEffect(getAllPlayers() if THREATS.HEAL in threatList else [], Projectile.MOIRA_HEAL_ORB, null, RightNip, Vector.BACKWARD, 0, ProjectileEffectReeval.VISIBILITY)

	wait(0.16)
	# objective huds. get max hp is fucking broken for mauga. and tank passive bonus doesn't even let him heal to there
	progressBarHud(getAllPlayers() if obj == OBJ.INTERMISSION else [], 100 * nipman.getHealth() / 57500, "{} {} / {} hp".format(heroIcon(Hero.MAUGA), ceil(nipman.getHealth()), 57500), HudPosition.TOP, 1, Color.TEAM_2, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
	progressBarHud(getAllPlayers() if obj != OBJ.INTERMISSION else [], objProg / objGoal * 100, "{}: {}! {} / {}".format(t"objective", _(objDescs[obj]), objProg, objGoal), HudPosition.TOP, 1, Color.TEAM_2 if obj == OBJ.BOSS else Color.TEAM_1, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    # hudText(getAllPlayers() if obj != OBJ.INTERMISSION else [], "\&fullwidth_space;{}: {}\&fullwidth_space;".format(l"Threats", threatText), "", " \n ", HudPosition.TOP, 0, Color.ORANGE, Color.GRAY, Color.GRAY, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers() if obj != OBJ.INTERMISSION else [], "\&fullwidth_space;{}: {}{}{}{}{}{}{}{}\&fullwidth_space;".format(t"threats",
		f"{threatIcons[threatList[0]]} ",
		_(threatNames[threatList[0]]),
		", " if len(threatList) > 1 else "",
		f"{threatIcons[threatList[1]]} " if len(threatList) > 1 else "",
		_(threatNames[threatList[1]]) if len(threatList) > 1 else "",
		", " if len(threatList) > 2 else "",
		f"{threatIcons[threatList[2]]} " if len(threatList) > 2 else "",
		_(threatNames[threatList[2]]) if len(threatList) > 2 else ""
	), "", " \n ", HudPosition.TOP, 0, Color.ORANGE, Color.GRAY, Color.GRAY, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)

	nipman.smallLNip = NipmanLeftConst
	nipman.smallRNip= NipmanRightConst

	nipman.__languageIndex__ = LANG_LIST.index("{}".format(Color.WHITE))

	setMatchTime(5)

rule "loop":
	# start game when any player spawns for the first time
	@Condition any([x.hasSpawned() for x in getPlayers(Team.1)])
	# intermission
	destroyEffect(threatFx)
	destroyEffect(moreFx)
	destroyProgressBarInWorldText(threatFx)
	# destroyEffect(nipman.threatDecor)
	threatFx = []
	threatLactaters = []
	threatSuns = []
	threatSnipers = []
	threatToes = []
	threatNiplets = []
	threatDragons = []
	# nipman.threatDecor = []
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
	lastObj = obj
	obj = OBJ.INTERMISSION
	objProg = 0
	threatList = []
	setMatchTime(11)
	unpauseMatchTime()
	wait(8)
	bigMessage(getAllPlayers(), STR_OBJCOUNTDOWN)
	wait(2.5)
	pauseMatchTime()
	wait(0.5)
	mobs = []

	# pick objective. using objgoal instead of obj because rules check the obj var
	objPos = Vector.DOWN * nipman.getMaxHealth()

	objGoal = lastObj

	while lastObj == objGoal: # prevent 2 same obj in a row
		objGoal = random.uniform(0, 1) # sum(weights) must be 1. obj is r here
		upto = 0
		for i in range(len(objWeights)): # weighted rand from stackoverflow
			if upto + objWeights[i] >= objGoal:
				objGoal = i
				break
			upto += objWeights[i]
			wait()

	# objGoal = OBJ.BOSS

	threatList = []
	if objGoal == OBJ.PAGES:
		threatList.append(THREATS.SLENDY)
	elif objGoal == OBJ.MORE:
		threatList.append(THREATS.MORE)

	threatList.append(random.randint(THREATS.ICE, THREATS.LASER))
	# threatList.append(THREATS.DRAGON)

	wait(0.36)
	if objGoal != OBJ.PAGES: # attempt to add a 2nd threat
		# lastObj is used as temp storage
		# guarantee a threat that will get copied by mauga clones
		if objGoal == OBJ.MORE and ((threatList.last() in moreFunThreats) == false):
			lastObj = random.choice(moreFunThreats)
		else:
			lastObj = random.randint(THREATS.ICE, THREATS.LASER)
		if not lastObj in threatList:
			threatList.append(lastObj)
	# prevent multiple dummy-using threats to be used, to prevent conflicts on botA and botB vars or exceeding skin limit.
	if len([x for x in threatList if x in dummyThreats]) >= 2:
		threatList = threatList.slice(0,len(threatList) - 1)

	wait()

	roundNo++

	wait()
	getDeadPlayers(Team.1).respawn()
	bigMessage(getAllPlayers(), STR_ROUNDSTART)

	nipman.forceButtonPress(Button.ABILITY_2)
	wait(0.48)

	obj = objGoal
	objGoal = [8, 3, 60, 1, 100][obj]

	nipman.setDamageReceived(0.001) # i forgot why this can't be 0. surely nothing bad happens :clueless:
	# i rember now. it's to detect hook, punch, etc. now also for dragonipples
	nipman.setStatusEffect(null, Status.FROZEN, 99999)

	waitUntil(objProg >= objGoal, 10*60) # timeout
	if objProg < objGoal:
		bigMessage(getAllPlayers(), MESSAGE_TIMEOUT)

	# nipman.setStatusEffect(null, Status.STUNNED, 0.5)
	playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_EFFECT, Color.TEAM_1, Vector.FORWARD * 18, 100)
	playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.TEAM_1, localPlayer, 200)
	bigMessage(getAllPlayers(), STR_MAUGAVULNERABLE)
	wait()
	getDeadPlayers(Team.1).respawn()

	goto RULE_START

# mobs
def mobsInit():
	mobs = []
	for i in range(MaxBots-4):
		# createDummy(enemies[i%len(enemies)], Team.2, -1, Vector.DOWN, Vector.BACKWARD)
		# can't split enemy heroes bc skin limit
		# do not put this above skybox in case enemies aren't killed
		createDummy(enemies[roundNo%len(enemies)], Team.2, -1, 40 * Vector.UP, Vector.BACKWARD)
		mobs.append(getLastCreatedEntity())
		wait(0.124)
		# mobs.last().startFacing(directionTowards(mobs[evalOnce(i)].getEyePosition(), mobs[evalOnce(i)].mobTarget), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
		if THREATS.BOOST in threatList:
			createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED, Color.TEAM_2, mobs[evalOnce(i)], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
			threatFx.append(getLastCreatedEntity())
		# debug
		# createInWorldText(getAllPlayers(), mobs[evalOnce(i)].mobTarget, mobs[evalOnce(i)], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)

	wait(0.48)
	getPlayersOnHero(Hero.TORBJORN, Team.2).setWeapon(2)
	mobs.stopForcingButton(Button.PRIMARY_FIRE)
	# if enemies[roundNo%len(enemies)] != Hero.MAUGA:
	mobs.startForcingThrottle(1,1,0,0,0,1)
	mobs.setDamageDealt(mobDmg[roundNo%len(mobDmg)])
	mobs.setMoveSpeed(70)
	wait()
	if enemies[roundNo%len(enemies)] == Hero.TORBJORN:
		mobs.setDamageReceived(85)
	elif enemies[roundNo%len(enemies)] == Hero.MAUGA:
		mobs.setMaxHealth(55)
		mobs.setMoveSpeed(40)
		mobs.setKnockbackDealt(40)
		mobs.setDamageReceived(130)
	else:
		mobs.setDamageReceived(100)

	# kill(mobs, null)
	# mobs.resurrect()
	# if obj == OBJ.KILL:
	# 	objProg -= len(mobs)

	if THREATS.BOOST in threatList:
		startDamageModification(getPlayers(Team.1), mobs, 130, DamageReeval.RECEIVERS_AND_DAMAGERS)

rule "summon the horde":
	@Condition obj != OBJ.INTERMISSION
	@Condition obj != OBJ.PAGES
	@Condition obj != OBJ.MORE
	wait(0.64, Wait.ABORT_WHEN_FALSE)
	getAllPlayers().disableKillFeed()
	wait()
	# destroyAllInWorldTexts() # debug
	mobsInit()
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

	wait(0.4)
	mobs.startForcingThrottle(1,1,0,0,0,1)
	mobs.setDamageDealt(500 * 1.3 if THREATS.BOOST in threatList else 500)
	mobs.setMoveSpeed(99)
	mobs.startScalingSize(2, false)
	mobs.setMaxHealth(1200)
	getAllPlayers().disableKillFeed()
	kill(mobs, null)
	wait()
	getAllPlayers().enableKillFeed()
	objPos = Vector.FORWARD # set first page pos for clueless players
	mobs.resurrect()
	mobs.startModifyingVoicelinePitch(0.6, false)
	mobs.startForcingName(BOTNAME_SLENDY)
	wait(0.4)
	heal(mobs,null,99999)
	while obj == OBJ.PAGES:
		mobs.forceButtonPress(Button.MELEE)
		wait(1.2)
		if random.uniform(0,1) < 0.03:
			smallMessage(getAllPlayers(), STR_PAGEGUNS)

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
	if obj != OBJ.PAGES and eventPlayer.getHero() != Hero.MAUGA:
		eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
	eventPlayer.communicate(Comms.HELLO)
	# wait(0.24)
rule "mob retarget":
	@Event global
	@Condition mobs != []
	@Condition obj != OBJ.INTERMISSION
	if getNumberOfLivingPlayers(Team.1) == 0:
		# mobs.mobTarget = null
		if enemies[roundNo%len(enemies)] == Hero.MAUGA:
			mobs.cancelPrimaryAction()
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
			if mobs[i].isAlive():
				mobs[i].mobTarget = getRealClosestPlayers(mobs[i].getPosition(), Team.1)[random.randint(0,2) % getNumberOfLivingPlayers(Team.1)]
		# change boss target
		if obj == OBJ.BOSS:
			objPos.mobTarget = mobs[0].mobTarget
			# objPos.mobTarget = getRealClosestPlayer(objPos, Team.1)
	wait(1.6)
	if ruleCondition:
		loop()

rule "mauga mob behavior":
	@Event eachPlayer
	@Hero mauga
	@Condition eventPlayer.hasSpawned()
	wait(0.48)
	if eventPlayer in mobs or (obj == OBJ.BOSS and eventPlayer == objPos):
		while true:
			wait(0.64)
			# do not charge if already charging, not played landing stun yet or target invalid
			if (eventPlayer.isUsingAbility1() == false) and (eventPlayer.isOnGround() or eventPlayer.getNormalizedHealth() < 1) and eventPlayer.mobTarget.isAlive() and entityExists(eventPlayer.mobTarget):
				eventPlayer.forceButtonPress(Button.ABILITY_1)
# threats
rule "dragon change target":
	@Event eachPlayer
	@Hero hanzo
	@Team 2
	while obj != OBJ.INTERMISSION:
		wait(2)
		eventPlayer.mobTarget = random.choice(getLivingPlayers(Team.1))

rule "dragon init": # 9/11 with more maugas but it's ok ig
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.DRAGON in threatList
	@Condition (eventPlayer.smallLNip == nipman.smallLNip) or (obj == OBJ.MORE and eventPlayer in objPos)
	createDummy(Hero.HANZO, Team.2, -1, Vector.UP, eventPlayer.getFacingDirection())
	eventPlayer.botA = getLastCreatedEntity()
	eventPlayer.botA.startFacing(directionTowards(eventPlayer.botA.getEyePosition(), eventPlayer.botA.mobTarget.getEyePosition()), 7, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	threatDragons.append(eventPlayer.botA)
	threatFx.append(getLastCreatedEntity())
	createDummy(Hero.HANZO, Team.2, -1, Vector.UP, Vector.BACKWARD)
	eventPlayer.botB = getLastCreatedEntity()
	eventPlayer.botB.startFacing(directionTowards(eventPlayer.botB.getEyePosition(), eventPlayer.botB.mobTarget.getEyePosition()), 7, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	threatDragons.append(eventPlayer.botB)
	threatFx.append(getLastCreatedEntity())

	threatDragons.disableNameplatesFor(getAllPlayers())
	threatDragons.startForcingName(BOTNAME_DRAGONIPS)
	threatDragons.setStatusEffect(null, Status.PHASED_OUT, 9999)
	threatDragons.startScalingSize(0.1, false)

	threatDragons.setDamageDealt(55 if obj == OBJ.MORE else 120)

	wait(0.48)
	eventPlayer.botB.startForcingPosition(eventPlayer.smallRNip + eventPlayer.getFacingDirection() * -6, false)
	eventPlayer.botA.startForcingPosition(eventPlayer.smallLNip + eventPlayer.getFacingDirection() * -6, false)
	threatDragons.startModifyingVoicelinePitch(1 + 0.5 * sin(getTotalTimeElapsed()*4), true)

rule "dragon stimulation":
	@Event playerTookDamage
	@Hero mauga
	@Team 2
	@Condition obj != OBJ.INTERMISSION
	# @Condition THREATS.DRAGON in threatList
	@Condition (victim == nipman) or (obj == OBJ.MORE and eventPlayer in objPos)
	@Condition victim != attackingClone

	waitUntil(len(threatList) > 0, 5)

	if THREATS.DRAGON in threatList == false: # don't check again
		waitUntil(obj == OBJ.INTERMISSION, 99999)
		return

	if victim.botA.tickleCounter >= 24:
		smallMessage(getAllPlayers(), STR_DRAGONTRIGGER.format(heroIcon(Hero.MAUGA)))
		playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.TEAM_2, victim.smallLNip, 200)
		playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, victim.smallLNip, true)
		playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, victim.smallRNip, true)
		victim.botA.setFacing(victim.botA.mobTarget, Relativity.TO_WORLD)
		victim.botB.setFacing(victim.botB.mobTarget, Relativity.TO_WORLD)
		for victim.botB.iDragon in range(3):
			threatDragons.setUltCharge(100)
			wait(1.12)
			victim.botA.forceButtonPress(Button.ULTIMATE)
			victim.botB.forceButtonPress(Button.ULTIMATE)
			if obj == OBJ.MORE:
				break
			# threatDragons[0].setFacing(directionTowards(LeftNip, random.choice(getLivingPlayers(Team.1))), Relativity.TO_WORLD)
			# threatDragons.last().setFacing(directionTowards(LeftNip, random.choice(getLivingPlayers(Team.1))), Relativity.TO_WORLD)
		victim.botA.tickleCounter = 0
	else:
		victim.botA.tickleCounter += 1
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, eventPlayer.smallLNip + Vector.BACKWARD * 1.1, true)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, eventPlayer.smallRNip + Vector.BACKWARD * 1.1, true)
		wait(0.096)

/*rule "nipvangelion":
	@Event eachPlayer
	@Hero mauga
	@Team 2
	@Condition eventPlayer == nipman
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.NIPACT in threatList
	createBeam(getAllPlayers(), Beam.MERCY_HEAL, LeftNip, LeftNip + vect(0,10,-4), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MERCY_HEAL, LeftNip + vect(0,8,-3.2), LeftNip + vect(1,8,-3.2), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MERCY_HEAL, LeftNip + vect(0,8,-3.2), LeftNip + vect(-1,8,-3.2), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

	createBeam(getAllPlayers(), Beam.MERCY_HEAL, RightNip, RightNip + vect(0,10,-4), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MERCY_HEAL, RightNip + vect(0,8,-3.2), RightNip + vect(1,8,-3.2), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createBeam(getAllPlayers(), Beam.MERCY_HEAL, RightNip + vect(0,8,-3.2), RightNip + vect(-1,8,-3.2), Color.TEAM_2, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())*/

rule "TOES":
	@Event global
	# @Event eachPlayer
	# @Hero mauga
	# @Team 2
	# @Condition eventPlayer == nipman
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.TOES in threatList
	wait(1.2, Wait.ABORT_WHEN_FALSE)
	createDummy(Hero.SIGMA, Team.2, -1, Vector.UP * 999, nipman.getFacingDirection())
	threatToes.append(getLastCreatedEntity())
	threatToes.startScalingSize(147/12)
	# threatToes.setStatusEffect(null, Status.PHASED_OUT, 99999)
	wait(0.24)

	createBeam(localPlayer if localPlayer.feetSlow != 0 and localPlayer.isAlive() else null, Beam.GOOD, LeftNip, localPlayer.getEyePosition() + Vector.DOWN, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createBeam(localPlayer if localPlayer.feetSlow != 0 and localPlayer.isAlive() else null, Beam.GOOD, RightNip, localPlayer.getEyePosition() + Vector.DOWN, Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	threatToes.setDamageReceived(0)

	createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED, Color.TEAM_2, threatToes[0], true, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

	threatToes.startForcingName(BOTNAME_TOEPPLES)

	while threatToes[0].hasStatus(Status.KNOCKED_DOWN) == false:
		threatToes.startForcingPosition(worldVector(vect(0.017, 0.186, -0.037)*147, nipman, Transform.ROTATION_AND_TRANSLATION), true)
		wait(0.48)
		threatToes.setStatusEffect(null, Status.KNOCKED_DOWN, 99999)

rule "toe medusa":
	@Event eachPlayer
	@Team 1
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.TOES in threatList
	@Condition eventPlayer.isDummy() == false
	eventPlayer.feetSlow = 0

	wait(0.08 * eventPlayer.getSlot())

	while obj != OBJ.INTERMISSION:
		wait(0.192)
		if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), threatToes[0])) < 40:
			eventPlayer.feetSlow += 0.05
			eventPlayer.setMoveSpeed(100 - eventPlayer.feetSlow * 100)
			damage(eventPlayer, threatToes[0], 2.5)
			if eventPlayer.feetSlow >= 1:
				smallMessage(eventPlayer, STR_PETRIFIED)
				eventPlayer.feetSlow = 1
				eventPlayer.setStatusEffect(threatToes[0], Status.FROZEN, 1.2)
				damage(eventPlayer, threatToes[0], 80)
				wait(1)
				eventPlayer.feetSlow = 0
				eventPlayer.setMoveSpeed(100)
				wait(0.48)
		else:
			eventPlayer.feetSlow = 0
			eventPlayer.setMoveSpeed(100)

	eventPlayer.feetSlow = 0
	eventPlayer.setMoveSpeed(100)



rule "init weak spots": # ALL hammond dummies are weak spots
	@Event eachPlayer
	@Hero wreckingBall
	@Condition eventPlayer.isDummy()
	eventPlayer.startScalingSize(0.8, false)
	eventPlayer.startForcingName(BOTNAME_WEAK_SPOT)
	createIcon(getAllPlayers(), eventPlayer, Icon.WARNING, IconReeval.VISIBILITY_AND_COLOR, rgb(255, 205 + 50 * (sin(getTotalTimeElapsed() * 4)) / 2, 0), true)
	weakSpots.append(eventPlayer)
	wait(0.16)
	createEffect(getAllPlayers(), Effect.ECHO_CLONING, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY)
	eventPlayer.communicate(Comms.HELLO)

rule "more maugas charge attack":
	@Condition obj == OBJ.MORE
	wait(2.4)
	while obj == OBJ.MORE:
		wait(8)
		moreFx = []

		if obj != OBJ.MORE:
			return

		attackingClone = random.choice(objPos)
		for iMores in range(len(weakSpots)):
			destroyDummy(Team.2, weakSpots[iMores].getSlot())
		weakSpots = []

		# createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallLNip, LeftNip if attackingClone.smallLNip.x > 0 else RightNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallLNip, LeftNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		moreFx.append(getLastCreatedEntity())
		# createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallRNip, LeftNip if attackingClone.smallRNip.x > 0 else RightNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		createBeam(getAllPlayers(), Beam.WINSTON_TESLA_CANNON, attackingClone.smallRNip, RightNip, Color.TEAM_2, EffectReeval.VISIBILITY)
		moreFx.append(getLastCreatedEntity())

		bigMessage(getAllPlayers(), (STR_MAUGASCHARGING).format(iconString(Icon.WARNING)))

		random.choice([x for x in getLivingPlayers(Team.1) if x.hasSpawned()]).communicate(Comms.PRESS_THE_ATTACK)

		# all hammond dummies get weak spot init
		createDummy(Hero.WRECKING_BALL, Team.2, -1, Vector.UP, Vector.UP)
		getLastCreatedEntity().attachTo(attackingClone, vect(0.360, 1.34, 0.38)*MiniScale) # left
		wait()
		createDummy(Hero.WRECKING_BALL, Team.2, -1, Vector.UP, Vector.UP)
		getLastCreatedEntity().attachTo(attackingClone, vect(-0.137, 1.34, 0.486)*MiniScale)
		weakSpots.setHealth(300)
		weakSpots.setHealingReceived(0)
		wait(0.064)
		heal(weakSpots, null, 99999)

		for iMores in range(15): # wait until with less checking
			wait(0.96)
			if obj != OBJ.MORE:
				return
			if attackingClone.isDead() or (weakSpots == []) or (entityExists(attackingClone) == false):
				break
			attackingClone.setStatusEffect(null, Status.BURNING, 1)

		# decide on logic

		if obj != OBJ.MORE:
			return
		if attackingClone.isDead() or (entityExists(attackingClone) == false) or (weakSpots == []):
			attackingClone.clearStatusEffect(Status.FROZEN)
			wait(0.112)
			attackingClone.setStatusEffect(null, Status.STUNNED, 1)
			destroyEffect(moreFx)
			moreFx = []
			random.choice([x for x in getLivingPlayers(Team.1) if x.hasSpawned()]).communicate(Comms.YES)
			bigMessage(getAllPlayers(), "success! stopped the attack!")
			wait(1.2)
			attackingClone.setStatusEffect(null, Status.FROZEN, 99999)
			attackingClone = null
			continue

		bigMessage(getAllPlayers(), STR_MAUGASFAILED.format(iconString(Icon.SAD)))

		for iMores in range(len(weakSpots)):
			destroyDummy(Team.2, weakSpots[iMores].getSlot())
		weakSpots = []

		random.choice([x for x in getLivingPlayers(Team.1) if x.hasSpawned()]).communicate(Comms.COUNTDOWN)
		for iMores in range(3):
			playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.TEAM_2, localPlayer if entityExists(localPlayer) else nipman.getEyePosition(), 99)
			playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, LeftNip, 99)
			playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE, Color.TEAM_2, RightNip, 99)
			wait(1)
		random.choice([x for x in getLivingPlayers(Team.1) if x.hasSpawned()]).communicate(Comms.INCOMING)
		wait(1)

		if obj != OBJ.MORE:
			return

		createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, LeftNip, vect(10, 0, 20 - 22 * (getTotalTimeElapsed() - evalOnce(getTotalTimeElapsed()))), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		moreFx.append(getLastCreatedEntity())
		createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, RightNip, vect(-10, 0, 20 - 22 * (getTotalTimeElapsed() - evalOnce(getTotalTimeElapsed()))), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		moreFx.append(getLastCreatedEntity())

		for iMores in range(15, -17, -5):
			playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, vect(10,0,iMores), 10)
			playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, vect(-10,0,iMores), 10)
			createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, attackingClone, vect(-10,1,iMores), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 280, 1, 10, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 99, 1, 20, 0,0)
			createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, attackingClone, vect(10,1,iMores), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 280, 1, 10, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 0, 99, 1, 20, 0,0)
			wait(0.016*21)
			if obj == OBJ.INTERMISSION:
				break

		destroyEffect(moreFx)
		moreFx = []
		nipman.communicate(Comms.GOODBYE)

rule "niplets + dupe":
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.FRACTAL in threatList
	@Condition (eventPlayer == nipman) # or (eventPlayer in objPos and obj == OBJ.MORE)

	createDummy(Hero.MAUGA, Team.2, -1, Vector.DOWN, eventPlayer.getFacingDirection())
	eventPlayer.botA = getLastCreatedEntity()
	threatNiplets.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, Vector.DOWN, eventPlayer.getFacingDirection())
	eventPlayer.botB = getLastCreatedEntity()
	threatNiplets.append(getLastCreatedEntity())

	wait(THREATS.FRACTAL * 0.032)

	# threatNiplets.setStatusEffect(null, Status.FROZEN, 99999)
	threatNiplets.setStatusEffect(null, Status.PHASED_OUT, 99999)

	eventPlayer.botA.startForcingPosition(eventPlayer.smallLNip + vect(-0.5,-3.5, -1),false)
	eventPlayer.botB.startForcingPosition(eventPlayer.smallRNip + vect(0.5,-3.5, -1),false)
	threatNiplets.startScalingSize(2, false)

	wait(0.24)

	# if len(eventPlayer.nipletsPosList) <= 0:
	# 	eventPlayer.nipletsPosList = []
	# 	wait()
	# 	eventPlayer.nipletsPosList.append(worldVector(vect(0.360, 1.371, 0.266)*2, eventPlayer.botA, Transform.ROTATION_AND_TRANSLATION))
	# 	eventPlayer.nipletsPosList.append(worldVector(vect(0.360, 1.371, 0.266)*2, eventPlayer.botB, Transform.ROTATION_AND_TRANSLATION))
	# 	eventPlayer.nipletsPosList.append(worldVector(vect(-0.137, 1.378, 0.466)*2, eventPlayer.botA, Transform.ROTATION_AND_TRANSLATION))
	# 	eventPlayer.nipletsPosList.append(worldVector(vect(-0.137, 1.378, 0.466)*2, eventPlayer.botB, Transform.ROTATION_AND_TRANSLATION))

	wait(0.48)

	createEffect(getAllPlayers(), Effect.LUCIO_SOUND_BARRIER_PROTECTED, Color.TEAM_2, eventPlayer.botA, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers(), Effect.LUCIO_SOUND_BARRIER_PROTECTED, Color.TEAM_2, eventPlayer.botB, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	threatNiplets.startForcingName(BOTNAME_NIPLETS)
	threatNiplets.disableNameplatesFor(getAllPlayers())

	# eventPlayer.iniplets = 0
	while obj != OBJ.INTERMISSION:
		wait(0.24)
		# eventPlayer.iniplets = (eventPlayer.iniplets + 1) % len(eventPlayer.nipletsPosList)
		# createProjectile(Projectile.BASTION_TACTICAL_GRENADE, eventPlayer.botA, eventPlayer.nipletsPosList[eventPlayer.iniplets], vect(random.uniform(0,0.7),random.uniform(-0.5,1),1), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 80, 1, 1, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0, 20, 3, 0, 35, 30)
		createProjectile(Projectile.BASTION_TACTICAL_GRENADE, eventPlayer.botA, Vector.UP, vect(random.uniform(-0.9,0.9),random.uniform(1,2),1), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 80, 1, 1, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.1, 24, 6, 0, 15, 110)
		wait(0.24)
		createProjectile(Projectile.BASTION_TACTICAL_GRENADE, eventPlayer.botB, Vector.UP, vect(random.uniform(-0.9,0.9),random.uniform(1,2),1), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 80, 1, 1, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.1, 24, 6, 0, 15, 110)

rule "grab":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.GRAB in threatList
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

	while obj != OBJ.INTERMISSION:
		grabLeft = LeftNip
		grabRight = RightNip
		# select
		grabLeftPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x > 0])
		grabRightPlayer = random.choice([x for x in getLivingPlayers(Team.1) if x.getPosition().x < 0])

		# attack
		if entityExists(grabLeftPlayer):
			grabLeftPlayer = grabLeftPlayer.getPosition() + Vector.UP * 0.5
			chaseOverTime(grabLeft, grabLeftPlayer, 2.4, ChaseTimeReeval.NONE)
		if entityExists(grabRightPlayer) and grabLeftPlayer != grabRightPlayer:
			grabRightPlayer = grabRightPlayer.getPosition() + Vector.UP * 0.5
			chaseOverTime(grabRight, grabRightPlayer, 2.4, ChaseTimeReeval.NONE)

		wait(2.4)

		stopChasingVariable(grabLeft)
		stopChasingVariable(grabRight)

		if obj == OBJ.INTERMISSION:
			return

		# check landing
		grabLeftPlayer = getRealPlayersInRadius(grabLeft, 2, Team.1)
		grabLeftPlayer.startForcingPosition(grabLeft,true)
		smallMessage(grabLeftPlayer, MESSAGE_GRABBED.format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, grabLeft, 20)
		playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_2, grabLeft, 20)

		grabRightPlayer = getRealPlayersInRadius(grabRight, 2, Team.1)
		grabRightPlayer.startForcingPosition(grabRight,true)
		smallMessage(grabRightPlayer, MESSAGE_GRABBED.format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
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

#!define CageMinZ 0
rule "cage":
	@Event eachPlayer
	@Team 1
	@Condition obj != OBJ.INTERMISSION
	@Condition eventPlayer.isDummy() == false
	@Condition eventPlayer.hasSpawned()
	@Condition THREATS.CAGE in threatList
	# for nipman.chainSetup in range(9):
	# 	createBeam(getAllPlayers() if entityExists(getPlayersInSlot(evalOnce(i),Team.1)) else null, Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if i % 2 == 0 else RightNip), getPlayersInSlot(evalOnce(i)), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# 	threatFx.append(getLastCreatedEntity())
	# 	wait()

	wait(THREATS.CAGE * 0.032)

	createBeam(getAllPlayers(), Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if eventPlayer.getSlot() % 2 == 0 else RightNip), eventPlayer, Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	wait(eventPlayer.getSlot() * 0.016)

	while obj != OBJ.INTERMISSION:
		if eventPlayer.getPosition().z < CageMinZ and (eventPlayer.isCrouching() == false):
			eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition(), LeftNip if (eventPlayer.getSlot() % 2 == 0) else RightNip), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
		wait(0.36)

rule "cage boundary":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.CAGE in threatList

	# for chainSetup in range(9):
	# 	createBeam(getAllPlayers() if entityExists(getPlayersInSlot(evalOnce(chainSetup),Team.1)) else null, Beam.JUNKRAT_TRAP_CHAIN, evalOnce(LeftNip if chainSetup % 2 == 0 else RightNip), getPlayersInSlot(evalOnce(i)), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	# 	threatFx.append(getLastCreatedEntity())
	# 	wait()

	createBeam(getAllPlayers(), Beam.BAD, vect(-20,0.1,CageMinZ), vect(20,0.1,CageMinZ), Color.ROSE, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

rule "milk wall + collision":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.WALL in threatList
	wait(THREATS.WALL * 0.032)
	wallEffects = []
	while obj != OBJ.INTERMISSION:
		wallPos = vect(random.uniform(-20, 20 - WallGap * WallWidth), 0, 20)
		for wallI in range(54):
			createProjectile(Projectile.ECHO_STICKY_BOMB, nipman, LeftNip if wallI % 2 == 0 else RightNip, directionTowards(LeftNip if wallI % 2 == 0 else RightNip, wallPos + vect(wallI % WallWidth, floor(wallI / WallWidth), 0) * WallGap), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 0, 0, 0.1, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, 0.1, 50,
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
			wait(0.096)
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
	wait(THREATS.RAIN * 0.032)
	createEffect(getAllPlayers(), Effect.CLOUD, Color.GRAY, Vector.UP * 30, 40, EffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	for rainVar in range(5):
		createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIGHT_RED, RainPosFormula + Vector.DOWN * 21, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, RainPosFormula, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION:
		for rainVar in range(5):
			if rainVar % 2 == 0: # halve the cloud seeding fx
				createProjectile(Projectile.ECHO_STICKY_BOMB, null, LeftNip if rainVar == 4 else RightNip, directionTowards(nipman.getEyePosition(), vect(random.uniform(-10,10), 30, random.uniform(-15,19))), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 1,1,0,DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0.05, 30, 1, 0,0,-5)
			wait(0.048)
			createProjectile(Projectile.MEI_ICICLE, null, RainPosFormula + Vector.UP * 30 + vect(random.uniform(-0.5,0.5),0,random.uniform(-0.5,0.5)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 25, 1,3.2,DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT, DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, 0.07, 200, 1,3,0,0)

rule "twister":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.TWISTER in threatList
	wait(THREATS.TWISTER * 0.032)

	for twisterCache in range(3,12,2):
		# smallMessage(getAllPlayers(), i)
		createEffect(getAllPlayers(), Effect.BAD_AURA, Color.GRAY, Vector.UP * evalOnce(twisterCache*2.5 - 6) + twisterPos, evalOnce(twisterCache * 0.7), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
		threatFx.append(getLastCreatedEntity())
		createProjectileEffect(getAllPlayers(), Projectile.ECHO_STICKY_BOMB, null, twisterPos + evalOnce(twisterCache) * 0.8 * vect(cos(getTotalTimeElapsed() * 7 + evalOnce(twisterCache)), 1 + 0.4 * sin(getTotalTimeElapsed()), sin(getTotalTimeElapsed() * 7 + evalOnce(twisterCache))), Vector.UP, evalOnce(random.uniform(0,0.05)), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		threatFx.append(getLastCreatedEntity())
		createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, twisterPos + evalOnce(twisterCache) * 0.8 * vect(cos(getTotalTimeElapsed() * 9 + evalOnce(twisterCache)), 1.3 + 0.4 * cos(getTotalTimeElapsed()), sin(getTotalTimeElapsed() * 9 + evalOnce(twisterCache))), Vector.UP, evalOnce(random.uniform(0,0.05)), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
		threatFx.append(getLastCreatedEntity())
		wait()
	createEffect(getAllPlayers(), Effect.RING, Color.TEAM_2, twisterPos, 6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createEffect(getAllPlayers(), Effect.CLOUD, Color.GRAY, twisterPos + 24 * Vector.UP, 30, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_PARTICLE_CANNON, null, twisterPos + 7 * Vector.DOWN, Vector.DOWN, 1, ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)
	threatFx.append(getLastCreatedEntity())

	twisterPos = LeftNip * vect(1,0,1)
	chase(twisterPos, getRealClosestPlayer(twisterPos,Team.1).getPosition()*vect(1,0,1), rate=1.6, ChaseReeval.DESTINATION_AND_RATE)
	while obj != OBJ.INTERMISSION:
		twisterCache = [x for x in getLivingPlayers(Team.1) if distance(x.getPosition() * vect(1,0,1), twisterPos) < 6 and x.getPosition().y < 25]
		twisterCache.applyImpulse(Vector.UP, 7, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
		damage(twisterCache, null, 35)
		wait(0.24)

rule "sun loop":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.SUN in threatList

	while obj != OBJ.INTERMISSION:
		wait(0.64)
		threatSuns.setInvisibility(Invis.ENEMIES)
		threatSuns.setStatusEffect(null, Status.PHASED_OUT, 99999)
		threatSuns.startForcingName(BOTNAME_ILLARIS)
		threatSuns.setProjectileSpeed(30)
		threatSuns.disableNameplatesFor(getAllPlayers())
		threatSuns.setDamageDealt(max(20,120 / len(threatSuns)))
		threatSuns.startModifyingVoicelinePitch(0, false)
		threatSuns.setUltCharge(100)
		wait(4)
		threatSuns.forceButtonPress(Button.ULTIMATE)
		for isun in range(len(threatSuns)):
			if entityExists(threatSuns[isun]) == false:
				threatSuns.remove(threatSuns[isun])
			else:
				threatSuns[isun].setFacing(directionTowards(threatSuns[isun].getEyePosition(), random.choice(getLivingPlayers(Team.1)).getPosition()), Relativity.TO_WORLD)
			wait(0.064)
		# threatSuns.slice(0,len(threatSuns)/2).setFacing(, Relativity.TO_PLAYER)
		# threatSuns.slice(len(threatSuns/2),len(threatSuns)).setFacing(directionTowards(RightNip + Vector.UP * 5, random.choice(getLivingPlayers(Team.1)).getEyePosition()), Relativity.TO_WORLD)
		wait(2)
		threatSuns.forceButtonPress(Button.PRIMARY_FIRE)

rule "gravitatas":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.GRAV in threatList

	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, null, LeftNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, null, RightNip, Vector.BACKWARD, 0.27, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

	# there was an issue with players getting stuck on the bottom rocks opposite mauga
	# getPlayers(Team.1).startAcceleration(Vector.FORWARD + 0.15 * Vector.DOWN, 80, 15, Relativity.TO_WORLD, AccelReeval.NONE)
	while obj != OBJ.INTERMISSION:
		getPlayers(Team.1).setGravity(300)
		wait(6)
rule "boolet":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.DAKKA in threatList
	wait(THREATS.DAKKA * 0.032)
	while obj != OBJ.INTERMISSION:
		createProjectile(Projectile.ORISA_FUSION_DRIVER, null, LeftNip,
			vect(sin(getTotalTimeElapsed()*2)*0.5, cos(getTotalTimeElapsed()) * 0.1 - 0.2, -1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 130, 1, 0, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0.04, 14, 4, 0, 0,0)
		wait(0.016 * 5)
		createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, null, RightNip,
			vect(sin(getTotalTimeElapsed()*2)*-0.5, cos(getTotalTimeElapsed()) * -0.1 - 0.2, -1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 130, 1, 0, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0.1, 14, 4, 0, 0,0)
		wait(0.016 * 5)
rule "laser":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.LASER in threatList
	wait(THREATS.LASER * 0.032)
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

	while obj != OBJ.INTERMISSION:
		createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, null, area1 + 0.5 * Vector.UP, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 3, DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, 0, getTotalTimeElapsed(), 10, 55, 0, 0)
		wait(0.08)
		createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, null, area2 + 0.5 * Vector.UP, Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 3, DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, 0, getTotalTimeElapsed(), 3, 55, 0, 0)
		wait(0.8)

rule "discharge":
	@Event eachPlayer
	@Hero mauga
	@Condition (eventPlayer == nipman) or (obj == OBJ.MORE and eventPlayer in objPos)
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.COOM in threatList
	wait(THREATS.COOM * 0.032)

	createDummy(Hero.TORBJORN, Team.2, -1, Vector.UP, Vector.BACKWARD)
	eventPlayer.botA = getLastCreatedEntity()
	threatLactaters.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(eventPlayer.smallLNip, false)
	createDummy(Hero.TORBJORN, Team.2, -1, Vector.UP, Vector.BACKWARD)
	eventPlayer.botB = getLastCreatedEntity()
	threatLactaters.append(getLastCreatedEntity())
	getLastCreatedEntity().startForcingPosition(eventPlayer.smallRNip, false)
	wait(0.36)
	threatLactaters.setWeapon(2)
	threatLactaters.startScalingSize(0.3, false)
	threatLactaters.setStatusEffect(null, Status.PHASED_OUT, 9999)
	threatLactaters.setInvisibility(Invis.ALL)
	threatLactaters.startForcingButton(Button.PRIMARY_FIRE)
	eventPlayer.botA.startFacing(evalOnce(directionTowards(eventPlayer.smallLNip * vect(1,0,1), Vector.LEFT * 20)) * sin(getTotalTimeElapsed() * 33) * 0.7 + 0.4 * (Vector.UP * (sin(getTotalTimeElapsed() * 47) + 0.25)) + (eventPlayer.getFacingDirection()), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	eventPlayer.botB.startFacing(evalOnce(directionTowards(eventPlayer.smallRNip * vect(1,0,1), Vector.LEFT * 20)) * sin(getTotalTimeElapsed() * 33) * 0.7 + 0.4 * (Vector.UP * (sin(getTotalTimeElapsed() * 47) + 0.25)) + (eventPlayer.getFacingDirection()), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	# eventPlayer.botA.startFacing(worldVector(vect(sin(getTotalTimeElapsed() * 33)*0.45, sin(getTotalTimeElapsed() * 47)*0.32 - 0.09, -1), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * 3, 50, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	# eventPlayer.botB.startFacing(worldVector(vect(sin(getTotalTimeElapsed() * 33)*0.45, sin(getTotalTimeElapsed() * 47)*0.32 - 0.09, -1), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * 3, 50, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	wait(0.36)
	threatLactaters.startModifyingVoicelinePitch(1 + 0.5 * sin(getTotalTimeElapsed()*2), true)
	threatLactaters.startForcingName(BOTNAME_TORBS)
	threatLactaters.disableNameplatesFor(getAllPlayers())

	# main mauga torbs are higher
	nipman.botA.setProjectileGravity(140)
	nipman.botB.setProjectileGravity(140)

rule "everybody discharge":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.COOM in threatList
	while THREATS.COOM in threatList:
		wait(3)
		threatLactaters.setUltCharge(100)
		threatLactaters.setDamageDealt((80 / len(threatLactaters)))
		threatLactaters.disableNameplatesFor(getAllPlayers())
		wait(0.12)
		threatLactaters.forceButtonPress(Button.ULTIMATE)
		wait(7)

rule "heal milk":
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.HEAL in threatList
	@Condition (eventPlayer in mobs) == false
	@Condition eventPlayer == nipman or (obj == OBJ.MORE and eventPlayer in objPos)

	wait(0.48)
	createProjectileEffect(getAllPlayers(), Projectile.MOIRA_HEAL_ORB, null, eventPlayer.smallLNip, eventPlayer.getFacingDirection(), 0, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.MOIRA_HEAL_ORB, null, eventPlayer.smallRNip, eventPlayer.getFacingDirection(), 0, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

	while obj != OBJ.INTERMISSION and eventPlayer.isAlive():
		wait(0.8)
		createHomingProjectile(Projectile.ECHO_STICKY_BOMB, eventPlayer, eventPlayer.smallLNip + eventPlayer.getFacingDirection() * 2, eventPlayer.getFacingDirection(), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.2, 20, 1, 1, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0.05, 60,10,0,random.choice(objPos.exclude(eventPlayer) if obj == OBJ.MORE else mobs))
		createHomingProjectile(Projectile.ECHO_STICKY_BOMB, eventPlayer, eventPlayer.smallRNip + eventPlayer.getFacingDirection() * 2, eventPlayer.getFacingDirection(), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.2, 20, 1, 1, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, 0.05, 60,10,0,random.choice(objPos.exclude(eventPlayer) if obj == OBJ.MORE else mobs))

#!define NukeAoe 10
rule "nuke":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.NUKE in threatList
	wait(THREATS.NUKE * 0.032)

	# debug
	# createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.ROSE, missilePos, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	while obj != OBJ.INTERMISSION:
		missileFx = []
		missilePos = vect(0,1,20)
		chaseAtRate(missilePos, getRealClosestPlayer(missilePos, Team.1).getPosition() * vect(1,0,1) + Vector.UP, 5, ChaseRateReeval.DESTINATION_AND_RATE)
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

		playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, Color.TEAM_2, LeftNip, 1)
		playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION, Color.TEAM_2, RightNip, 1)
		createProjectile(Projectile.PHARAH_ROCKET, nipman, LeftNip, directionTowards(LeftNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, 0, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,70, 0,0)
		createProjectile(Projectile.PHARAH_ROCKET, nipman, RightNip, directionTowards(RightNip, missilePos + Vector.UP * 2), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, 0, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, 1, 100, 0.5,70, 0,0)
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

rule "ice effect init":
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.ICE in threatList
	@Condition (eventPlayer == nipman) or (eventPlayer in objPos and obj == OBJ.MORE)
	waitUntil(eventPlayer.smallLNip != null, 3)
	createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, eventPlayer.smallLNip /*+ eventPlayer.getFacingDirection() * 5.2/20 * (20 if eventPlayer == nipman else MiniScale)*/, eventPlayer.getFacingDirection(), 0.5, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers(), Projectile.MEI_ICICLE, null, eventPlayer.smallRNip /*+ eventPlayer.getFacingDirection() * 5.2/20 * (20 if eventPlayer == nipman else MiniScale)*/, eventPlayer.getFacingDirection(), 0.5, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

# more maugas threat duping
rule "feetpples TOO MANY":
	@Disabled
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.SNIPER in threatList
	@Condition (eventPlayer.smallLNip == nipman.smallLNip) or (obj == OBJ.MORE and eventPlayer in objPos)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	createDummy(Hero.SIGMA, Team.2, -1, Vector.UP, eventPlayer.getFacingDirection())
	eventPlayer.botA = getLastCreatedEntity()
	eventPlayer.botA.setFacing(eventPlayer.getFacingDirection(), Relativity.TO_WORLD)
	eventPlayer.botB.setFacing(vect(0.34,0.14,0.93), Relativity.TO_PLAYER)
	threatToes.append(eventPlayer.botA)
	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, eventPlayer.botA.getEyePosition(), (eventPlayer.botA.getEyePosition() + 80 * eventPlayer.botA.getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createDummy(Hero.SIGMA, Team.2, -1, Vector.UP, Vector.BACKWARD)
	eventPlayer.botB = getLastCreatedEntity()
	eventPlayer.botB.setFacing(eventPlayer.getFacingDirection(), Relativity.TO_WORLD)
	eventPlayer.botB.setFacing(vect(0.34,0.14,0.93), Relativity.TO_PLAYER)
	threatToes.append(eventPlayer.botB)
	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, eventPlayer.botB.getEyePosition(), (eventPlayer.botB.getEyePosition() + 80 * eventPlayer.botB.getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	threatToes.setStatusEffect(null, Status.PHASED_OUT, 99999)
	threatToes.startScalingSize(4, false)
	wait(0.48)
	eventPlayer.botB.startForcingPosition(eventPlayer.smallRNip + Vector.DOWN * 0.5, false)
	eventPlayer.botA.startForcingPosition(eventPlayer.smallLNip + Vector.DOWN * 0.5, false)

rule "dupe ice":
	@Condition obj == OBJ.MORE
	@Condition THREATS.ICE in threatList
	while obj != OBJ.INTERMISSION:
		wait(9)
		# share target
		# must be owned by main mauga to apply freeze
		createProjectile(Projectile.MEI_ICICLE, nipman, cycledClone.smallLNip, directionTowards(cycledClone.smallLNip, target1), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)
		wait(0.36)
		createProjectile(Projectile.MEI_ICICLE, nipman, cycledClone.smallRNip, directionTowards(cycledClone.smallRNip, target2), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 20, 1, 1, DynamicEffect.TRACER_RECALL_REAPPEAR, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0.2, 20, 10, 0, 0, 0)

rule "dupe boolet":
	@Event eachPlayer
	@Hero mauga
	@Condition obj == OBJ.MORE
	@Condition THREATS.DAKKA in threatList
	@Condition (eventPlayer in objPos)
	# print("bullet dupe run")
	while obj == OBJ.MORE:
		wait(0.36)
		# smallMessage(hostPlayer, eventPlayer.smallRNip)
		createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, eventPlayer, vect(0.360, 1.371, 0.266)*MiniScale, vect(sin(getTotalTimeElapsed())*-12,-0.5,9), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 50, 1,0,DynamicEffect.BAD_EXPLOSION, DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, 0.03, 20, 3, 0,0,0)
		createProjectile(Projectile.ORISA_FUSION_DRIVER, eventPlayer, vect(-0.137, 1.378, 0.466)*MiniScale, vect(sin(getTotalTimeElapsed()) * 12,-0.5,9), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 50, 1,0,DynamicEffect.BAD_EXPLOSION, DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, 0.03, 20, 3, 0,0,0)

rule "dupe + normal sniper":
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.SNIPER in threatList
	@Condition (eventPlayer.smallLNip == nipman.smallLNip and eventPlayer == nipman) or (obj == OBJ.MORE and eventPlayer in objPos)
	wait(0.048 * objPos.index(eventPlayer))
	createDummy(Hero.WIDOWMAKER, Team.2, -1, Vector.UP, eventPlayer.getFacingDirection())
	eventPlayer.botA = getLastCreatedEntity()
	eventPlayer.botA.startFacing(directionTowards(eventPlayer.botA.getEyePosition(), eventPlayer.botA.mobTarget.getEyePosition()), 5, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	threatSnipers.append(eventPlayer.botA)
	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, eventPlayer.botA.getEyePosition(), (eventPlayer.botA.getEyePosition() + 80 * eventPlayer.botA.getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())
	createDummy(Hero.WIDOWMAKER, Team.2, -1, Vector.UP, Vector.BACKWARD)
	eventPlayer.botB = getLastCreatedEntity()
	eventPlayer.botB.startFacing(directionTowards(eventPlayer.botB.getEyePosition(), eventPlayer.botB.mobTarget.getEyePosition()), 5, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
	threatSnipers.append(eventPlayer.botB)
	createBeam(getAllPlayers(), Beam.TORBJORN_TURRET_SIGHT, eventPlayer.botB.getEyePosition(), (eventPlayer.botB.getEyePosition() + 80 * eventPlayer.botB.getFacingDirection()), Color.TEAM_2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	threatFx.append(getLastCreatedEntity())

	threatSnipers.startForcingButton(Button.SECONDARY_FIRE)
	threatSnipers.disableNameplatesFor(getAllPlayers())
	threatSnipers.startForcingName(BOTNAME_SNIPERS)
	threatSnipers.setStatusEffect(null, Status.PHASED_OUT, 9999)
	threatSnipers.startScalingSize(0.1, false)

	wait(0.48)
	eventPlayer.botB.startForcingPosition(eventPlayer.smallRNip, false)
	eventPlayer.botA.startForcingPosition(eventPlayer.smallLNip, false)

rule "sniper change target":
	@Event eachPlayer
	@Hero widowmaker
	@Team 2
	while obj != OBJ.INTERMISSION:
		wait(12)
		eventPlayer.mobTarget = random.choice(getLivingPlayers(Team.1))
		eventPlayer.setAmmo(0,9999)

rule "sniper target dead":
	@Event eachPlayer
	@Hero widowmaker
	@Team 2
	while obj != OBJ.INTERMISSION:
		wait(2)
		if not (eventPlayer.mobTarget.isAlive() and entityExists(eventPlayer.mobTarget)):
			eventPlayer.mobTarget = random.choice(getLivingPlayers(Team.1))

rule "sniper fire":
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.SNIPER in threatList
	wait(1.504)
	threatSnipers.setDamageDealt(50 if obj == OBJ.MORE else 90)
	threatSnipers.forceButtonPress(Button.PRIMARY_FIRE)
	if ruleCondition:
		loop()

rule "init suns":
	@Event eachPlayer
	@Hero mauga
	@Condition obj != OBJ.INTERMISSION
	@Condition THREATS.SUN in threatList
	@Condition (eventPlayer.smallLNip == nipman.smallLNip) or (obj == OBJ.MORE and eventPlayer in objPos)

	createDummy(Hero.ILLARI, Team.2, -1, eventPlayer.smallLNip, Vector.DOWN)
	threatSuns.append(getLastCreatedEntity())
	eventPlayer.botA = (getLastCreatedEntity())
	createDummy(Hero.ILLARI, Team.2, -1, eventPlayer.smallRNip, Vector.DOWN)
	threatSuns.append(getLastCreatedEntity())
	eventPlayer.botB = (getLastCreatedEntity())

	eventPlayer.botA.startForcingPosition(eventPlayer.smallLNip, false)
	eventPlayer.botB.startForcingPosition(eventPlayer.smallRNip, false)

	wait(0.64)
	# eventPlayer.threatDecor = []
	createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, eventPlayer.smallLNip, eventPlayer.getFacingDirection(), 0, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())
	createProjectileEffect(getAllPlayers() if THREATS.SUN in threatList else [], Projectile.REINHARDT_FIRE_STRIKE, null, eventPlayer.smallRNip, eventPlayer.getFacingDirection(), 0.02, ProjectileEffectReeval.VISIBILITY)
	threatFx.append(getLastCreatedEntity())

# objective setup
rule "missing mauga":
	@Condition obj == OBJ.MORE
	@Condition all([not entityExists(x) for x in objPos])
	wait(2, Wait.ABORT_WHEN_FALSE)
	smallMessage(getAllPlayers(), MESSAGE_MAUGA_GONE)
	objProg = objGoal
	wait(2, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		loop()
rule "NO BOTS?":
	@Condition obj == OBJ.KILL or obj == OBJ.CAPTURE or obj == OBJ.BOSS # slendy is also a mob
	@Condition getNumberOfPlayers(Team.2) < 7
	wait(3, Wait.ABORT_WHEN_FALSE)
	for i in range(len(mobs)):
		destroyDummy(mobs[i].getTeam(), mobs[i].getSlot())

	mobs = []

	mobsInit()

	wait(3, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		goto RULE_START

rule "more maugas":
	@Condition obj == OBJ.MORE
	wait(0.016 * THREATS.MORE)
	objPos = []
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP * nipman.getMaxHealth(), Vector.LEFT) # need to keep them far away or the fingers block the weak spots
	objPos.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP * nipman.getMaxHealth(), Vector.RIGHT)
	objPos.append(getLastCreatedEntity())
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP * nipman.getMaxHealth(), Vector.FORWARD)
	objPos.append(getLastCreatedEntity())
	objPos.setGravity(0)
	wait()
	objPos.startScalingSize(MiniScale,false)
	objPos.disablePlayerCollision()
	objPos.disableEnvironmentCollision(true)
	objPos.setKnockbackReceived(0)
	objPos.setMaxHealth(2000)
	wait(0.12)
	heal(objPos, null, 99999)
	objPos.setHealingDealt(0)
	for iMores in range(0,3,1):
		wait()
		objPos[iMores].startForcingPosition([vect(-31,-18,0), vect(31,-18,0), vect(0,-18,-31)][iMores], false)
		wait(0.096) # LOAD BEARING WAIT. NEEDS TO BE THIS LONG AT LEAST
		objPos[iMores].smallLNip = worldVector(vect(0.360, 1.371, 0.266)*MiniScale, objPos[iMores], Transform.ROTATION_AND_TRANSLATION)
		objPos[iMores].smallRNip = worldVector(vect(-0.137, 1.378, 0.466)*MiniScale, objPos[iMores], Transform.ROTATION_AND_TRANSLATION)
		objPos[iMores].startForcingName(BOTNAME_MAUGA_JR)
		# createProgressBarInWorldText(getAllPlayers(), /*evalOnce(objPos[iMores]).getHealth() / evalOnce(ceill(objPos[iMores].getHealth()))evalOnce(objPos[iMores]).getNormalizedHealth()*/  * 100, "{} / {} HP".format(ceil(evalOnce(objPos[iMores]).getHealth()), evalOnce(ceil(objPos[iMores].getHealth()))/*.getMaxHealth()*/), objPos[iMores].getEyePosition() + Vector.UP * 2, 1, Clip.NONE, Color.RED, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_AND_VALUES, SpecVisibility.DEFAULT)
		# WHY IS IT 400. IT SHOULD BE 100 BUT THAT MAKES IT WRONG evalOnce(objPos[iMores]).getNormalizedHealth() * 400
		createProgressBarInWorldText(getAllPlayers(), (evalOnce(objPos[iMores]).getHealth() / evalOnce(ceil(objPos[iMores].getMaxHealth()))) * 100, "{} / {} HP".format(ceil(evalOnce(objPos[iMores]).getHealth()), evalOnce(ceil(objPos[iMores].getMaxHealth()))), objPos[iMores].getEyePosition() + Vector.UP * 2, 1, Clip.NONE, Color.RED, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_AND_VALUES, SpecVisibility.DEFAULT)
		objPos[iMores].hpBar = getLastCreatedText()
		threatFx.append(getLastCreatedText())
	wait(0.8)
	objPos.setStatusEffect(null, Status.FROZEN, 99999)
	wait(0.8)
	objPos.setStatusEffect(null, Status.FROZEN, 99999)
	heal(objPos, null, 99999)

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
		objPos.setDamageDealt(55)
	objPos.startForcingThrottle(1,1,0,0,0,1)
	objPos.startForcingName(BOTNAME_MINIBOSS)
	objPos.startFacing(directionTowards(objPos.getPosition(), objPos.mobTarget.getPosition()), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

	if objPos.getHero() == Hero.MAUGA:
		objPos.setMaxHealth(1200)
		objPos.setDamageDealt(35)
	else:
		objPos.setMaxHealth(3500 if objPos.getCurrentHero() in getTankHeroes() else 4500)

	wait(2)
	objPos.disablePlayerCollision() # laggy i think
	waitUntil(objPos.isOnGround(), 4)
	objPos.setStatusEffect(null,Status.KNOCKED_DOWN,2)
	if enemies[roundNo%len(enemies)] != Hero.MAUGA:
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
	if entityExists(eventPlayer.hpBar):
		destroyProgressBarInWorldText(eventPlayer.hpBar)
	destroyDummy(Team.2, eventPlayer.getSlot())

rule "setup & refresh forest":
	@Condition obj == OBJ.PAGES
	wait(1.5, Wait.ABORT_WHEN_FALSE)
	for i in range(TreeNo):
		createDummy(Hero.LIFEWEAVER, Team.2, -1, Vector.UP, Vector.DOWN)
		getLastCreatedEntity().startModifyingVoicelinePitch(0.5 + i * (1/TreeNo), false)
		wait(0.032)
		if len(getPlayersOnHero(Hero.LIFEWEAVER, Team.2)) > TreeNo:
			break

	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setStatusEffect(null, Status.PHASED_OUT, 9999)
	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setInvisibility(Invis.ENEMIES)
	getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setHealingDealt(30)

	wait(1.2)

	while obj == OBJ.PAGES:
		if (getPlayersOnHero(Hero.LIFEWEAVER, Team.2) == 0):
			loop()
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
		wait(0.44)
		getPlayersOnHero(Hero.LIFEWEAVER, Team.2).setStatusEffect(null, Status.HACKED, 0.5)
		wait(14, Wait.ABORT_WHEN_FALSE)

rule "place objective":
	@Condition obj == OBJ.CAPTURE
	objPos = vect(random.randint(-13,13),0,random.randint(-13,13))
	wait()
	if (objPos.z < CageMinZ) and THREATS.CAGE in threatList:
		loop()
# objective progress
rule "kill/obj prog/weak spot + respawn timer":
	@Event playerDied
	@Condition eventPlayer.isDummy()
	@Condition eventPlayer != nipman

	if eventPlayer in weakSpots:
		weakSpots.remove(eventPlayer)
		playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR, Color.TEAM_2, eventPlayer, 1)
		playEffect(getAllPlayers(), DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer, 50)
		wait(0.48)
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
			kill(weakSpots, null)
			destroyEffect(moreFx)
			moreFx = []
			attackingClone = null
		objProg++
		destroyDummy(eventPlayer.botA.getTeam(), eventPlayer.botA.getSlot())
		destroyDummy(eventPlayer.botB.getTeam(), eventPlayer.botB.getSlot())
		objPos.remove(eventPlayer)
		destroyProgressBarInWorldText(eventPlayer.hpBar)
		eventPlayer.disableRespawn()
		wait(1.2)
		destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
	eventPlayer.setRespawnTime(1.8)
	# kills++

rule "point":
	@Condition obj == OBJ.CAPTURE
	if getPlayersInRadius(objPos, 12, Team.1, LosCheck.OFF) != []:
		objProg += len(getPlayersInRadius(objPos, 12, Team.1, LosCheck.OFF)) / getNumberOfPlayers(Team.1) * 3
		playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TEAM_1, objPos + Vector.DOWN * 0.3, 25)
		playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, objPos, 150)
	wait(0.64)
	if RULE_CONDITION:
		goto RULE_START

rule "page found":
	@Event eachPlayer
	@Team 1
	@Condition obj == OBJ.PAGES
	@Condition eventPlayer.isDummy() == false
	@Condition distance(eventPlayer, objPos) < 1.3
	smallMessage(getAllPlayers(), STR_PAGEFOUND.format(eventPlayer))
	playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, objPos, 65)
	playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.TEAM_1, objPos, 1)
	addToTeamScore(Team.1, 1) # sound
	setTeamScore(Team.1, 0)
	objProg++
	objPos = vect(random.randint(-18,18),0,random.randint(CageMinZ if THREATS.CAGE in threatList else -18,16))

rule "debug finish obj":
	@Condition "{}".format(hostPlayer) == "OMGIDIED"
	@Condition hostPlayer.isHoldingButton(Button.INTERACT)
	@Condition hostPlayer.isHoldingButton(Button.CROUCH)
	@Condition hostPlayer.isHoldingButton(Button.MELEE)
	@Condition hostPlayer.isHoldingButton(Button.JUMP)
	wait(1, Wait.ABORT_WHEN_FALSE)
	if obj != OBJ.INTERMISSION:
		objProg = objGoal
	smallMessage(hostPlayer, hostPlayer.__languageIndex__)
	hostPlayer.__languageIndex__ += 1
	hostPlayer.__languageIndex__ = (hostPlayer.__languageIndex__ % 3)
# misc
rule "flava fla":
	wait(random.uniform(6,12))
	if random.randint(0,1) == 1:
		random.choice(getLivingPlayers(Team.2)).communicate(Comms.HELLO)
	else:
		random.choice(getLivingPlayers(Team.2)).communicate(Comms.VOICE_LINE_UP)
rule "wrong mauga":
	@Event playerDealtDamage
	@Condition victim == nipman
	@Condition obj != OBJ.INTERMISSION
	eventPlayer.communicate(Comms.NO)
	smallMessage(eventPlayer, f"{iconString(Icon.CROSS)} {Hero.MAUGA} {l'Protected'}")
	playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, Color.TEAM_1, nipman, true)
	wait(10)
rule "rez cd if not hardcore":
	wait(2)
	if isHardcore == false:
		while true:
			getPlayersOnHero(Hero.MERCY, Team.1).setAbilityCooldown(Button.ABILITY_2, 0)
			wait(1)

rule "player count balancing, freeze & nip pos check":
	while true:
		if createWorkshopSettingBool(SETTING_GAMEPLAY, SETTING_PLAYERSCALE,true,0):
			# getPlayers(Team.1).setDamageDealt(100 + (20 * (9 - getNumberOfPlayers(Team.1))))
			getPlayers(Team.1).setDamageDealt(min(400,900 / len([x for x in getPlayers(Team.1) if x.hasSpawned()])))
		if (obj != OBJ.INTERMISSION):
			nipman.setStatusEffect(null, Status.FROZEN, 99999)
			nipman.setDamageReceived(0.001)
			if obj == OBJ.MORE:
				if all([x.hasStatus(Status.STUNNED) == false for x in objPos]):
					objPos.setStatusEffect(null, Status.FROZEN, 99999)
		# if nipman.smallLNip.y <= 4 or nipman.smallRNip.y <= 4:
		nipman.smallLNip = NipmanLeftConst
		nipman.smallRNip = NipmanRightConst
		wait(5)
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
	upto = nipman.getMaxHealth()
	wait(0.08)
	nipman.setMaxHealth(10000)
	# kill(nipman, null) # this is to fill hp and reset his pose
	nipman.setKnockbackReceived(0)
	disableGamemodeCompletion()
	disableMusic()
	disableScoring()
	heal(nipman, null, 999999)
	wait()
	nipman.setHealingReceived(0)
	wait()
	nipman.setHealth(57500)
	wait(1, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		goto RULE_START

rule "charge no breaky":
	@Event eachPlayer
	@Hero reinhardt
	@Condition eventPlayer.isUsingAbility1()
	@Condition eventPlayer.getPosition().z > 18
	@Condition eventPlayer.getFacingDirection().z > -0.7
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, STR_CHIDING)

rule "charge no breaky more maugas":
	@Event eachPlayer
	@Hero reinhardt
	@Condition obj == OBJ.MORE
	@Condition eventPlayer.isUsingAbility1()
	@Condition ((eventPlayer.getPosition().z < -18 and eventPlayer.getFacingDirection().z < 0.7)
	or (eventPlayer.getPosition().x < -18 and eventPlayer.getFacingDirection().x < 0.7)
	or (eventPlayer.getPosition().x > 18 and eventPlayer.getFacingDirection().x > -0.7))
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, STR_CHIDING)

rule "echo charge no breaky":
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.REINHARDT
	@Condition eventPlayer.isUsingAbility1()
	@Condition eventPlayer.getPosition().z > 18
	@Condition eventPlayer.getFacingDirection().z > -0.7
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, STR_CHIDING)

rule "echo charge no breaky more maugas":
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.REINHARDT
	@Condition obj == OBJ.MORE
	@Condition eventPlayer.isUsingAbility1()
	@Condition ((eventPlayer.getPosition().z < -18 and eventPlayer.getFacingDirection().z < 0.7)
	or (eventPlayer.getPosition().x < -18 and eventPlayer.getFacingDirection().x < 0.7)
	or (eventPlayer.getPosition().x > 18 and eventPlayer.getFacingDirection().x > -0.7))
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	eventPlayer.cancelPrimaryAction()
	smallMessage(eventPlayer, STR_CHIDING)

rule "punch no breaky":
	@Event eachPlayer
	@Hero doomfist
	@Disabled
	@Condition obj != OBJ.INTERMISSION
	@Condition eventPlayer.isFiringSecondaryFire()
	@Condition eventPlayer.getPosition().z > 15
	@Condition eventPlayer.getFacingDirection().z > 0
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, STR_CHIDING)

rule "hook no breaky":
	@Event eachPlayer
	@Hero roadhog
	@Disabled
	@Condition obj != OBJ.INTERMISSION
	@Condition eventPlayer.isUsingAbility1()
	@Condition raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + 35 * eventPlayer.getFacingDirection(), getPlayers(Team.2), getPlayersOnHero(Hero.LIFEWEAVER, Team.2), true).getPlayerHit() == nipman
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	smallMessage(eventPlayer, STR_CHIDING)
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
	@Condition victim == nipman # or (obj == OBJ.MORE and victim in objPos)
	@Condition obj != OBJ.INTERMISSION
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
rule "echo hook unbreaky":
	@Event playerDealtDamage
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.ROADHOG
	@Condition victim == nipman or (obj == OBJ.MORE and victim in objPos)
	@Condition obj != OBJ.INTERMISSION
	@Condition eventAbility == Button.ABILITY_1
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.5)
	victim.clearStatusEffect(Status.FROZEN)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	victim.setStatusEffect(null, Status.FROZEN, 9999)

rule "hog ult nerf":
	@Event eachPlayer
	@Hero roadhog
	@Condition eventPlayer.isUsingUltimate()
	eventPlayer.setDamageDealt(35)
	waitUntil(eventPlayer.isUsingUltimate() == false, 8)
	eventPlayer.setDamageDealt(100)

rule "echo hog ult nerf":
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.ROADHOG
	@Condition eventPlayer.isUsingUltimate()
	eventPlayer.setDamageDealt(35)
	waitUntil(eventPlayer.isUsingUltimate() == false, 8)
	eventPlayer.setDamageDealt(100)

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
	getPlayers(Team.ALL).communicate(Comms.VOICE_LINE_UP)
	wait(0.48)
	declareTeamVictory(Team.1)
	destroyAllEffects()
	setSlowMotion(100)
	wait(3)
	restartMatch()

rule "player init, cage add":
	@Event eachPlayer
	@Team 1
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
	wait(0.48)
	stopDamageModification(eventPlayer.mobTarget)
rule "echo sombra aint slick":
	@Event eachPlayer
	@Hero echo
	@Condition eventPlayer.getHeroOfDuplication() == Hero.SOMBRA
	@Condition eventPlayer.isUsingUltimate() or (eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.getUltCharge() == 100)
	startDamageModification(getPlayersOnHero(Hero.MAUGA, Team.2), eventPlayer, 2, DamageReeval.NONE)
	eventPlayer.mobTarget = getLastDamageModification()
	waitUntil(eventPlayer.getUltCharge() < 100, 2)
	wait(0.48)
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
			bigMessage(getAllPlayers(), STR_ALLDEAD)
			setSlowMotion(50)
			wait(1)
			declareTeamVictory(Team.2)
			destroyAllEffects()
			setSlowMotion(100)
			wait(3)
			restartMatch()