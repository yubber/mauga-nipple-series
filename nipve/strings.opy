#!mainFile "pvnip.opy"

# #!translateWithPlayerVar
# this var is still used for the server side translation (nipman.__languageIndex__)
playervar __languageIndex__
globalvar nipman
globalvar bracket
#!define serverSideTranslate(x) x[nipman.__languageIndex__]

rule "want to contribute a translation? please visit https://github.com/yubber/mauga-nipple-series/, it's easier to make translations for the overpy source file.":
	@Delimiter

rule "strings":

### TRANSLATORS' SECTION
# refer to README.MD for a guide.
# general pointers:
# - please only edit stuff inside quotation marks. if you add double quote " characters they must be escaped, like: \"
# - to avoid censors, you can use zero-width spaces "​". cyrillic characters also work for the latin script, but they will cause the font to change.

# ! add language code here, and the translation workshop uses for white. maintain the same order!
#!translations en ko zh_CN
#!define LANG_LIST ["White", "흰색", ""]

# the mode name and description are in settings -> main, at the very top of pvnip.opy.
# since the code is shared across all languages, just add a credit to yourself for translating at the bottom.

# these are names for the dummy bots used in threats, e.g. overheating glands (torbjorn), slenderman
# since they're in bot names i can't use the translation features
# ! add translated names here, in the same format and following the order of the language codes
enum BOTNAME:
	SLENDY = serverSideTranslate(["slenderman", "슬렌더맨", "瘦长鬼影"])
	TORBS = serverSideTranslate(["overheating glands", "과열된 돌출부"])
	SNIPERS = serverSideTranslate(["s-nip-ers", "젖-격수", "狙挤手"])
	NIPLETS = serverSideTranslate(["niplets", "젖먹이", "贝乳塔"])
	ILLARIS = serverSideTranslate(["sunkissed nips", "아침에젖스", ""])
	TOEPPLES = serverSideTranslate(["toepples", "발꼭지"])
	DRAGONIPS = serverSideTranslate(["dragoniррles", "용의 일겨헉♥", "奶龙"])
	WEAK_SPOT = serverSideTranslate(["sensitive spot", "약점♥", "过敏部位"])
	MAUGA_JR = serverSideTranslate(["mauga jr.", "마우가 JR.", "小毛加"])
	MINIBOSS = serverSideTranslate(["miniboss", "미니보스", "大怪物"])

# these are descriptions for custom settings.
# gameplay category of settings
#!define SETTING_GAMEPLAY "gameplay | 게임플레이"
#!define SETTING_PLAYERSCALE "increase player damage per missing player | 없는 플레이어당 주는 대미지 증가"
#!define SETTING_DIFFICULTY "difficulty | 난이도"
#!define SETTING_HARDCORE "respawn players only when round ends | 라운드가 끝난 이후에만 리스폰"
enum SETTING_RESPAWN:
	NAME = "player respawning | 玩家重生",
	ALWAYS = "always | 正常",
	ROUND_END = "only when round ends! | 回合完毕后",
	NEVER = "never!!! | 不重生"

### !!! END. the following strings are already translated in the .po file.
# thank you for translating!

# please preserve the order of these lists.
globalvar objDescs = [___("collect pages"), ___("defeat the mini maugas"), ___("slay enemies"), ___("slay the miniboss"), ___("capture the point")] # keep point as last
globalvar threatNames = [___("slenderman"), ___("more maugas"), ___("frosty nips"), /*"the third nipact",*/ ___("dragon stimulation"), ___("toepples"), ___("grabbyteats"), ___("niplets"), ___("cup fight"), ___("tiddy twister"), ___("lactic hail"), ___("n!pple nuke"), ___("dairy deaths"), ___("milk wall"), ___("mega milk"), ___("scalding discharge"), ___("s-nip-ers"), ___("boobsted mobs"), ___("booblet hell"), ___("gravitatas"), ___("sun exposure"), ___("lazer")]

#!suppressWarnings w_enum_constant
# these are references to strings in other parts of the program. i've moved them here for your convenience.
# if you would like context for where these strings are used, you can CTRL+F the enum key.
enum STRINGS:
	OBJCOUNTDOWN = t"next objective in 3 seconds!"
	ROUNDSTART = t"round start!"
	MAUGAVULNERABLE = t"objective complete! mauga is vulnerable!"
	# leave the {} there. these are for warning icons.
	MAUGASCHARGING = t"{0} deadly attack incoming! attack the sensitive spots! {0}"
	MAUGASFAILED = t"{} failed to stop the attack. brace for impact!"
	# here, {} is the player who found the page. this is for the slenderman objective.
	PAGEFOUND = t" {} found a page!"
	ALLDEAD = t"game over. all players died."
	# this string is for players that try to hook/charge the mauga. write whatever's funniest in the target language.
	CHIDING = t"do not the mauga"
	# if you are translating the petrified text, delete the next line and use the line after it instead. also get rid of the "# " at the start.
	PETRIFIED = t"{} petrified! {} {} {}".format(iconString(Icon.EYE), l"Avoid", l"Facing", Hero.SIGMA)
	# PETRIFIED = t"petrified! avoid facing sigma.".format(iconString(Icon.EYE))
	# {} is mauga's icon
	DRAGONTRIGGER = t"{} heehee, stop tickling me! dragon lactation initation!"
	PAGEGUNS = t"remember to check inside mauga's guns for the pages."
	GRABBED = t"{} you were grabbed!"
	MAUGA_GONE = t"something went wrong. skipping phase..."
	TIMEOUT = t"timeout exceeded, skipping phase in case of softlock."
	HC = t"hardcore mode is on"
	UHC = t"ultra hardcore mode is on"
	HCDESC = t"no respawning until round ends"
	UHCDESC = t"no respawning ever!"
	# total deaths in the team.
	TEAMDEATHS = t"team deaths"
	ROUNDS = t"rounds elapsed"
	TIME = t"time elapsed"
	# \n is a newline, because text doesn't wrap automatically i think
	SPECTATORS = __("spectators, please turn off team 1 & 2 heroes\nand game mode hud in spectator options\n(press b)")
	# supposed to show the korean flag but no worky
	KR_MODE = (t"\n{}TX 000000009D14> 한국어: K08WD".format(bracket))
	IMPORT_CODE = t"use code DS2MD for the latest version"
	LOAD_1 = t"peak: {} | average: {}"
	LOAD_2 = t"server load: {}\n"