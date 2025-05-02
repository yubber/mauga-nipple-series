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

#!define PLAYERFXLIMIT 23

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
playervar jewelleryFacings = []
playervar demoJewellery

playervar likedPlayers = []

enum MENU:
	OFF,
	SIDE,
	ETHNICITY,
	PERSONALITY,
	JEWELLERY

#!include "menu.opy"

rule "global init":
    hudSubtext(getAllPlayers(), "{}:{}{}:{}{}\ngame may end suddenly after 4:30:00\n".format(floor(getTotalTimeElapsed()/3600) if getTotalTimeElapsed() > 3600 else "00", 0 if getTotalTimeElapsed()/60 % 60 < 10 else l"", floor(getTotalTimeElapsed() / 60 % 60), 0 if getTotalTimeElapsed() % 60 < 10 else l"", floor(getTotalTimeElapsed() % 60)), HudPosition.RIGHT, -0.1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), "[{}] - open menu".format(buttonToString(Button.INTERACT)), HudPosition.LEFT, -0.1, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), "[{}] - like player".format(buttonToString(Button.MELEE)), HudPosition.LEFT, -0.1, Color.ROSE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

	# jewellery
	createInWorldText(localPlayer if localPlayer.menu == MENU.JEWELLERY else null, "\&white_circle;", localPlayer.jewelleryPos[localPlayer.opt], 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)

	if isGameInProgress() == false:
		setMatchTime(1)
	waitUntil(isGameInProgress(), 99)
	setMatchTime(4*60+20)
	pauseMatchTime()

rule "player init":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned()
	eventPlayer.startForcingHero(Hero.MAUGA)
	eventPlayer.disableEnvironmentCollision(false)
	wait(0.16)
	eventPlayer.disableGamemodeHud()
	eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
	eventPlayer.startScalingSize(20, false)

rule "interact to open/close menu":
	@Event eachPlayer
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
	if eventPlayer.menu == MENU.OFF:
		eventPlayer.menu = MENU.ETHNICITY
	else:
		eventPlayer.menu = MENU.OFF

rule "a/d":
	@Event eachPlayer
	@Condition eventPlayer.menu != MENU.OFF
	# switch (eventPlayer.menu):
	# 	case MENU.

rule "pen size+":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY
	@Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
	if eventPlayer.penSize >= 20:
		smallMessage(eventPlayer, "that's big enough! your n!pples will droop under that weight!")
		return
	else:
		eventPlayer.penSize++
	wait(0.16, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		loop()

rule "pen size-":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY
	@Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
	if eventPlayer.penSize <= 0:
		smallMessage(eventPlayer, "what's the point of wearing that if it's so small nobody will see it?")
		return
	else:
		eventPlayer.penSize--
	wait(0.16, Wait.ABORT_WHEN_FALSE)
	if ruleCondition:
		loop()



rule "cycle fx":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY
	destroyEffect(eventPlayer.demoJewellery)

rule "get targeted jewellery":
	@Event eachPlayer
	@Condition eventPlayer.menu == MENU.JEWELLERY

# menu
rule "scroll down":
	@Event eachPlayer
	@Condition eventPlayer.menu != MENU.OFF
	@Condition eventPlayer.menu != MENU.JEWELLERY
	@Condition eventPlayer

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