; Globals ======================================================================
#SingleInstance, Force ; Replace with new instance if script is running
#Persistent ; Keep script permanently running until terminated
#NoEnv ; Prevent identifying empty variables as potential environment variables
#Warn ; Enable warnings to assist with detecting errors
;#NoTrayIcon ; Disable the tray icon of the script
SendMode, Input ; Method for sending keystrokes and mouse clicks
SetWorkingDir, %A_ScriptDir% ; The current working directory of the script




; ==============================================================================
;Gui 0
Application := {Name: "Menu Interface", Version: "0.1"}
Window := {Width: 600, Height: 400, Title: Application.Name}
Navigation := {Label: ["Games", "Misc", "Language", "Settings", "---", "Help", "About"]}
; ==============================================================================
;Gui 2
Application2 := {Name2: "Script Downloader", Version2: "0.1"}
Window2 := {Width2: 600, Height2: 150, Title2: Application.Name}

; Auto-Execute =================================================================

Menu, Tray, Icon, Shell32.dll, 174
Menu, Tray, Tip, % Application.Name
Menu, Tray, NoStandard
Menu, Tray, Add, Exit, ExitSub

Gui, +LastFound -Resize +HwndhGui1
Gui, Color, FFFFFF

Gui, Add, Tab2, % " x" -999999 " y" -999999 " w" 0 " h" 0 " -Wrap +Theme vTabControl", % ""

Gui, Tab ; Exclude future controls from any tab control

Gui, Add, Picture, % "x" -999999 " y" -999999 " w" 4 " h" 32 " vpMenuHover +0x4E +HWNDhMenuHover",
Gui, Add, Picture, % "x" 0 " y" 18 " w" 4 " h" 32 " vpMenuSelect +0x4E +HWNDhMenuSelect",

Gui, Font, s9 c808080, Segoe UI ; Set Font Options
Loop, % Navigation.Label.Length() {
	GuiControl,, TabControl, % Navigation.Label[A_Index] "|"
	If (Navigation.Label[A_Index] = "---") {
		Continue
	}
	Gui, Add, Text, % "x" 18 " y" (32*A_Index)-14 " h" 32 " +0x200 gMenuClick vMenuItem" . A_Index, % Navigation.Label[A_Index]
}
Gui, Font ; Reset font options

Gui, Font, s11 c000000, Segoe UI ; Set Font Options
Gui, Add, Text, % "x" 192 " y" 18 " w" (Window.Width-192)-14 " h" 32 " +0x200 vPageTitle", % ""
Gui, Font ; Reset font options

Gui, Add, Picture, % "x" 192 " y" 50 " w" (Window.Width-192)-14 " h" 1 " +0x4E +HWNDhDividerLine",


Gui, Tab, 1 ; Future controls are owned by the specified tab
Gui, Add, Checkbox, % "x" 192 " y" 66 " w" (Window.Width-192)-14, % "For Honor"
Gui, Add, Button, % "x" (Window.Width-170)-10 " y" (Window.Height-24)-10 " w" 80 " h" 24 " vButtonOK", % "Install"
Gui, Add, Button, % "x" (Window.Width-80)-10 " y" (Window.Height-24)-10 " w" 80 " h" 24 " vButtonCancel", % "Deinstall"

Gui, Tab, 2 ; Future controls are owned by the specified tab
Gui, Add, Checkbox, % "x" 192 " y" 100 " w" (Window.Width-192)-14, % "Checkbox Example2"

Gui, Tab, 3 ; Future controls are owned by the specified tab
Gui, Add, MonthCal, % "x" 192 " y" 66

Gui, Tab, 4 ; Future controls are owned by the specified tab
Gui, Add, DateTime, % "x" 192 " y" 66, LongDate

Gui, Tab, 5 ; Future controls are owned by the specified tab
; Skipped

Gui, Tab, 6 ; Future controls are owned by the specified tab
Gui, Add, GroupBox, % "x" 192 " y" 66 " w" (Window.Width-192)-14, % "GroupBox"

Gui, Tab, 7 ; Future controls are owned by the specified tab
Gui, Add, DateTime, % "x" 192 " y" 66, LongDate

Gui, Show, % " w" Window.Width " h" Window.Height, % Window.Title

GoSub, OnLoad
return ; End automatic execution
; ==============================================================================

; Labels =======================================================================
OnLoad:
	SetPixelColor("CCEEFF", hMenuHover)
	SetPixelColor("3399FF", hMenuSelect)
	SetPixelColor("D8D8D8", hDividerLine)
	SelectMenu("MenuItem1")
	OnMessage(0x200, "WM_MOUSEMOVE")
return

MenuClick:
	SelectMenu(A_GuiControl)
return

GuiEscape:
GuiClose:

ExitSub:
	ExitApp ; Terminate the script unconditionally
return
; ==============================================================================

; Functions ====================================================================
SelectMenu(Control) {
	Global

	CurrentMenu := Control

	Loop, % Navigation.Label.Length() {
		SetControlColor("808080", Navigation.Label[A_Index])
	}

	SetControlColor("000000", Control)
	GuiControl, Move, pMenuSelect, % "x" 0 " y" (32*SubStr(Control, 9, 2))-14 " w" 4 " h" 32
	GuiControl, Choose, TabControl, % SubStr(Control, 9, 2)
	GuiControl,, PageTitle, % Navigation.Label[SubStr(Control, 9, 2)]
}

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
	Global

	If (InStr(A_GuiControl, "MenuItem") = true && A_GuiControl != CurrentMenu) {
		GuiControl, Move, pMenuHover, % "x" 0 " y" (32*SubStr(A_GuiControl, 9, 2))-14 " w" 4 " h" 32
	} Else If (InStr(A_GuiControl, "MenuItem") = false || A_GuiControl = CurrentMenu) {
		GuiControl, Move, pMenuHover, % "x" -999999 " y" -999999 " w" 4 " h" 32
	}
}

SetControlColor(Color, Control) {
	Global

	GuiControl, % "+c" Color, % Control

	; Required due to redrawing issue with Tab2 control
	GuiControlGet, ControlText,, % Control
	GuiControlGet, ControlHandle, Hwnd, % Control
	DllCall("SetWindowText", "Ptr", ControlHandle, "Str", ControlText)
}

SetPixelColor(Color, Handle) {
	VarSetCapacity(BMBITS, 4, 0), Numput("0x" . Color, &BMBITS, 0, "UInt")
	hBM := DllCall("Gdi32.dll\CreateBitmap", Int, 1, Int, 1, UInt, 1, UInt, 24, Ptr, 0)
	hBM := DllCall("User32.dll\CopyImage", Ptr, hBM, UInt, 0, Int, 0, Int, 0, UInt, 0x2008)
	DllCall("Gdi32.dll\SetBitmapBits", Ptr, hBM, UInt, 3, Ptr, &BMBITS)
	return DllCall("User32.dll\SendMessage", Ptr, Handle, UInt, 0x172, Ptr, 0, Ptr, hBM)
}
; ==============================================================================
;Main Loader Functins
; ===============================================================================
Buttoninstall:

Gui 2:Show, w500 h100, Script Downloader
Gui 2: -Sysmenu
Gui 2:Menu,
Gui 2: Add, Text,,                                        Github/Download URL
Gui 2: Add, Text,       x350 y40  ,                             Script Name
Gui 2: Add, Edit,   x10 y20  w200 h17  vURL 
Gui 2: Add, Edit,   x350 y20  w100 h17  vName1      
Gui 2:Add, Text,   vText1 x10 y40  w500         ,        Script will be saved in %A_AppData%
Gui 2: Add, Text,   vText2  w250
Gui 2: Add, Button, x10 y65 w75  h35   gButtonInstall2, install
Gui 2: Add, Button, x100 y65 w75  h35  gButtonClose, Close 
Gui 2: Add, CheckBox, x225 y20 w100 h20 voverlayActive, Install Local,
Return
ButtonClose:
Gui, Destroy
Return

Buttoninstall2:
GuiControl,2:,vURL 
GuiControlGet, URL 
GuiControl,2:,vName1
GuiControlGet, Name1
IfNotExist, %A_AppData%\HappyLoader
FileCreateDir %A_AppData%\HappyLoader


UrlDownloadToFile, %URL%,  %A_AppData%\HappyLoader\ %Name1%.ahk
return










F3::
    Reload