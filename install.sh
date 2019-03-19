#!/bin/bash

## Variables declarations

# You should only edit theses var if you want to add a new dotfile
dot_list_home=".env .aliases .bashrc .gitconfig .gitignore .gtkrc-2.0 .vimrc .xinitrc .Xresources .zshCustom .zshrc"
dot_list_conf="dunst compton.conf gtk-3.0 i3 i3utils i3status neofetch wallpapers"

# Internal script vars
bak=".bak"
dst="$HOME"
help_msg="./install.sh [-h] [-s] [-b backup dir] [-e extra_dir] [-d dst_dir]

[-h] display this help message
[-s] activate the hook for suspend /!\\ root access needed /!\\
[-b] change backup directory
[-e] the script will prioritize a file from the extra_dir if it exist
[-d] change the default destination directory for the symlinks"

## Functions declarations

create_dirs()
{
    # $1 : dst
    mkdir -p "$1/$bak"
    mkdir -p "$1/.config"
}

contain()
{
    # $1 : list
    # $2 : elt to match
    [[ "$1" =~ (^|[[:space:]])"$2"($|[[:space:]]) ]]
}

backup()
{
    # $1 : dst dir
    # $2 : filename
    # $3 : backup path
    path="$1/$2"
    if [[ -f "$path" || -d "$path" ]]; then             # File or dir already exist
        if [ -L "$path" ]; then                         # Is a symlink
            rm "$path"
        else                                            # Is a regular file
            mv "$path" "$3/$2.old"
        fi
    fi
}

backup_sys()
{
    # $1 : dst dir
    # $2 : filename
    # $3 : backup path
    path="$1/$2"
    if [[ -f "$path" || -d "$path" ]]; then             # File or dir already exist
        sudo mv "$path" "$3/$2.old"
    fi
}

create_symlinks()
{
    # $1 : dst dir
    # $2 : list of dotfiles
    # $3 : backup path
    # $4 : pick file from the extra folder
    for elt in $2; do
        backup "$1" "$elt" "$3"                         # Backup
        if [ ! -z "$4" ] && [[ -f "extra/$4/$elt" || -d "extra/$4/$elt" ]]; then
            elt_path="$PWD/extra/$4/$elt"
        else
            elt_path="$PWD/common/$elt"
        fi
        ln -s "$elt_path" "$1/$elt"                     # Create the final symlink
        echo "ln -s $elt_path $1/$elt"
    done
}

copy_sys_dot()
{
    # $1 : dst dir
    # $2 : dotfile
    # $3 : pick file from the extra folder
    backup_sys "$1" "$2" "$dst_dir"                     # Backup
    if [ ! -z "$3" ] && [[ -f "extra/$3/$2" || -d "extra/$3/$2" ]]; then
        elt_path="$PWD/extra/$3/$2"
    else
        elt_path="$PWD/common/$2"
    fi
    sudo cp "$elt_path" "$1/$2"                         # Cp the file
    echo "sudo cp $elt_path $1/$2"
}

## Script

# If the repo is not in $HOME/.config/.dotfiles
# You can uncomment theses lines to edit the .env file
# if [ -f $PWD/common/.env ]; then
#     sed -i 's#DOT_PATH=.*#DOT_PATH='"$PWD"'#g' $PWD/common/.env
# fi

while getopts hb:e:d:s option; do
    case "${option}" in
        h) echo -e "$help_msg"; exit;;
        b) bak=${OPTARG};;
        e) extra=${OPTARG};;
        d) dst=${OPTARG};;
        s) sleep_hook=true;;
    esac
done

if [ ! -z $extra ]; then
    source $PWD/extra/$extra/.extra_vars
fi

create_dirs "$dst"
create_symlinks "$dst" "$dot_list_home" "$dst/$bak" "$extra"
create_symlinks "$dst/.config" "$dot_list_conf" "$dst/$bak" "$extra"

if [ ! -z $sleep_hook ]; then
    copy_sys_dot "/etc/systemd/system" "suspend@.service" "$extra"
    sudo systemctl enable suspend@$USER.service
fi

exit 0
