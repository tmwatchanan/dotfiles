#!/bin/bash
# macOS system defaults. Re-runnable; log out and back in for changes to apply.

set -euo pipefail

# Keyboard
# Values are in units of 15ms. Lower = faster.
defaults write -g InitialKeyRepeat -int 15 # delay until repeat (225ms)
defaults write -g KeyRepeat -int 2         # repeat rate (30ms)

# Dock
defaults write com.apple.dock autohide-delay -float 0 # show instantly on hover
killall Dock

echo "Done. Log out and back in (or restart apps) for changes to take effect."
