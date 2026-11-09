// let [vars, wrapTranslate, arr] = [["boonNames","boonScores","boonIcons","boonDescs"], [true, false, false, true], [
// 		["explorer's boots", 1, "iconString(Icon.BOLT)", "+10% movespeed"],
// 		["leg day", 1, "iconString(Icon.ARROW_UP)", "+20% jump height"],
// 		[("strong bones"), 1, "<tx0C00000000061B05>", "+15% max health"],
// 		[("milk excavator"), 1, "abilityIconString(Hero.VENTURE, Button.MELEE)", "+15% milk gained"],
// 		[("mozzarellazarus"), 6, "<tx0C000000000012F4>", "respawn after 30s, but total hp is halved.\nyou lose if everyone is dead at the same time.\nrespawn timer ticks 20% faster per stack."],
// 		[("overtime"), 4, "<tx0C0000000001935F>", "+20s to each round, +30 milk per round."],
// 		[("time off"), 6, "<tx0C0000000004F73C>", "rounds are 20% shorter."],
// 	]]

// vars, wrapTranslate, arr

let output = ""

vars.forEach((v, i) => {
    // console.log("Var", v, i)
	output += `globalvar ${v} = [` + arr.map( e => {
		return wrapTranslate[i] ? `___(\"${e[i]}\")` : e[i].toString()
	}) + "]\n"
})

// console.log(output)
output