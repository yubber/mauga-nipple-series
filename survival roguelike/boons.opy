#!mainFile "main.opy"

globalvar boonIcons
globalvar boonScores
globalvar boonNames
globalvar boonDescs
globalvar boonStacks

enum BOONS:
	SPEED,
	JUMP,
	HP,
	MILK,
	REZ,
	OVERTIME,
	TIME_OFF

macro SpeedFormula = 100 + boonStacks[BOONS.SPEED] * 15
macro JumpFormula = 100 + boonStacks[BOONS.JUMP] * 20
macro HealthFormula = (100 + boonStacks[BOONS.HP] * 10) * (0.5 if boonStacks[BOONS.REZ] else 1)

def applyStatBoons():
	getPlayers(Team.1).setMaxHealth(HealthFormula)
	getPlayers(Team.1).setMoveSpeed(SpeedFormula)
	getPlayers(Team.1).setJumpVerticalSpeed(JumpFormula)

rule "boon info":
	tabular([boonNames,boonScores,boonIcons,boonDescs], [
		"explorer's boots", 1, iconString(Icon.BOLT), "+10% movespeed",
		"leg day", 1, iconString(Icon.ARROW_UP), "+20% jump height",
		"strong bones", 1, abilityIconString(Hero.MAUGA, Button.ABILITY_2), "+15% max health",
		"milk excavator", 1, abilityIconString(Hero.VENTURE, Button.MELEE), "+15% milk gained",
		"mozzarellazarus", 6, iconString(Icon.SKULL), "respawn after 30s, but total hp is halved. you lose if everyone is dead at the same time.\nrespawn timer ticks 20% faster per stack.",
		"overtime", 4, "\&black_phone;", "+20s to each round, +60 milk per round.",
		"time off", 6, iconString(Icon.RECYCLE), "rounds are 20% shorter."
	])