LastYolo1 = 1
LastYolo2 = 1
firstLoop = 0
SendMode, InputThenPlay
SetBatchLines,-1
CoordMode, Pixel, Window


    Box_Init(C="0x000000")
    {
        Gui, 96: -Caption +ToolWindow +E0x20
        Gui, 96: Color, % C
        Gui, 97: -Caption +ToolWindow +E0x20
        Gui, 97: Color, % C
        Gui, 98: -Caption +ToolWindow +E0x20
        Gui, 98: Color, % C
        Gui, 99: -Caption +ToolWindow +E0x20
        Gui, 99: Color, % C
    }
    Box_Draw(X, Y, W, H, T="1", O="I")
    {
        If(W < 0)
        X += W, W *= -1
        If(H < 0)
        Y += H, H *= -1
        If(T >= 2)
        {
            If(O == "O")
            X -= T, Y -= T, W += T, H += T
            If(O == "C")
            X -= T / 2, Y -= T / 2
            If(O == "I")
            W -= T, H -= T
        }
        Gui, 96: Show, % "x" X " y" Y " w" W " h" T " NA", Horizontal 1
        Gui, 96:+AlwaysOnTop
        Gui, 98: Show, % "x" X " y" Y + H " w" W " h" T " NA", Horizontal 2
        Gui, 98:+AlwaysOnTop
        Gui, 97: Show, % "x" X " y" Y " w" T " h" H " NA", Vertical 1
        Gui, 97:+AlwaysOnTop
        Gui, 99: Show, % "x" X + W " y" Y " w" T " h" H " NA", Vertical 2
        Gui, 99:+AlwaysOnTop
    }
    Box_Destroy()
    {
        Loop, 4
        Gui, % A_Index + 95 ":  Destroy"
    }
    Box_Hide()
    {
        Loop, 4
        Gui, % A_Index + 95 ":  Hide"
    }


guif:
    
    SkinForm(Apply, A_ScriptDir . "\USkin.dll", A_ScriptDir . "\Milikymac.msstyles")
    Firing := 0

    Gui Show, w360 h460, HappyBlock
    Gui Add, Text, x10 y440 w100 h30, Version: ALPHA 0.5 FPS
    Gui Add, Text, x220 y440 w150 h30, No Controller Support ATM!

    Gui Add, GroupBox, x10 y10 w180 h120, Scripts
        Gui Add, CheckBox, x20 y30 w160 h20 voverlayActive4, AutoBlock
		Gui Add, CheckBox, x20 y50 w160 h20 voverlayActive5, AutoGB

    Gui Add, GroupBox, x10 y130 w180 h130, Misc
        Gui Add, CheckBox, x20 y150 w160 h20 voverlayActive, Draw Search Area,
        Gui Add, CheckBox, x20 y210 w160 h20 voverlayActive8, Draw Key Box Left
        Gui Add, CheckBox, x20 y190 w160 h20 voverlayActive6, Draw key Box Right
        Gui Add, CheckBox, x20 y170 w160 h20 voverlayActive7, Draw Key Box Up

    Gui Add, GroupBox, x10 y260 w180 h170, Customizing
        Gui Add, Text, x20 y280 w45 h30, Color Variation
        Gui Add, Edit, x65 y280 w40 h20
        Gui Add, UpDown, x65 y500 w30 h50 vColV Range1-30, 10
        Gui Add, Text, x20 y310 w35 h20, Right
        Gui Add, Edit, x65 y310 w40 h20
        Gui Add, UpDown, x65 y500 w30 h50 vYOLO1 Range-500-500, 1
        Gui Add, Text, x20 y340 w35 h20, Up
        Gui Add, Edit, x65 y340 w40 h20
        Gui Add, UpDown, x65 y500 w30 h50 vYOLO4 Range-500-500, 1
        Gui Add, Text, x20 y370 w35 h20, Down
        Gui Add, Edit, x65 y370 w40 h20
        Gui Add, UpDown, x65 y500 w30 h50 vYOLO2 Range-500-500, 1
        Gui Add, Text, x20 y400 w35 h20, Left
        Gui Add, Edit, x65 y400 w40 h20
        Gui Add, UpDown, x65 y500 w30 h50 vYOLO3 Range-500-500, 1

    Gui Add, GroupBox, x200 y10 w150 h120, Hotkeys
        Gui Add, Text, x220 y30 w130 h15, Activate [F1]
        Gui Add, Text, x220 y50 w160 h15, Restart Program [F3]
        Gui Add, Text, x220 y70 w110 h15, Pause/Resume [F4]

    Gui Add, GroupBox, x200 y130 w150 h45, Resolution (Ingame)
        Gui Add, Text, x220 y153 w35 h20, X:
        Gui Add, Edit, x235 y150 w35 h20 vxa, 1920
        Gui Add, Text, x280 y153 w35 h20, Y:
        Gui Add, Edit, x295 y150 w30 h20 vya, 1080
		Gui Add, Edit, x115 y110 w35 h20 vPause, 0
		Gui Add, Text, x30 y70 w150 h70, Pause between searches Default 0Ms For example 250ms Sleep = 4 Searches/ Sec = More Fps:

    Gui Add, GroupBox, x200 y180 w150 h250
        Gui Add, Button, x230 y200 w100 h20 gButton_HowTo, How-to
        Gui Add, Button, x230 y230 w100 h20 gButtonUpdateVersion, Get lastest ver
        Gui Add, Button, x230 y260 w100 h20 gButtonDiscord, Discord
        Gui Add, Button, x230 y290 w100 h20 gButtonSave, Destroy Box
        Gui Add, Button, x230 y320 w100 h20 gButtonFAQ, FAQ
        Gui Add, Button, x230 y350 w100 h20 gButtonSS, Secret Settings

    Loop
    {
        Gui, Submit, NoHide
        Sleep -1
    }
return


Button_HowTo:
{
    msgbox, How-to:`n` Launch Game.  Set display mode to Windowed mode in Settings.`nRemapp your Block keys to Arrow Keys`nHow-To-use:`n  `nstep 1. Tick the settings do u want to use (Tick Draw Search Area if u want to adjust the Search area) `nstep 2. Enter Resolution `nstep 3. Press F1!  `nStep 4.Adjust Searchbox with the (UP,DOWN,LEFT,RIGHT) boxes `nStep 5. After adjusting the Search Area untick Draw Search Area for more FPS (u can still see the box)
}
return

ButtonUpdateVersion:
{
    Run, https://discordapp.com/channels/239480814432157697/281171814821003264
}
return

ButtonDiscord:
{
    Run, https://discord.gg/ZXD7Eps
}
return

ButtonFAQ:
{
    msgbox, User: I get huge FPS drops how can i FIx it ? `n Dev: Untick Draw Search area After Pressing F1 and adjusting the Search Area `n`n Dev: Yes Controller and Auto anti guardbreak is on the list and i work on it
}
return

ButtonSS:
{
    Run, https://youtu.be/DLzxrzFCyOs?t=43s
}
return

Guiclose:
    exitapp
return

SkinForm(Param1 = "Apply", DLL = "", SkinName = "")
{
    if(Param1 = Apply)
    {
        DllCall("LoadLibrary", str, DLL)
        DllCall(DLL . "\USkinInit", Int,0, Int,0, AStr, SkinName)
    } else  if(Param1 = 0)
    {
        DllCall(DLL . "\USkinExit")
    }
}
Change1:
    MsgBox,  Applied
    Gui,Submit, Nohide
return
 
Gui,Submit, Nohide
GuiControlget, overlayActive4
GuiControlget, overlayActive
GuiControlget, YOLO1
GuiControlget, YOLO2
GuiControlget, xa
GuiControlget, ya
GuiControlget, xrange
GuiControlget, yrange
EMCol := 0xD30607
ColVn := 5
FoundFlag :=false
xr := (xa/100) * 53,9
yr := (ya/100) * 48,82
xl := (xa/100) * 49,21
xl2 := (xa/100) * 39
yl := (ya/100) * 30,7
yo := (ya/100) * 59
yo2 := (ya/100) * 30
if (overlayActive = 0)
{
    MsgBox, You need to tick Draw Search Area `n`n You can untick it after Pressing F1 for more FPS
    return
}



Loop
{
    if (overlayActive4 = 1)
    {
        GoSub SearchBot4
		sleep, Pause
    }

		
	
	
    if(overlayActive=1)
    {
        Gui,Submit, Nohide
		UpscaleUp := (ya/100) * 13,88
		UpscaleUp2 := (ya/100) * 83,33
        LargeX1 := (xa/100) * 36,64
        LargeY1 := (ya/100) * 33,39
        LargeX2 := (xa/100) * 65,15
        LargeY2 := (ya/100) * 73,63
        LargeX2 := LargeX2 + YOLO1
        LargeY2 := LargeY2 + YOLO2
        LargeX1 := LargeX1 - YOLO3
        LargeY1 := LargeY1 - YOLO4
        LargeY1 := LargeY1 - 100
        GX := (xa/100) * 18,75
        GY := (ya/100) * 35,15
        G2X := (xa/100) * 37,5
        G2Y := (ya/100) * 58,59

        if(LastYolo1 != YOLO1)
        {
            LastYolo1 := YOLO1
            Box_Init("0x000000")
            Box_Draw(LargeX1, LargeY1 , LargeX2-LargeX1, LargeY2-LargeY1)
        }
        if(LastYolo2 != YOLO2)
        {
            LastYolo2 := YOLO2
            Box_Init("0x000000")
            Box_Draw(LargeX1, LargeY1 , LargeX2-LargeX1, LargeY2-LargeY1)
        }
        if(LastYolo3 != YOLO3)
        {
            LastYolo2 := YOLO3
            Box_Init("0x000000")
            Box_Draw(LargeX1, LargeY1 , LargeX2-LargeX1, LargeY2-LargeY1)
        }
        if(LastYolo4 != YOLO4)
        {
            LastYolo2 := YOLO4
            Box_Init("0x000000")
            Box_Draw(LargeX1, LargeY1 , LargeX2-LargeX1, LargeY2-LargeY1)
        }
        if(firstLoop == 0)
        {
            firstLoop = 1
            Box_Init("0x000000")
            Box_Draw(LargeX1, LargeY1 , LargeX2-LargeX1, LargeY2-LargeY1)
        }
   
   }
}


ButtonSave:
{
Overlayactive := 0
    Box_Destroy()
}
SearchBot4:
    PixelSearch, FoundX, FoundY,  814, 277, 1144, 623, 0xD30607, ColV,fast, RGB,
    if Errorlevel = 0
   
    If else (FoundX > xr, FoundY > yr, Errorlevel = 0)
    {
        Send {Right down}
sleep, 100
Send {Right up}

        FoundX = 0
        FoundY = 0
		return
    }
    
    if else (FoundX < xl and FoundX > xl2, FoundY > yl)
    {
        Send {Left down}
sleep, 100
Send {Left up}
        FoundX = 0
        FoundY = 0
		return
		
		
    }
    if else (FoundY > UpscaleUp, FoundY < UpscaleUp2)
    
    {
        Send {up down}
sleep, 100
  Send {up up}
        FoundX = 0
        FoundY = 0
		return
    }
	

return



~F4::
    pause
    SoundBEEP
return

F3::
    Reload
return