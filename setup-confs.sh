RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RESET='\033[0m'

#Make sure we are in the configs repo in home in case I ran this script outside of the configs dir
cd ~/configs

OS=`uname -s`
if [ $OS == "Darwin" ];
    then
    echo -e "${GREEN}Setting up macOS Dependencies${RESET}"
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
    fi
    brew install tmux
    brew install ranger
    brew install fzf
    brew install neofetch
    brew install git
    brew install wget
    brew install curl --with-openssl
    brew install golang
else
    echo -e "${GREEN}LINUX DEBIAN ONLY${RESET}"
    sudo apt install tmux
    sudo apt install ranger
    sudo apt install fzf
    sudo apt install neofetch 
    sudo apt install git
    sudo apt install wget
    sudo apt install golang  
echo -e "${YELLOW}Do you want to set up URXVT on this box?(y/N)${RESET}"
    read TERM_CHECK
    if [ $TERM_CHECK == "y" ] || [ $TERM_CHECK == "Y" ];
        then
        echo -e "${YELLOW}Setting up URXVT and its Symlinks...${RESET}"
        sudo apt install rxvt-unicode
        rm ~/.Xresources
        rm ~/.xinitrc
        ln -s ~/configs/Xresources ~/.Xresources
        ln -s ~/configs/xinitrc ~/.xinitrc
        echo -e "${GREEN}URXVT Setup Done!${RESET}"
    
    else
        echo -e "${GREEN}Skipping URXVT set up...${RESET}"
    fi

    KALI=`uname -r | grep -o "kali"`
    if [ $KALI == "kali" ];
        then
        echo -e "${YELLOW}Kali Linux detected...setting up 1337 h@x0r stuffz${RESET}"
        # WIP
        sudo apt install gobuster
        sudo apt install empire
        sudo apt install veil
        sudo apt install virtualbox
        sudo apt install vagrant
        cd /opt/
        # Quack Dependencies
        apt install gconf-service gconf2 gconf2-common gvfs-bin libgconf-2-4
        wget https://github.com/3ndG4me/Quack/raw/master/release-builds/Quack_1.0.0_amd64.deb -O /opt/quack.deb
        sudo dpkg -i quack.deb
        rm quack.deb
        mkdir cutter
        wget https://github.com/radareorg/cutter/releases/download/v1.7.3/Cutter-v1.7.3-x64.Linux.AppImage -O /opt/cutter/Cutter
        chmod +x /opt/cutter/Cutter
        mkdir ida
        wget https://out7.hex-rays.com/files/idafree70_linux.run -O /opt/ida/ida_setup.run
        chmod +x /opt/ida/ida_setup.run
        /opt/ida/ida_setup.run
        rm -rf /opt/ida
        git clone https://github.com/Ne0nd0g/merlin.git
        git clone https://github.com/danielmiessler/SecLists.git
        cd ~/configs
        echo -e "${YELLOW}Creating Kali Specific Symlinks...${RESET}"
        echo -e "${RED}REMOVING EXISTING CONFIGS!!!${RESET}"
        rm  ~/.gdbinit
        
        # GDB
        ln -s ~/configs/gdbinit ~/.gdbinit
    fi
fi

# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
        echo -e "${YELLOW}Installing vim-plug files${RESET}"
        mkdir -p ~/.vim/autoload/
        wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
else
        echo -e "${GREEN}vim-plug files already installed${RESET}"
fi

# Get tmux-logging plugin
rm -rf ~/.tmux-logging
mkdir ~/.tmux-logging
cd ~/.tmux-logging/ && git clone https://github.com/tmux-plugins/tmux-logging.git
cd ~/configs

# Create Symlinks
echo -e "${YELLOW}Creating Symlinks...${RESET}"
echo -e "${RED}REMOVING EXISTING CONFIGS!!!${RESET}"
rm ~/.bashrc
rm ~/.bash_profile
rm ~/.vimrc
rm ~/.tmux.conf
rm -rf ~/.config/ranger

    # Bash
ln -s ~/configs/bash_configs/bashrc ~/.bashrc
ln -s ~/configs/bash_configs/bash_profile ~/.bash_profile

    # VIM
ln -s ~/configs/vimrc ~/.vimrc

    # TMUX
ln -s ~/configs/tmux.conf ~/.tmux.conf

    # Ranger
ln -s ~/configs/ranger ~/.config/ranger
echo -e "${YELLOW}Grabbing Meslo Font for Powerline...${RESET}"
wget https://github.com/powerline/fonts/raw/master/Meslo%20Dotted/Meslo%20LG%20L%20DZ%20Regular%20for%20Powerline.ttf
echo -e "${YELLOW}Be sure to manually set this in your terminal if on macOS or not using URXVT!${RESET}"
echo -e "${GREEN}DONE!${RESET}"
