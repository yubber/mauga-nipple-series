#!mainFile "main.opy"

globalvar heroTweakHero
globalvar heroTweakDesc

playervar heroTweakVar

rule "hero tweak text":
	tabular([heroTweakHero, heroTweakDesc], [
		Hero.TRACER, "pulse bomb resets everyone's cooldowns\n(if it's not bugged in workshop, like abilities with charges...)",
		Hero.CASSIDY, "invulnerable during ult. can still be stunned out of it.",
		Hero.ASHE, "dynamite is slower and has no gravity. levitate while burning.",
		Hero.DOMINA, "your ult grants a barrier to allies in its path.",
		# non ws
		Hero.SYMMETRA, "support your team with teleporters and farming your ult.",
		Hero.TORBJORN, "overload instead grants a short burst of overhealth.",
		Hero.HANZO, "refresh dashes with the sharpshooter perk."
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

rule "ashe burn":
	@Event playerDealtDamage
	@Team 1
	@Condition eventPlayer == victim
	@Condition eventPlayer.getHero() == Hero.ASHE or eventPlayer.getHeroOfDuplication() == Hero.ASHE
	@Condition eventPlayer.hasStatus(Status.BURNING)
	eventPlayer.applyImpulse(Vector.UP, 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)

rule "high noon":
	@Event eachPlayer
	@Condition eventPlayer.getHero() == Hero.CASSIDY or eventPlayer.getHeroOfDuplication() == Hero.CASSIDY
	@Condition eventPlayer.isUsingUltimate()
	eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9)
	waitUntil(eventPlayer.isUsingUltimate() == false, 9)
	eventPlayer.clearStatusEffect(Status.INVINCIBLE)

rule "domina ult":
	@Event eachPlayer
	@Condition eventPlayer.getHero() == Hero.DOMINA or eventPlayer.getHeroOfDuplication() == Hero.DOMINA
	@Condition eventPlayer.isUsingUltimate()
	eventPlayer.setProjectileSpeed(300)
	wait(0.48, Wait.ABORT_WHEN_FALSE)
	eventPlayer.getRealPlayersInViewAngle(Team.1, 20).concat(eventPlayer).addHealthPool(Health.NORMAL, 100, false, false)
	eventPlayer.setProjectileSpeed(100)