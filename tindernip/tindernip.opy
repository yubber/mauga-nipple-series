settings {
    "lobby": {
        "allowPlayersInQueue": true,
        "enableMatchVoiceChat": true,
        "ffaSlots": 9,
        "spectatorSlots": 12
    },
    "gamemodes": {
        "ffa": {
            "gameLengthInMn": 15,
            "perkEliminationCatchupLevelAmount%": 100,
            "perkGeneration%": 500,
            "scoreToWin": 5000,
            "tankPassiveHealthBonus": "alwaysEnabled"
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "healthPackRespawnTime%": 75,
            "heroLimit": "off",
            "respawnTime%": 50,
            "spawnHealthPacks": "enabled"
        }
    }
}
#!extension buffStatusEffects
#!extension playMoreEffects
#!extension projectiles

#!define PLAYERFXLIMIT 24

# TODO: how to handle players? what to prioritize? more fx? more variety of fx? more players per lobby?

globalvar ethnicityNames = ["smokish", "shinese", "cyberian", ""]

globalvar traitNames = ["lumpy", "hard", "soft", "pepperoni sized", "penny sized", "sensitive", "leaky", "perky", "droopy"]

playervar opt
playervar menu

playervar ethnicityFx

playervar penSize = 0

playervar jewelleryFx = []
playervar jewelleryPos = []
playervar jewelleryColor = []
playervar demoJewellery

playervar likedPlayers = []

enum MENU:
	OFF,
	SIDE,
	ETHNICITY,
	JEWELLERY,
	PERSONALITY,

playervar menu

rule "global init":
	# demo doll

	# jewellery
	createInWorldText(localPlayer if localPlayer.menu == MENU.JEWELLERY else null, "\&white_circle;", localPlayer.jewelleryPos[localPlayer.opt], 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)

rule "scroll down":
	@Event eachPlayer
	@Condition eventPlayer.menu != MENU.OFF
	@Condition eventPlayer.menu != MENU.JEWELLERY
	@Condition eventPlayer.

rule "player init":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	eventPlayer.startForcingHero(Hero.MAUGA)
	eventPlayer.disableEnvironmentCollision(false)
	wait(0.16)
	eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
	eventPlayer.startScalingSize(20, false)

rule "interact":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.isAlive()
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
	# open menu if off else previous
	eventPlayer.menu += 1 if eventPlayer.menu == MENU.OFF else -1

rule "":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY
	if eventPlayer.penSize >= 20:
		smallMessage(eventPlayer, "that's big enough! your n!pples will droop under that weight!")
	else:
		eventPlayer.penSize++;
	wait(0.16)
	if ruleCondition:
		loop()

rule "cycle fx":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY

rule ".NoClip": # from workshop.codes/RVWKC
    @Event eachPlayer
    @Condition eventPlayer.menu == MENU.JEWELLERY
    # smallMessage(eventPlayer, ".NoClip [{0}]".format(eventPlayer._NoClip))
    eventPlayer.startForcingPosition(eventPlayer.getPosition() + ((Vector.UP * (eventPlayer.isHoldingButton(Button.JUMP) - eventPlayer.isHoldingButton(Button.CROUCH)) + worldVector(eventPlayer.getThrottle(), eventPlayer, Transform.ROTATION)) * createWorkshopSettingFloat(".NoClip", ".NoClip speed", 0.2, 0, 1)))
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
	eventPlayer.disableEnvironmentCollision(true)

rule "noclip off":
	@Event eachPlayer
    @Condition eventPlayer.menu != MENU.JEWELLERY
	eventPlayer.stopForcingPosition()
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
	eventPlayer.enableEnvironmentCollision()