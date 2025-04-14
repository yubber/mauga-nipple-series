settings {
    "main": {
        "description": "find locations on mauga's body using image hints\n\nmauga n!pple franchise:\nDS2MD - mauga n!pple pve\nW5PMC - where is it?\n\nyubz made it",
        "modeName": "mauga n!pple: where is it?"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "team1Slots": 12,
        "team2Slots": 0
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                "workshopIsland"
            ]
        },
        "general": {
            "heroLimit": "off",
            "respawnTime%": 50
        }
    },
    "heroes": {
        "allTeams": {
            "echo": {
                "enableAbility2": false,
                "enablePrimaryFire": false,
                "enableSecondaryFire": false,
                "enableUlt": false
            },
            "illari": {
                "enableAbility2": false,
                "enableAbility1": false
            },
            "mercy": {
                "enablePrimaryFire": false,
                "enableSecondaryFire": false
            },
            "pharah": {
                "enableAbility2": false,
                "passiveExtraFuel%": 200,
                "passiveMaxTime%": 500,
                "passiveRechargeRate%": 500,
                "enablePassiveUnlimitedFuel": true,
                "ability1RefuelScalar": 400,
                "enablePrimaryFire": false,
                "enableUlt": false
            },
            "enabledHeroes": [
                "echo",
                "mercy",
                "pharah"
            ],
            "general": {
                "abilityCooldown%": 0,
                "enableInfiniteUlt": true,
                "movementSpeed%": 120,
                "projectileGravity%": 0,
                "projectileSpeed%": 0,
                "enableSpawningWithUlt": true,
                "ultDuration%": 500
            }
        }
    }
}

globalvar encouragement = ["well done!", "great job!", "good find!", "you've got big natur- uh, i mean, you're a natural at this!", "fantastic!", "nice one!", "nice work!", "you're an expert! shame on you.", "nicely done!"]

# local vects
globalvar lookPos = [vect(-2.034, 22.301, 7.07), vect(7.72, 12.82, -4.366), vect(-1.405, 8.882, -1.408), vect(2.265, 25.24, -3.346), vect(0.96, 29.915, 5.118), vect(-0.469, 28.585, 4.125), vect(13.242, 15.29, -5.138), vect(8.203, -1.411, -4.315), vect(-4.627, 16.877, 6.78), vect(-3.044, 18.226, 7.371), vect(0.881, 29.751, 5.683), vect(10.469, 18.861, 6.761), vect(-11.224, 14.177, 24.506), vect(-13.377, 4.476, 9.291), vect(-0.689, 23.871, 6.316), vect(0.397, 27.826, 4.537), vect(-9.863, 20.899, -0.238), vect(-4.437, 18.929, -6.933), vect(-1.203, 10.436, 6.131), vect(-9.911, 12.051, 4.636), vect(-7.946, 2.25, 8.466), vect(-1.66, 25.119, 7.356), vect(15.872, 13.792, 4.209), vect(3.429, 26.978, 2.57), vect(-4.831, 6.717, 3.688), vect(-11.155, 13.464, 2.869), vect(-3.297, 20.469, 6.562), vect(2.242, 18.879, 6.267), vect(0.374, 28.004, 6.373), vect(5.487, 22.13, 4.013)]
globalvar camPos = [vect(-2.62, 21.92, 8.45), vect(8.488, 12.655, -4.984), vect(-1.548, 7.928, -1.67), vect(2.121, 25.862, -4.115), vect(1.7, 29.917, 5.791), vect(-1.405, 28.931, 4.074), vect(13.25, 15.489, -4.158), vect(8.063, -2.395, -4.204), vect(-5.157, 16.972, 7.623), vect(-2.828, 19.126, 7.749), vect(0.878, 28.763, 5.531), vect(11.407, 19.123, 6.985), vect(-11.103, 14.158, 25.498), vect(-13.345, 3.509, 9.54), vect(-0.627, 23.19, 5.586), vect(0.019, 28.75, 4.597), vect(-10.292, 20.84, -1.14), vect(-4.738, 19.711, -7.479), vect(-0.24, 10.313, 6.373), vect(-10.173, 11.958, 3.676), vect(-8.385, 3.148, 8.45), vect(-1.804, 25.889, 7.978), vect(16.868, 13.73, 4.264), vect(3.738, 27.847, 2.957), vect(-4.578, 6.286, 2.821), vect(-10.428, 13.374, 2.188), vect(-3.763, 20.414, 7.445), vect(2.698, 18.743, 7.146), vect(0.336, 28.226, 5.398), vect(6.93, 21.753, 5.1)]

globalvar mauga
globalvar killBot

playervar stage
playervar fails
playervar joinedTime

#!extension spawnMoreDummyBots

rule "(re)make mauga":
	@Condition not entityExists(mauga)
	wait(1, Wait.ABORT_WHEN_FALSE)
	destroyAllDummies()
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
	wait()
	mauga = getLastCreatedEntity()
	mauga.setStatusEffect(null, Status.INVINCIBLE, 9999) # phased out cancels frozen
	mauga.disablePlayerCollision()

	wait()
	createDummy(Hero.MAUGA, Team.2, -1, Vector.UP, Vector.FORWARD)
	killBot = getLastCreatedEntity()
	killBot.setInvisibility(Invis.ALL)
	killBot.startForcingPosition(Vector.UP * 690, false)

	wait(1)
	mauga.setStatusEffect(null, Status.FROZEN, 9999)
	mauga.startScalingSize(16, false)
	mauga.startForcingPosition(Vector.UP * 5, false)

rule "init":
	hudText(localPlayer, abilityIconString(Hero.TORBJORN, Button.ABILITY_2), "controls", "[{}] - view body part location\n[{}] - check current position".format(buttonString(Button.SECONDARY_FIRE), buttonString(Button.MELEE)), HudPosition.LEFT, 0, Color.SKY_BLUE, Color.SKY_BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

	# hudText(localPlayer, abilityIconString(Hero.SOMBRA, Button.ABILITY_2), "local vector to bot", localVector(localPlayer.getEyePosition(), mauga, Transform.ROTATION_AND_TRANSLATION), HudPosition.LEFT, 0, Color.VIOLET, Color.VIOLET, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

	# createBeam(hostPlayer if hostPlayer.isHoldingButton(Button.PRIMARY_FIRE) else [], Beam.GOOD, hostPlayer, worldVector(camPos[hostPlayer.stage], mauga, Transform.ROTATION_AND_TRANSLATION), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
	wait(1)
	pauseMatchTime()

rule "player init":
	@Event eachPlayer
	@Condition not eventPlayer.isDummy()
	@Condition eventPlayer.hasSpawned()

	if "{}".format(eventPlayer) == "OMGIDIED":
		hudText(localPlayer, iconString(Icon.EYE), "eye position", localPlayer.getEyePosition(), HudPosition.LEFT, 0, Color.SKY_BLUE, Color.SKY_BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
		# hudText(localPlayer, abilityIconString(Hero.HAMMOND, Button.CROUCH), "player position", localPlayer.getPosition(), HudPosition.LEFT, 0, Color.LIME_GREEN, Color.LIME_GREEN, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
		hudText(localPlayer, abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), "looking at", localPlayer.getEyePosition() + localPlayer.getFacingDirection(), HudPosition.LEFT, 0, Color.RED, Color.RED, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

	progressBarHud(eventPlayer, eventPlayer.stage / len(camPos) * 100, "found {} / {} body parts".format(eventPlayer.stage, len(camPos)), HudPosition.TOP, null, Color.ORANGE, Color.WHITE, ProgressHudReeval.VALUES, SpecVisibility.DEFAULT)
	eventPlayer.stage = 0
	eventPlayer.fails = 0

	wait()
	# eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
	eventPlayer.joinedTime = getTotalTimeElapsed()
	mauga.startForcingOutlineFor(getAllPlayers(), false, Color.WHITE, OutlineVisibility.DEFAULT)
	eventPlayer.startForcingOutlineFor(getAllPlayers(), false, Color.WHITE, OutlineVisibility.DEFAULT)
	eventPlayer.disableGamemodeHud()
	eventPlayer.disableKillFeed()
	eventPlayer.disableMessages()

	waitUntil(eventPlayer.getThrottle() != vect(0,0,0), 9999)

	eventPlayer.startCamera(worldVector(camPos[0], mauga, Transform.ROTATION_AND_TRANSLATION), worldVector(lookPos[0], mauga, Transform.ROTATION_AND_TRANSLATION), 90)
	bigMessage(eventPlayer, "find this part of mauga's body!")
	wait(3.5)
	eventPlayer.stopCamera()
	smallMessage(eventPlayer, "hold [{}] secondary fire to view body part".format(buttonString(Button.SECONDARY_FIRE)))

	waitUntil(distance(eventPlayer, worldVector(camPos[0], mauga, Transform.ROTATION_AND_TRANSLATION)) < 2, 9999)

	playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.ROSE, worldVector(camPos[0], mauga, Transform.ROTATION_AND_TRANSLATION), 1)
	playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.ROSE, worldVector(camPos[0], mauga, Transform.ROTATION_AND_TRANSLATION), 1)
	smallMessage(eventPlayer, "good job! stay close to the n!pple and press [{}] melee!".format(buttonString(Button.MELEE)))

	waitUntil(eventPlayer.stage > 0, 9999)
	wait(1.2)
	smallMessage(eventPlayer, "now find the next body part! hold [{}] secondary fire to view it.".format(buttonString(Button.SECONDARY_FIRE)))

rule "remind ya i'm kinda":
	while true:
		smallMessage(getAllPlayers(), "if you found the part but can't progress, try moving closer or checking mauga's other side.")
		wait(120)

rule "toggle view":
	@Event eachPlayer
	@Condition eventPlayer.stage < len(lookPos)
	@Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
	eventPlayer.startCamera(worldVector(camPos[eventPlayer.stage], mauga, Transform.ROTATION_AND_TRANSLATION), worldVector(lookPos[eventPlayer.stage], mauga, Transform.ROTATION_AND_TRANSLATION), 0)
	waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 300)
	eventPlayer.stopCamera()

rule "debug add item":
	@Disabled
	@Condition hostPlayer.isHoldingButton(Button.RELOAD)
	camPos.append(localVector(hostPlayer.getEyePosition(), mauga, Transform.ROTATION_AND_TRANSLATION))
	lookPos.append(localVector(hostPlayer.getEyePosition() + hostPlayer.getFacingDirection(), mauga, Transform.ROTATION_AND_TRANSLATION))

rule "debug change position":
	@Disabled
	@Condition hostPlayer.isHoldingButton(Button.ABILITY_2)
	@Condition "{}".format(hostPlayer) == "OMGIDIED"
	camPos[hostPlayer.stage] = (localVector(hostPlayer.getEyePosition(), mauga, Transform.ROTATION_AND_TRANSLATION))
	lookPos[hostPlayer.stage] = (localVector(hostPlayer.getEyePosition() + hostPlayer.getFacingDirection(), mauga, Transform.ROTATION_AND_TRANSLATION))
	smallMessage(hostPlayer, localVector(hostPlayer.getEyePosition(), mauga, Transform.ROTATION_AND_TRANSLATION))
	smallMessage(hostPlayer, hostPlayer.stage)

rule "get":
	@Event eachPlayer
	@Condition eventPlayer.isHoldingButton(Button.MELEE)
	@Condition not eventPlayer.hasStatusEffect(Status.STUNNED)
	@Condition eventPlayer.stage < len(lookPos)
	if distance(eventPlayer.getEyePosition(), worldVector(camPos[eventPlayer.stage], mauga, Transform.ROTATION_AND_TRANSLATION)) < 2.8:
		kill(killBot, eventPlayer)
		killBot.resurrect()
		smallMessage(eventPlayer, random.choice(encouragement))
		eventPlayer.stage += 1
		# win
		if eventPlayer.stage >= len(lookPos):
			bigMessage(getAllPlayers(), "{} {} finished in {}s with {}% accuracy!".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer, getTotalTimeElapsed() - eventPlayer.joinedTime, 100 * len(lookPos) / (len(lookPos) + eventPlayer.fails)))
			createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.TEAM_1, eventPlayer, true, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
			hudText(getAllPlayers(), heroIcon(eventPlayer.getCurrentHero()), "{}s | {}% accuracy".format(getTotalTimeElapsed() - eventPlayer.joinedTime, 100 * len(lookPos) / (len(lookPos) + eventPlayer.fails)), "{}".format(eventPlayer), HudPosition.RIGHT, getTotalTimeElapsed() - eventPlayer.joinedTime, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY)
	else:
		eventPlayer.setStatusEffect(mauga, Status.STUNNED, 0.25)
		smallMessage(eventPlayer, " body part not found")
		eventPlayer.fails += 1

rule "fly":
	@Event eachPlayer
	@Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
	eventPlayer.setUltCharge(100)
