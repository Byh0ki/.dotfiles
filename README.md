# Config
My linux config &amp; dotfiles

# Usage
```
git clone https://github.com/Byh0ki/.dotfiles.git $HOME/.config/.dotfiles
cd .dotfiles
./install.sh
```

The script will automatically backup your previous dotfiles. (by default in ~/.bak). You can check all the available options with -h.

# Ideas for future changes
- Vim
    - Find better keybind
- I3
    - Color edit
    - Gaps tuning
- Neofetch
    - Customize the neofetch config file
- ZSH
    - Find usefull plugins
- Misc
    - add fonts in the repo
    - Change individuals file colors in bash (dircolors -p)

# Bugs

# Notes
If you want to use this repo as your config files, you might consider to edit a few things like :
- ethernet or wifi name in i3status/config
- your web browser name in i3/config

# Latest changes & fixes
- Vim
    - keybinds ✓
- I3
    - Create a mode for power management ([Idea](https://www.reddit.com/r/i3wm/comments/2yniv1/i3wm_and_power_management/)) ✓
- ZSH
    - Add custom/theme folder to the git repo ✓
- Misc
    - create a bin folder for wallpapers ✓
    - Send a notification for keyboard layout change (notify-send "Keyboard layout" "Change from 'us' to 'fr'" -i /path/to/icon.png) ✓

# Bugs
- CPU temp is not always located at the path given in i3status/config ✓
- my i3 PM mode is using i3-nagbar but i'm not sure i'm using it correctly ✓
    - Hint : Use an executable file containing the cmd
