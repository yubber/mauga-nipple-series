#!mainFile "main.opy"

globalvar boonIcons
globalvar boonScores
globalvar boonNames
globalvar boonDescs
playervar boonStacks

macro boonCost(id):
	boonScores[id] * 15

enum BOONS:
	SPEED,
	JUMP,
	HP,
	MILK,
	REZ,
	OVERTIME,
	TIME_OFF # LAST

macro SpeedFormula(player):
	100 + player.boonStacks[BOONS.SPEED] * 15
macro JumpFormula(player):
	100 + player.boonStacks[BOONS.JUMP] * 20
macro HealthFormula(player):
	(100 + player.boonStacks[BOONS.HP] * 10) * (0.5 if player.boonStacks[BOONS.REZ] else 1)

def applyStatBoons():
	eventPlayer.setMaxHealth(HealthFormula(eventPlayer))
	eventPlayer.setMoveSpeed(SpeedFormula(eventPlayer))
	eventPlayer.setJumpVerticalSpeed(JumpFormula(eventPlayer))

macro getBoonRoundReq(b):
	boonScores[b] + 3

rule "boon info":
	tabular([boonNames,boonScores,boonIcons,boonDescs], [
		"explorer's boots", 1, iconString(Icon.BOLT), "+10% movespeed",
		"leg day", 1, iconString(Icon.ARROW_UP), "+20% jump height",
		"strong bones", 1, iconString(Icon.PLUS), "+15% max health",
		"milk excavator", 1, abilityIconString(Hero.VENTURE, Button.MELEE), "+15% milk gained",
		"mozzarellazarus", 6, iconString(Icon.SKULL), "respawn after 30s, but total hp is halved. you lose if everyone is dead at the same time.\nrespawn timer ticks 20% faster per stack.",
		"overtime", 4, "\&black_phone;", "+20s to each round, +60 milk per round.",
		"time off", 6, iconString(Icon.RECYCLE), "rounds are 20% shorter."
	])