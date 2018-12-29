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
else
    echo -e "${GREEN}LINUX WIP DEBIAN ONLY${RESET}"
    sudo apt install tmux
    sudo apt install ranger
    sudo apt install fzf
    sudo apt install neofetch 
    sudo apt install git
    sudo apt install wget
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
    
fi

# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
        echo -e "${YELLOW}Installing vim-plug files${RESET}"
        mkdir -p ~/.vim/autoload/
        wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
else
        echo -e "${GREEN}vim-plug files already installed${RESET}"
fi

git clone https://github.com/tmux-plugins/tmux-logging.git

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
