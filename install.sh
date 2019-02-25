#!/bin/bash

# Variables declarations

dot_list_home=".env .aliases .bashrc .gitconfig .gitignore .gtkrc-2.0 .vimrc .Xdefaults .xinitrc .Xresources .zshCustom .zshrc"
dot_list_conf="dunst compton.conf gtk-3.0 i3 i3utils i3status neofetch wallpapers"
bak=".bak"
strip_dot=false
help_msg="./bin [-h] display this help message\n
[-b backup dir] change backup directory\n
[-e extra_dir] the script will prioritize a file from the extra_dir if it exist\n
[-d dst_dir] change the default destination directory for the symlinks\n
[-s] strip the '.' at the beginning of the filename"

# Functions declarations

backup()
{
    # $1 : dst dir
    # $2 : filename
    # $3 : backup path
    path="$1/$2"
    if [[ -f $path || -d $path ]]; then                 # File or dir already exist
        if [ -L $path ]; then                           # Is a symlink
            rm $path
        else                                            # Is a regular file
            mv $path "$3/$2.old"
        fi
    fi
}

create_symlinks()
{
    # $1 : dst dir
    # $2 : list of dotfiles
    # $3 : backup path
    # $4 : Strip the dot
    # $5 : pick file from the extra folder
    for elt in $2; do
        if [ $4 = true ]; then                          # Need to strip the dot
            if [[ $elt =~ .* ]]; then                   # Filename has a dot
                elt="${elt:1}"
            fi
        fi
        backup $1 $elt $3           # Backup
        if [[ ! -z $4 && -f "extra/$4/$elt" ]]; then
            elt_path="$PWD/extra/$4/$elt"
        else
            elt_path="$PWD/common/$elt"
        fi
        ln -s "$elt_path" "$1/$elt" # Create the final symlink
        echo "ln -s $elt_path $1/$elt"
    done
}

# Script

# If the repo is not in $HOME/.config/.dotfiles
# You can uncomment theses lines to edit the .env file
# if [ -f $PWD/common/.env ]; then
#     sed -i 's#DOT_PATH=.*#DOT_PATH='"$PWD"'#g' $PWD/common/.env
# fi

while getopts h:b:e:d:s option; do
    case "${option}" in
        h) echo -e $help_msg; exit;;
        b) bak=${OPTARG};;
        e) extra=${OPTARG};;
        d) dst=${OPTARG};;
        s) strip_dot=true;;
    esac
done

if [ ! -z $dst ]; then
    mkdir -p "$dst/$bak"
    full_dot="$dot_list_home $dot_list_conf"
    create_symlinks "$dst" "$full_dot" "$dst/$bak" $strip_dot "$extra"
else
    mkdir -p "$HOME/$bak"
    mkdir -p "$HOME/.config"
    create_symlinks "$HOME" "$dot_list_home" "$HOME/$bak" $strip_dot "$extra"
    create_symlinks "$HOME/.config" "$dot_list_conf" "$HOME/$bak" $strip_dot "$extra"
fi
