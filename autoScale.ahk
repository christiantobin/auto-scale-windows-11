; AutoHotkey v2 script to adjust display scaling based on monitor setup

MonitorChange(wParam, lParam, msg, hwnd) {
    ; Wait for a few seconds to ensure monitors are detected
    Sleep(5000)  ; Increase the delay to ensure the system has enough time to detect all monitors

    ; Re-check the number of connected monitors
    MonitorCount := SysGet(80)  ; 80 is the constant for getting the number of monitors
    TrayTip("Monitor Setup", "Detected " MonitorCount " monitor(s).")

    if (MonitorCount > 1) {
        TrayTip("Monitor Setup", "More than one monitor connected. Setting scaling to 150%.")
        Run("DisplaySwitch.exe /extend")
        Sleep(3000)  ; Give more time for the monitor to be fully recognized
        Run("ms-settings:display")
        WinWaitActive("Settings")  ; Ensure the Settings window is in focus
        Sleep(1000)  ; Extra delay to ensure focus
        ; Navigate to Scale dropdown
        Send("{Tab 20}")  ; Adjust number based on actual tabs required to reach the Scale dropdown
        Sleep(500)
        Send("{Space}")  ; Open the Scale dropdown
        Sleep(500)
	Send("{Down}")
        Send("{Down}")   ; Navigate to 150%
        Send("{Enter}")
        Sleep(1000)
        WinClose("Settings")  ; Close the Settings window
    } else {
        TrayTip("Monitor Setup", "Only laptop monitor connected. Setting scaling to 100%.")
        Run("DisplaySwitch.exe /internal")
        Sleep(3000)  ; Give more time for the monitor to be fully recognized
        Run("ms-settings:display")
        WinWaitActive("Settings")  ; Ensure the Settings window is in focus
        Sleep(1000)  ; Extra delay to ensure focus
        ; Navigate to Scale dropdown
        Send("{Tab 8}")  ; Adjust number based on actual tabs required to reach the Scale dropdown
        Sleep(500)
        Send("{Space}")  ; Open the Scale dropdown
        Sleep(500)
        Send("{Up}")
        Send("{Up}")     ; Navigate to 100%
        Send("{Enter}")
        Sleep(1000)
        WinClose("Settings")  ; Close the Settings window
    }
}

; Register for device change notifications
OnMessage(0x219, MonitorChange)

; Keep the script running
Loop {
    Sleep(1000)  ; Keeps the script alive
}