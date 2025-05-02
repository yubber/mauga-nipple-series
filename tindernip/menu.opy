#!mainFile "tindernip.opy"

globalvar cms
globalvar cm_Buttons
globalvar cm_Ctrl

playervar cm_Open
playervar cm_originalFacing
playervar cm_ButtonsPlayer
playervar cm_CurrentHover
playervar cm_CurrentPage
playervar cm_CurrentClick

subroutine cm_Lock
subroutine cm_Unlock

rule "Alo's Cursor Menu / By Alomare#11266":
    #Cursor Scale [1 to 4]
    cms[0] = 3
    #Cursor Sensitivity
    cms[1] = 20
    #Cursor Color [color or custom color]
    cms[2] = Color.WHITE
    #Tooltip Scale [1 to 4]
    cms[3] = 1.2

rule "[CM] Toggle Cursor Menu":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true

    if eventPlayer.cm_Open:
        cm_Unlock()
        eventPlayer.cm_Open = false
    else:
        cm_Lock()
        eventPlayer.cm_Open = true


rule "[CM] Close Menu on Death":
    @Event playerDied
    @Condition eventPlayer.cm_Open == true

    cm_Unlock()
    eventPlayer.cm_Open = false


def cm_Lock():
    @Name "[CM] cm_Lock"
    eventPlayer.cm_originalFacing = vect(eventPlayer.getFacingDirection().x, 0, eventPlayer.getFacingDirection().z)
    eventPlayer.setFacing(eventPlayer.cm_originalFacing, Relativity.TO_WORLD)
    eventPlayer.disableHeroHud()
    eventPlayer.disableGamemodeHud()
    eventPlayer.setAimSpeed(1)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)

def cm_Unlock():
    @Name "[CM] cm_Unlock"
    eventPlayer.enableHeroHud()
    eventPlayer.enableGamemodeHud()
    eventPlayer.setAimSpeed(100)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)


rule "[CM] Out Of Screen Bounds":
    @Event eachPlayer
    @Condition eventPlayer.cm_Open == true
    @Condition (abs(angleDifference(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), horizontalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1]) > 125 or abs(angleDifference(verticalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1]) > 70) == true

    wait(0.1)
    if angleDifference(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), horizontalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] > 125:
        eventPlayer.setFacing(directionFromAngles(-125 / cms[1] + horizontalAngleOfDirection(eventPlayer.cm_originalFacing), verticalAngleOfDirection(eventPlayer.getFacingDirection())), Relativity.TO_WORLD)
    elif angleDifference(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), horizontalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] < -125:
        eventPlayer.setFacing(directionFromAngles(125 / cms[1] + horizontalAngleOfDirection(eventPlayer.cm_originalFacing), verticalAngleOfDirection(eventPlayer.getFacingDirection())), Relativity.TO_WORLD)
    elif angleDifference(verticalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] > 70:
        eventPlayer.setFacing(directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), -70 / cms[1] + verticalAngleOfDirection(eventPlayer.cm_originalFacing)), Relativity.TO_WORLD)
    elif angleDifference(verticalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] < -70:
        eventPlayer.setFacing(directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), 70 / cms[1] + verticalAngleOfDirection(eventPlayer.cm_originalFacing)), Relativity.TO_WORLD)
    if ruleCondition:
        loop()


rule "[CM] Base Elements":
    #The Cursor
    createInWorldText(localPlayer if localPlayer.cm_Open and getTotalTimeElapsed() % 0.032 > 0.016 else null, " \n\n\n  ↖", updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * angleDifference(horizontalAngleOfDirection(localPlayer.getFacingDirection()), horizontalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * angleDifference(verticalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1]), cms[0], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, cms[2])
    createInWorldText(localPlayer if localPlayer.cm_Open and getTotalTimeElapsed() % 0.032 <= 0.016 else null, " \n\n\n  ↖", updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * angleDifference(horizontalAngleOfDirection(localPlayer.getFacingDirection()), horizontalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * angleDifference(verticalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1]), cms[0], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, cms[2])
    #Tooltip
    createInWorldText(localPlayer if localPlayer.cm_Open and getTotalTimeElapsed() % 0.032 > 0.016 and (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[10] else null, (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[10], updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * angleDifference(horizontalAngleOfDirection(localPlayer.getFacingDirection()), horizontalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * angleDifference(verticalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + vect(0, -6, 0)), cms[3], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[11])
    createInWorldText(localPlayer if localPlayer.cm_Open and getTotalTimeElapsed() % 0.032 <= 0.016 and (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[10] else null, (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[10], updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * angleDifference(horizontalAngleOfDirection(localPlayer.getFacingDirection()), horizontalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * angleDifference(verticalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.cm_originalFacing)) * cms[1] + vect(0, -6, 0)), cms[3], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, (([player for player in localPlayer.cm_ButtonsPlayer if localPlayer.cm_CurrentHover == player[1]])[0])[11])


rule "[CM] Add Buttons ★":
    #BUTTON DATA REFERENCES
    #
    #0 - Page (0 = All)
    #1 - ID [positive integer]
    #2 - Label
    #3 - Type (0 = Label Only, 1 = Clickable)
    #4 - X Coordinate [-100 to 100]
    #5 - Y Coordinate [-100 to 100]
    #6 - Default Scale [1 to 4]
    #7 - Hover Scale [1 to 4]
    #8 - Default Color [color or custom color]
    #9 - Hover Color [color or custom color]
    #10 - Cursor Tooltip
    #11 - Cursor Tooltip Color [color or custom color]
    #12 - Visible [true/false]
    cm_Buttons[0] = [null, 1, "BALANCE THE GAME", true, 0, 7, 3.5, 3.7, rgb(225, 225, 225), Color.WHITE, "WARNING: REQUIRES EFFORT", Color.YELLOW, true]
    cm_Buttons[1] = [null, 2, "NERF GENJI", true, 0, -7, 3.5, 3.7, rgb(225, 225, 225), Color.LIME_GREEN, null, null, true]


rule "[CM] Generate Buttons":
    for cm_Ctrl in range(len(cm_Buttons)):
        wait()
        if cm_Buttons[cm_Ctrl] != null:
            if cm_Buttons[cm_Ctrl][6] == cm_Buttons[cm_Ctrl][7]:
                createInWorldText(localPlayer if localPlayer.cm_Open and localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][12] and (localPlayer.cm_CurrentPage == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0] or not localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0]) else null, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][2], updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][4] * 1.25 + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][5] * 0.7), cm_Buttons[cm_Ctrl][6], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][9] if localPlayer.cm_CurrentHover == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1] and abs(localPlayer.cm_CurrentClick) != localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1] else localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][8])
                #Different Scale
            else:
                #Not Hovered
                createInWorldText(localPlayer if (localPlayer.cm_Open and localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][12] and (localPlayer.cm_CurrentPage == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0] or not localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0])) and (localPlayer.cm_CurrentHover != localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1] or abs(localPlayer.cm_CurrentClick) == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1]) else null, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][2], updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][4] * 1.25 + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][5] * 0.7), cm_Buttons[cm_Ctrl][6], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][9] if abs(localPlayer.cm_CurrentClick) == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1] else localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][8])
                #Hovered
                createInWorldText(localPlayer if ((localPlayer.cm_Open and localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][12] and (localPlayer.cm_CurrentPage == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0] or not localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][0])) and localPlayer.cm_CurrentHover == localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1]) and abs(localPlayer.cm_CurrentClick) != localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][1] else null, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][2], updateEveryFrame(localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 100 + normalize(crossProduct(localPlayer.getFacingDirection(), Vector.UP)) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][4] * 1.25 + normalize(crossProduct(crossProduct(localPlayer.getFacingDirection(), Vector.UP), localPlayer.getFacingDirection())) * localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][5] * 0.7), cm_Buttons[cm_Ctrl][7], Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, localPlayer.cm_ButtonsPlayer[evalOnce(cm_Ctrl)][9])


rule "[CM] Copy Global Button Data to Player on Join":
    @Event playerJoined

    eventPlayer.cm_ButtonsPlayer = cm_Buttons


rule "[CM] Reevaluate Hovered Button":
    @Event eachPlayer
    @Condition eventPlayer.cm_Open == true

    wait(0.032)
    #Buttons with smaller default scale are prioritized
    eventPlayer.cm_CurrentHover = ((sorted([player for player in eventPlayer.cm_ButtonsPlayer if ((((player[3] and player[12] and (not player[0] or eventPlayer.cm_CurrentPage == player[0])) and angleDifference(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), horizontalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] > player[4] * 1.25 - strLen(player[2]) / 1.8 * player[6]) and angleDifference(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), horizontalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] < player[4] * 1.25 + strLen(player[2]) / 1.8 * player[6]) and angleDifference(verticalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] > player[5] * 0.7 - 1 * (player[6] / 3.2)) and angleDifference(verticalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.cm_originalFacing)) * cms[1] < player[5] * 0.7 + 6 * (player[6] / 2.7)], lambda i: i[6]))[0])[1]
    if ruleCondition:
        loop()


rule "[CM] Button Click - Primary Fire / Jump":
    @Event eachPlayer
    @Condition eventPlayer.cm_Open == true
    @Condition (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.JUMP)) == true

    if eventPlayer.cm_CurrentClick:
        return
    eventPlayer.cm_CurrentClick = eventPlayer.cm_CurrentHover
    waitUntil(not eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and not eventPlayer.isHoldingButton(Button.JUMP), 99999)
    eventPlayer.cm_CurrentClick = null


rule "[CM] Button Click - Secondary Fire":
    @Event eachPlayer
    @Condition eventPlayer.cm_Open == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true

    if eventPlayer.cm_CurrentClick:
        return
    eventPlayer.cm_CurrentClick = eventPlayer.cm_CurrentHover * -1
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 99999)
    eventPlayer.cm_CurrentClick = null

rule "'Balance the Game' Clicked":
    @Event eachPlayer
    @Condition eventPlayer.cm_CurrentClick == 1

    declareTeamVictory(getOppositeTeam(eventPlayer.getTeam()))


rule "'Nerf Genji' Clicked":
    @Event eachPlayer
    @Condition eventPlayer.cm_CurrentClick == 2

    damage(eventPlayer, null, 50)
    eventPlayer.communicate(Comms.NEED_HEALING)


