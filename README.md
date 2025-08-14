overpy source code for mauga nipple game modes for the overwatch workshop
https://workshop.codes/u/_yubz

## mauga nipple pve
[DS2MD](https://workshop.codes/DS2MD)

## mauga nipple: where is it?
[W5PMC](https://workshop.codes/W5PMC)

# contributing

## translations

**mauga nipple pve**: please edit [pvnip.opy](https://github.com/yubber/mauga-nipple-series/blob/main/pvnip.opy)

the code in this repository is **not** workshop code. to compile this to workshop code, you can send me the edited file, or:

1. go to https://zezombye.github.io/overpy/demo

2. paste all the code in the middle box (Overpy text)

3. select the language of your *overwatch installation* in the dropdown

4. click compile, and copy the contents of "compiled text".

5. you can now paste in the code (**not** an import code. on the same screen, click the orange paste icon instead.)

you can upload the code under your account, or ask me to upload it.

the former is easier for you to update, the latter is easier for me to update whenever i add features to mauga nipple pve.

thank you for translating!

## adding threats
enums are used, which is an overpy feature. modify the overpy source code in this repository.

modify the following. note that relative order of threats is important. make sure you add your new threat in the same array index across all arrays and enums.

for example if you put your new threat right after frosty niрs, all data about it should come right after the data for frosty niрs.

- add the enum.

- add an icon to threatIcons

- add a name to threatNames

- if your threat uses dummy bots...

	- create an array that stores all instances of bots for that threat. e.g. threatLactaters. populate it in the rule that creates the behavior for your threat.

	- set this array to an empty array in the loop rule

	- add the threat enum to dummythreats (important, or bots will disappear from surpassing the limit.)

	- you can refer to one of the variables as a reference (e.g. threatLactaters)

- if your threat can be fired by the extra maugas in more maugas, add it to morefunthreats.

	- this list ensures at least 1 threat will be affected by more maugas.

- finally, code the behavior for the threat. see other threats' rules for a reference.

	- for performance reasons you might want to have the exit/loop stop condition be OBJ == OBJ.INTERMISSION instead of checking if the threat is still in the threat list.

	- threatFx is a list of effect IDs that are destroyed when the round ends. this list is emptied automatically. you can add effects as you like.