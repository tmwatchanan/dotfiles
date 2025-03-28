#Requires AutoHotkey v2.0

*CapsLock::Send "{Blind}{Ctrl DownR}"

*CapsLock Up::
{
    Send "{Blind}{Ctrl up}"
    If (A_PriorKey = "CapsLock")
        Send "{Esc}"
}