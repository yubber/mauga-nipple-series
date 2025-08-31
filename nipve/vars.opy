#!mainFile "pvnip.opy"
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
	HOLE,
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

macro MaxBots = 15-1
macro TreeNo = 7
macro NipmanForcePosConst = vect(0,-17-2.8,35)
macro NipmanLeftConst = vect(2.93, 10.84-2.8, 26.15)
macro NipmanRightConst = vect(-7.19, 10.8-2.8, 30.27)

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
globalvar dummyThreats = [THREATS.COOM, THREATS.SNIPER, THREATS.SUN, THREATS.FRACTAL, THREATS.DRAGON, THREATS.TOES, THREATS.HOLE/*, THREATS.KITSUNIPS*/]
# threats that don't scale in more maugas. ie threats that cannot share global variables, affect mobs only or won't scale in fun ways
# globalvar moreBlacklist = [THREATS.BOOST, THREATS.DD, THREATS.CAGE, THREATS.GRAB, THREATS.GRAV, THREATS.WALL, THREATS.TWISTER, THREATS.RAIN, THREATS.NUKE]

# threats that have extra behavior in more maugas
globalvar moreFunThreats = [THREATS.ICE, THREATS.COOM, THREATS.DAKKA, /*THREATS.FRACTAL,*/ THREATS.HEAL, THREATS.SNIPER, THREATS.SUN]
# niplets can't be there because they block weak spots

# keep lazer as last and frosty as 1st after slender
globalvar threatIcons = [heroIcon(Hero.REAPER), abilityIconString(Hero.MAUGA, Button.ABILITY_1), abilityIconString(Hero.MEI, Button.ULTIMATE), abilityIconString(Hero.VENTURE, Button.MELEE), abilityIconString(Hero.HANZO, Button.ULTIMATE), /*abilityIconString(Hero.JUNO, Button.ABILITY_1),*/ heroIcon(Hero.SIGMA), abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), abilityIconString(Hero.SIGMA, Button.ABILITY_1), abilityIconString(Hero.MAUGA, Button.ULTIMATE), abilityIconString(Hero.JUNKER_QUEEN, Button.ULTIMATE), abilityIconString(Hero.HAZARD, Button.ULTIMATE), iconString(Icon.RADIOACTIVE), abilityIconString(Hero.REAPER, Button.ULTIMATE), abilityIconString(Hero.MEI, Button.ABILITY_2), iconString(Icon.PLUS), abilityIconString(Hero.TORBJORN, Button.ULTIMATE), abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), abilityIconString(Hero.ANA, Button.ULTIMATE), abilityIconString(Hero.PHARAH, Button.ULTIMATE), abilityIconString(Hero.ZARYA, Button.ULTIMATE), abilityIconString(Hero.ILLARI, Button.ULTIMATE), abilityIconString(Hero.ECHO, Button.ABILITY_2)]
#kitsunip rush, milk wall, mini mauga, tanky mobs 1 kill, heal, dd, milk rain (moving pillar beams), spoiled milk titties (global/big chasing dot?), maven degen like (chases then explodes after delay), restrict to 1 square of arena

globalvar enemies = [Hero.WINSTON, Hero.TORBJORN, Hero.REINHARDT, Hero.MAUGA]
globalvar mobDmg = [90, 130, 75, 60]
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
globalvar threatDrills
# globalvar threatTwinks
globalvar mobs = []
# persistent effects only (not destroyed until round end)
globalvar threatFx
globalvar antiCrashOn

globalvar hammerProg
globalvar hammerSide

globalvar hardcoreLevel = createWorkshopSettingEnum(SETTING_DIFFICULTY, SETTING_RESPAWN.NAME, 0, [
	SETTING_RESPAWN.ALWAYS,
	SETTING_RESPAWN.ROUND_END,
	SETTING_RESPAWN.NEVER
], 0)

globalvar nipmanLastHP

playervar mobTarget # also used for sniper target, milk wall victims (nipman.mobTarget)
playervar cacheA
playervar cacheB
playervar cacheC
playervar botA
playervar botB

### HUMAN PLAYERS
# player shoots wrong mauga
#!define wrongCounter cacheA
# autobot
#!define isBot cacheB
#!define scale cacheC

### THREATS
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

macro holePos = threatDrills[0].cacheA
macro drillI = threatDrills[0].cacheB

# event player.
#!define nipletsPosList botA.cacheA
playervar iniplets

# choose 1 clone for more maugas
#!define cycledClone objPos[getTotalTimeElapsed() % len(objPos)]
#!define MiniScale 15