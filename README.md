overpy source code for mauga nipple game modes for the overwatch workshop
https://workshop.codes/u/_yubz

## mauga nipple pve
[DS2MD](https://workshop.codes/DS2MD) **(currently taken down, please see below)**

## mauga nipple: where is it?
[W5PMC](https://workshop.codes/W5PMC)

# notice on takedown

my account has been temp banned for naughty custom content. in the meantime, you can copy the contents of [export.txt](https://github.com/yubber/mauga-nipple-series/blob/main/nipve/export.txt) to paste it into your lobby as a workshop script.

feel free to share it under a new code until i'm unbanned. when the time comes, please endorse me (`OMGIDIED`) if you ever see me in a match, so i can get the mode up and running again <3

if you're interested in any of my other modes you can just compile the overpy (on my github/workshop.codes) and paste in the resulting code, or contact me on discord.

# contributing

## translations

**mauga nipple pve**: please edit [strings.opy](https://github.com/yubber/mauga-nipple-series/blob/main/nipve/strings.opy) and create a `.po` file.

there are 2 files to create translations for.

- `strings.opy`

- create a `.po` file

### strings.opy

all text that needs translation is near the top. no need to go digging around for strings.

you will need to link the .po file if you want to compile the code yourself. or you can just send me the files and i'll handle everything from there.

to do this, add a [language code](https://github.com/Zezombye/overpy#translations) to the line `#!translations en ko`

there are some strings that must be translated in `strings.opy` itself. i've marked them at the top.

### .po file

you can copy and rename an existing `.po` file for a template. replace the XX in `pvnip.XX.po` with the matching [language code](https://github.com/Zezombye/overpy#translations). it should hopefully be obvious from there.

### compiling

if you don't want to bother with this, you can send me your edited files. i'll credit you in the mode description and the workshop.codes page.

that would be the better option so that your translation will be updated as soon as i update mauga nipple pve.

the code in this repository is **not** workshop code. it has to be compiled, and you need to download and configure the tools for that.

1. install visual studio **code** and the overpy extension.

2. open the extensions menu, then open overpy's settings

3. select the language of your *overwatch installation* in the extension settings

4. ctrl+shift+p in `pvnip.opy` and select compile. the code will be copied.

5. you can now paste in the code (**not** an import code. on the same screen, click the orange paste icon instead. if you can't find it, press L to open the lobby and click settings on the top right. it's on the right column at the top.)

thank you for translating!

## adding your own threats

this is for fan mods, not contributions to the main mode. i'm unlikely to accept them unless they're really funny.

enums are used, which is an overpy feature. modify the overpy source code in this repository.

modify the following. note that relative order of threats is important. make sure you add your new threat in the same array index across all arrays and enums.

for example if you put your new threat at the index right after frosty niрs, all data about it should also be at the index right after the data for frosty niрs.

- add the enum.

- add an icon to `threatIcons`

- add a name to `threatNames`

- if your threat uses dummy bots...

	- create an array that stores all instances of bots for that threat. e.g. `threatLactaters`. populate it in the rule that creates the behavior for your threat.

	- set this array to an empty array in the loop rule

	- add the threat enum to `dummyThreats` (important, or bots will disappear from surpassing the limit.)

	- you can use one of the variables as a reference (e.g. `threatLactaters`)

- if your threat can be fired by the extra maugas in more maugas, add it to `moreFunThreats`.

	- this list ensures at least 1 threat will be affected by more maugas.

- finally, code the behavior for the threat. see other threats' rules for a reference.

	- for performance reasons you might want to have the exit/loop stop condition be `OBJ == OBJ.INTERMISSION` instead of checking if the threat is still in the threat list.

	- `threatFx` is a list of effect IDs that are destroyed when the round ends. this list is emptied automatically. it's a convenient place to put effects that last throughout the round without needing to delete them later, such as nipple effects.