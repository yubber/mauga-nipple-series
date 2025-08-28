settings {
    "main": {
        "description": "measure where to put stuff on mauga's n!pples\nplay mauga n!pple pve at DS2MD\n\nyubz made it",
        "modeName": "mauga n!pple measurement"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "spectatorSlots": 5,
        "team1Slots": 1,
        "team2Slots": 0,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                "workshopIslandNight"
            ]
        }
    },
    "heroes": {
        "allTeams": {
            "mercy": {
                "ability2Cooldown%": 0
            },
            "general": {
                "abilityCooldown%": 0,
            }
        },
    }
}

#!define NipmanForcePosConst vect(0,-17-2.8,35)
#!define NipmanLeftConst vect(2.93, 10.84-2.8, 26.15)
#!define NipmanRightConst vect(-7.19, 10.8-2.8, 30.27)

#!extension explosionSounds

playervar values
playervar i
playervar option
playervar mode
playervar setterVar
playervar valueCache
playervar state
playervar fineMult

enum STATE:
    SET_VAL,
    CHOOSE_VAL

globalvar nipman
globalvar nipbots

enum VARS:
    NIPBOTS_SCALE,
    NIPBOTS_OFFSET,
    NIPBOTS_FACING

enum TYPES:
    SCALAR=0,
    POSITION,
    DIRECTION,
    HERO

globalvar types = [TYPES.SCALAR, TYPES.POSITION, TYPES.DIRECTION]
globalvar varNames = ["nipbots scale", "nipbots offset (world vect)", "nipbots facing (world vect)"]
globalvar defaults = [1, vect(0,0,0), Vector.BACKWARD, Hero.ECHO]

rule "refr valk":
	@Event eachPlayer
	@Hero mercy
    @Condition eventPlayer.hasSpawned()
	@Condition not eventPlayer.isUsingUltimate()
	eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
	eventPlayer.setUltCharge(100)
	eventPlayer.forceButtonPress(Button.ULTIMATE)
	wait(0.4)
	eventPlayer.setStatusEffect(null, Status.HACKED, 0.05)
	if ruleCondition:
		goto RULE_START

rule "global init + custom nipbots behavior":
    wait(1.2)
    createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.BACKWARD)
    nipman = getLastCreatedEntity()
    hudHeader(getAllPlayers(), f"{buttonToString(Button.PRIMARY_FIRE)} modify this value", HudPosition.ACTUALLY_LEFT, 0, Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), f"{buttonToString(Button.SECONDARY_FIRE)} toggle selecting another value", HudPosition.ACTUALLY_LEFT, 0, Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), f"{buttonToString(Button.INTERACT)} cycle fineness", HudPosition.ACTUALLY_LEFT, 0, Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), fb"{varNames[localPlayer.option]}: {localPlayer.values[localPlayer.option]}", HudPosition.TOP, nipman.i, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING)
    for nipman.i in range(len(types)):
        # value preview
        hudSubtext(getAllPlayers(), f"{evalOnce(varNames[nipman.i])}: {localPlayer.values[evalOnce(nipman.i)]}", HudPosition.ACTUALLY_LEFT, nipman.i, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING)
        # selector

    createDummy(Hero.VENTURE, Team.2, -1, Vector.UP, Vector.FORWARD)
    nipbots = [getLastCreatedEntity()]
    createDummy(Hero.VENTURE, Team.2, -1, Vector.UP, Vector.FORWARD)
    nipbots.append(getLastCreatedEntity())

    wait(1.2)
    nipman.startForcingPosition(NipmanForcePosConst, false)
    nipman.disablePlayerCollision()
    nipman.disableEnvironmentCollision(true)
    nipman.startScalingSize(20, false)
    nipbots.disablePlayerCollision()
    nipbots.disableEnvironmentCollision(true)
    nipbots[0].startForcingPosition(hostPlayer.values[VARS.NIPBOTS_OFFSET] + NipmanLeftConst)
    nipbots.last().startForcingPosition(hostPlayer.values[VARS.NIPBOTS_OFFSET] + NipmanRightConst)
    nipbots.startScalingSize(hostPlayer.values[VARS.NIPBOTS_SCALE], true)
    nipbots.startFacing(hostPlayer.values[VARS.NIPBOTS_FACING], Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

    # custom behavior
    while true:
		wait(0.288)
		getPlayersOnHero(Hero.VENTURE).forceButtonPress(Button.SECONDARY_FIRE)

rule "init player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isDummy() == false
    eventPlayer.values = []
    eventPlayer.option = 0
    eventPlayer.fineMult = 1
    for eventPlayer.i in range(len(types)):
        eventPlayer.values.append(
            defaults[types[eventPlayer.i]]
        )
        wait()

rule "mod value":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    eventPlayer.valueCache = eventPlayer.values[eventPlayer.option]
    playEffect(eventPlayer, DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR_SOUND, Color.TEAM_1, eventPlayer, 30)
    switch types[eventPlayer.option]:
        case TYPES.SCALAR:
            smallMessage(eventPlayer, "look up and down to change.")
            eventPlayer.setterVar = eventPlayer.getVerticalFacingAngle()
            while eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
                eventPlayer.values[eventPlayer.option] = eventPlayer.valueCache + (eventPlayer.getVerticalFacingAngle() - eventPlayer.setterVar) * eventPlayer.fineMult
                wait(0.096)
            break
        case TYPES.POSITION:
            smallMessage(eventPlayer, "move to change.")
            eventPlayer.setterVar = eventPlayer.getPosition()
            eventPlayer.setMoveSpeed(50 + 50 * eventPlayer.fineMult)
            while eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
                eventPlayer.values[eventPlayer.option] = eventPlayer.valueCache + (eventPlayer.getPosition() - eventPlayer.setterVar)
                wait(0.096)
            eventPlayer.setMoveSpeed(100)
            break
        case TYPES.DIRECTION:
            smallMessage(eventPlayer, "turn to change.")
            eventPlayer.setAimSpeed(50 + 50 * eventPlayer.fineMult)
            eventPlayer.setterVar = eventPlayer.getFacingDirection()
            while eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
                eventPlayer.values[eventPlayer.option] = eventPlayer.valueCache + (eventPlayer.getFacingDirection() - eventPlayer.setterVar)
                wait(0.096)
            eventPlayer.setAimSpeed(100)
            break
        case TYPES.HERO:
            eventPlayer.setterVar = eventPlayer.getHero()
            eventPlayer.setAllowedHeroes(Hero.ANA if eventPlayer.getHero() == Hero.ORISA else Hero.ORISA)
            wait()
            eventPlayer.setAllowedHeroes(getAllHeroes())
            waitUntil(eventPlayer.getHero() != null, 99999)
            eventPlayer.values[eventPlayer.option] = eventPlayer.setterVar
            eventPlayer.startForcingHero(eventPlayer.setterVar)
            eventPlayer.stopForcingCurrentHero()
            break

rule "cycle fine mult":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    playEffect(eventPlayer, DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE_SOUND, Color.TEAM_1, eventPlayer, 30)
    eventPlayer.fineMult *= 10
    if eventPlayer.fineMult > 10:
        eventPlayer.fineMult = 0.01
    smallMessage(eventPlayer, f"fineness {eventPlayer.fineMult}")

rule "reselect on":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    playEffect(eventPlayer, DynamicEffect.SOMBRA_LOGO_SOUND, Color.TEAM_1, eventPlayer, 30)
    smallMessage(eventPlayer, "changing active value.")
    eventPlayer.setMoveSpeed(0.01)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false, 99999)
    eventPlayer.setMoveSpeed(100)
