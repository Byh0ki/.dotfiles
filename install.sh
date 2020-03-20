#!/bin/bash

## Get dotfiles real path

SOURCE="${BASH_SOURCE[0]}"
# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]; do
    dotfiles_path="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
dotfiles_path="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

## Variables declarations

# You should only edit theses var if you want to add a new dotfile
dot_list_home=".profile .bash_profile .zprofile .aliases .bashrc .gitconfig .gitconfig_cri .gitignore .gtkrc-2.0 .vimrc .xinitrc .Xresources .zshCustom .zshrc"
dot_list_conf="dunst compton.conf gtk-3.0 i3 i3utils i3status neofetch wallpapers"

# Extra directories
include_extra_home=""
include_extra_conf=""
exclude_extra=""

# Internal script vars
bak=".bak"
clean_bak="$HOME/.clean"
dst="$HOME"

## Functions declarations

usage()
{
    echo -e "./$(basename "$0")   [-h] [-s] [-b backup dir] [-e extra_dir] [-d dst_dir]"
    echo
    echo -e "               [-h] display this help message"
    echo -e "               [-s] activate the hook for suspend /!\\ root access needed /!\\"
    echo -e "               [-b] change backup directory"
    echo -e "               [-e] the script will prioritize a file from the extra_dir if it exist"
    echo -e "               [-d] change the default destination directory for the symlinks"
}

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
    if [[ -f "$path" || -d "$path" ]]; then                 # File or dir already exist
        if [ -L "$path" ]; then                             # Is a symlink
            rm "$path"
        else                                                # Is a regular file
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
    if [[ -f "$path" || -d "$path" ]]; then                 # File or dir already exist
        sudo mv "$path" "$3/$2.old"
    fi
}

clean_list()
{
    # $1 : dst dir
    # $2 : list of dotfiles
    # $3 : backup path
    for elt in $2; do
        backup "$1" "$elt" "$3"
    done
}

clean_dots()
{
    # $1 : backup folder before delete
    mkdir -p "$1"
    clean_list "$dst" "$dot_list_home" "$1"
    clean_list "$dst/.config" "$dot_list_conf" "$1"
    if [[ -n "$include_extra_home" || -n "$include_extra_conf" ]]; then
        echo "Cleaning files from extra dir..."
        clean_list "$dst" "$include_extra_home" "$1"
        clean_list "$dst/.config" "$include_extra_conf" "$1"
    fi
    if [ "$(ls -A "$1" | wc -l)" -ne 0 ]; then
        echo "This are the list of files that will be deleted :"
        ls --color=auto -A "$1"
        # Ask the user if he is sure to delete the files
        read -p "Are you sure? [Y|n] " -r
        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
            echo "rm -rf' $1"
            rm -rf "$1"
        fi
    else
        echo "Nothing to clean."
    fi
}

create_symlinks()
{
    # $1 : dst dir
    # $2 : list of dotfiles
    # $3 : backup path
    # $4 : pick file from the extra folder
    for elt in $2; do
        if [ ! "$(contain "$exclude_extra" "$elt")" ]; then
            backup "$1" "$elt" "$3"                         # Backup
            if [ -n "$4" ] && [[ -f "$dotfiles_path/extra/$4/$elt" || -d "$dotfiles_path/extra/$4/$elt" ]]; then
                elt_path="$dotfiles_path/extra/$4/$elt"
            else
                elt_path="$dotfiles_path/common/$elt"
            fi
            ln -s "$elt_path" "$1/$elt"                     # Create the final symlink
            echo "ln -s $elt_path $1/$elt"
        fi
    done
}

copy_sys_dot()
{
    # $1 : dst dir
    # $2 : dotfile
    # $3 : pick file from the extra folder
    if [ ! "$(contain "$exclude_extra" "$2")" ]; then
        backup_sys "$1" "$2" "$1"                     # Backup
        if [ -n "$3" ] && [[ -f "extra/$3/$2" || -d "extra/$3/$2" ]]; then
            elt_path="$dotfiles_path/extra/$3/$2"
        else
            elt_path="$dotfiles_path/common/$2"
        fi
        sudo cp "$elt_path" "$1/$2"                         # Cp the file
        echo "sudo cp $elt_path $1/$2"
    fi
}

## Script

# If the repo is not in $HOME/.config/.dotfiles
# You can uncomment theses lines to edit the .env file
# if [ -f $dotfiles_path/common/.env ]; then
#     sed -i 's#DOT_PATH=.*#DOT_PATH='"$dotfiles_path"'#g' $dotfiles_path/common/.env
# fi

while getopts hb:e:d:sc option; do
    case "${option}" in
        h) usage; exit 0;;
        b) bak=${OPTARG};;
        e) extra=${OPTARG};;
        d) dst=${OPTARG};;
        s) sleep_hook=1;;
        c) clean_hook=1;;
        *) usage; exit 1;;
    esac
done

if [ -n "$extra" ]; then
    if [ ! -d "$dotfiles_path/extra/$extra" ]; then
        echo "This extra directory doesn't exist."
        exit 2
    fi
    if [ -f "$dotfiles_path/extra/$extra/.extra_vars" ]; then
        # shellcheck source=/dev/null
        source "$dotfiles_path/extra/$extra/.extra_vars"
    fi
fi

if [ -n "$clean_hook" ]; then
    clean_dots "$clean_bak"
    exit 0
fi

echo "Creating directories if needed..."
create_dirs "$dst"
echo "Creating symlinks..."
create_symlinks "$dst" "$dot_list_home" "$dst/$bak" "$extra"
create_symlinks "$dst/.config" "$dot_list_conf" "$dst/$bak" "$extra"
if [[ -n "$include_extra_home" || -n "$include_extra_conf" ]]; then
    echo "Creating symlink for extra dir..."
    create_symlinks "$dst" "$include_extra_home" "$dst/$bak" "$extra"
    create_symlinks "$dst/.config" "$include_extra_conf" "$dst/$bak" "$extra"
fi

if [ -n "$sleep_hook" ]; then
    copy_sys_dot "/etc/systemd/system" "suspend@.service" "$extra"
    sudo systemctl enable suspend@"$USER".service
fi

exit 0
