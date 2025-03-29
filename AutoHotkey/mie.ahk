#Requires AutoHotkey v2.0
#SingleInstance Force  ; Ensures only one instance runs

*CapsLock:: Send "{Blind}{Ctrl DownR}"

*CapsLock Up::
{
    Send "{Blind}{Ctrl up}"
    if (A_PriorKey = "CapsLock")
        Send "{Esc}"
}

!+F12:: Reload
rcon_script_path := "\\wsl.localhost\Ubuntu\home\mie\dev\fivem-server\rcon.ahk"
!+F11:: Run rcon_script_path