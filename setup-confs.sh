RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RESET='\033[0m'

OS=`uname -s`
if [ $OS == "Darwin" ];
    then
    echo -e "${GREEN}Setting up macOS Dependencies, be sure Hombrew is installed!${RESET}"
    brew install tmux
    brew install ranger
    brew install fzf
else
    echo -e "${RED}LINUX WIP DEBIAN ONLY${RESET}"
    apt install tmux
    apt install ranger
    apt install fzf
fi

# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
        echo -e "${YELLOW}Installing vim-plug files${RESET}"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
        echo -e "${GREEN}vim-plug files already installed${RESET}"
fi

cd /opt && git clone https://github.com/tmux-plugins/tmux-logging.git

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
echo -e "${GREEN}DONE!${RESET}"
