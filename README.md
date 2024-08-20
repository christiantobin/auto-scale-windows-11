# Auto-Scaling Display Script

This AutoHotkey script automatically adjusts the display scaling of your laptop based on the number of connected monitors. When more than one monitor is detected (e.g., when connected to a desk setup with external monitors), the script sets the laptop's display scaling to 150%. When only the laptop monitor is detected (e.g., when unplugged from the desk setup), the script reverts the display scaling to 100%.

## Features
- **Automatic Monitor Detection:** The script detects when monitors are connected or disconnected.
- **Dynamic Display Scaling:** Adjusts the display scaling based on the number of connected monitors.
- **Focus Management:** Ensures the Windows Settings app is correctly focused before making changes.
- **Clean Exit:** Closes the Windows Settings app after adjusting the display settings.

## Prerequisites
- **AutoHotkey v2:** This script is written for AutoHotkey v2. Ensure you have AutoHotkey v2 installed on your system. [Download AutoHotkey](https://www.autohotkey.com/)

## Installation
1. **Download and Install AutoHotkey v2:**
   - Visit the [AutoHotkey website](https://www.autohotkey.com/) and download the latest version of AutoHotkey v2.

2. **Save the Script:**
   - Copy the script from this repository and save it as `AutoScale.ahk` in a location of your choice.

3. **Add the Script to Startup (Optional):**
   - If you want the script to run automatically when you log in to Windows:
     - Press `Win + R`, type `shell:startup`, and press `Enter`.
     - Copy the `AutoScale.ahk` script to the opened `Startup` folder.

## Usage
- **Run the Script:**
  - Double-click the `AutoScale.ahk` script to start it. The script will now run in the background, automatically adjusting display scaling based on your monitor setup.

- **Monitor Changes:**
  - The script automatically detects when you connect or disconnect monitors and adjusts the display scaling accordingly.

## Script Overview

```autohotkey
; AutoHotkey v2 script to adjust display scaling based on monitor setup

MonitorChange(wParam, lParam, msg, hwnd) {
    Sleep(5000)  ; Wait for monitors to be detected

    MonitorCount := SysGet(80)  ; Get the number of monitors
    TrayTip("Monitor Setup", "Detected " MonitorCount " monitor(s).")

    if (MonitorCount > 1) {
        Run("DisplaySwitch.exe /extend")
        Sleep(3000)
        Run("ms-settings:display")
        WinWaitActive("Settings")
        Sleep(1000)
        Send("{Tab 20}")
        Sleep(500)
        Send("{Space}")
        Sleep(500)
        Send("{Down}")
        Send("{Down}")
        Send("{Enter}")
        Sleep(1000)
        WinClose("Settings")
    } else {
        Run("DisplaySwitch.exe /internal")
        Sleep(3000)
        Run("ms-settings:display")
        WinWaitActive("Settings")
        Sleep(1000)
        Send("{Tab 8}")
        Sleep(500)
        Send("{Space}")
        Sleep(500)
        Send("{Up}")
        Send("{Up}")
        Send("{Enter}")
        Sleep(1000)
        WinClose("Settings")
    }
}

OnMessage(0x219, MonitorChange)

Loop {
    Sleep(1000)  ; Keep the script running
}
