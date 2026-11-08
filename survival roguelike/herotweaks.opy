#!mainFile "main.opy"

globalvar heroTweakHero
globalvar heroTweakDesc

rule "hero tweak text":
	tabular([heroTweakHero, heroTweakDesc], [
		Hero.TRACER, "pulse bomb resets everyone's cooldowns (if it's not bugged in workshop, like abilities with charges...)",
		Hero.CASSIDY, "invulnerable during ult. can still be stunned out of it.",
		Hero.ASHE, "dynamite is slower and has no gravity. levitate while burning.",
		Hero.DOMINA, "your ult grants a barrier to allies ahead of you.",
		# non ws
		Hero.SYMMETRA, "support your team with teleporters and farming your ult.",
		Hero.TORBJORN, "overload instead grants a short burst of overhealth.",
		Hero.HANZO, "dash around with the sharpshooter perk."
	])

rule "tracer ult":
	@Event eachPlayer
	@Team 1
	@Condition eventPlayer.isUsingUltimate()
	@Condition eventPlayer.getHero() == Hero.TRACER or eventPlayer.getHeroOfDuplication() == Hero.TRACER
	getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_1, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_2, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.SECONDARY_FIRE, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.CROUCH, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.JUMP, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.RELOAD, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.MELEE, 0)
	getPlayers(Team.1).setAbilityCooldown(Button.INTERACT, 0)

