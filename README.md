# Config
My linux config &amp; dotfiles

# Ideas for future changes
- Vim
    - **ww** keybind for :update (nnoremap ww :update<cr>) ✓
    - **wx** keybind for :x ✓
    - **ck** keybind for gg=G`` (auto indenting the current buffer) ✓
- I3
    - Color edit
    - Create a mode for power management ([Idea](https://www.reddit.com/r/i3wm/comments/2yniv1/i3wm_and_power_management/)) ✓
- Neofetch
    - Customize the neofetch config file
- ZSH
    - Add custom/theme folder to the git repo ✓
- Misc
    - add fonts in the repo
    - create a bin folder for wallpapers
    - Send a notification for keyboard layout change (notify-send "Keyboard layout" "Change from 'us' to 'fr'" -i /path/to/icon.png) ✓
    - Change individuals file colors in bash (dircolors -p)

# Bugs
- CPU temp is not always located at the path given in i3status/config ✓
- my i3 PM mode is using i3-nagbar but i'm not sure i'm using it correctly

# Notes
If you want to use this repo as your config files, you might consider to edit a few things like :
- ethernet or wifi name in i3status/config
- your web browser name in i3/config
