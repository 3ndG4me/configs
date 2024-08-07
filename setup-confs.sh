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
        brew upgrade
    fi
    brew install tmux
    brew install ranger
    brew install ansifilter
    brew install fzf
    brew install neofetch
    brew install git
    brew install wget
    brew install curl
    brew install golang
    brew install --cask docker
    echo -e "${YELLOW}Pausing to allow manual Docker Desktop setup, press enter to continue...${RESET}"
    echo -e "${YELLOW}(DON'T FORGET TO ADD YOURSELF TO THE DOCKER GROUP)${RESET}"
    read
    
    if [[ $1 == "hack" ]]; then
        brew install gobuster
        brew install sqlmap
        brew install john
        brew install hashcat
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall && rm msfinstall
    fi
else
    echo -e "${GREEN}LINUX DEBIAN ONLY${RESET}"
    sudo apt update
    sudo apt upgrade
    sudo apt install tmux
    sudo apt install ranger
    sudo apt install fzf
    sudo apt install neofetch 
    sudo apt install git
    sudo apt install wget
    sudo apt install golang 
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable Docker
    sudo usermod -aG docker $USER
    sudo apt install virtualbox
    sudo apt install vagrant
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && sudo ./msfinstall && rm msfinstall
    read

    KALI=`uname -r | grep -o "kali"`
    if [ $KALI == "kali" ];
        then
        echo -e "${YELLOW}Kali Linux detected...setting up 1337 h@x0r stuffz${RESET}"
        # WIP
        sudo apt install gobuster
        sudo apt install powershell-empire
        sudo apt install veil
        sudo apt install virtualbox
        sudo apt install vagrant
        mkdir ~/tools
        cd ~/tools
        # Quack Dependencies
        sudo apt install gconf-service gconf2 gconf2-common gvfs-bin libgconf-2-4
        wget https://github.com/3ndG4me/Quack/raw/master/release-builds/Quack_1.0.0_amd64.deb -O ~/tools/quack.deb
        sudo dpkg -i quack.deb
        rm quack.deb
        mkdir cutter
        wget https://github.com/rizinorg/cutter/releases/download/v2.3.4/Cutter-v2.3.4-Linux-x86_64.AppImage -O ~/tools/cutter/Cutter
        chmod +x ~/tools/cutter/Cutter
        mkdir ida
        wget https://out7.hex-rays.com/files/idafree84_linux.run -O ~/tools/ida/ida_setup.run
        chmod +x ~/tools/ida/ida_setup.run
        ~/tools/ida/ida_setup.run
        rm -rf ~/tools/ida
        cd ~/configs
        echo -e "${YELLOW}Creating Kali Specific Symlinks...${RESET}"
        echo -e "${RED}REMOVING EXISTING CONFIGS!!!${RESET}"
        rm  ~/.gdbinit
        
        # GDB
        ln -s ~/configs/gdbinit ~/.gdbinit
    fi
fi


if [[ $2 == "tools" ]]; then
    echo -e "${GREEN}Setting up 3rd Party Tools${RESET}"
    mkdir -p ~/tools
    cd ~/tools

    echo -e "${YELLOW}Cloning and setting up Impacket...${RESET}"
    git clone https://github.com/SecureAuthCorp/impacket.git
    cd impacket
    python3 -m venv impacket-env
    source impacket-env/bin/activate
    pip3 install .
    deactivate
    cd ..

    echo -e "${YELLOW}Cloning and setting up Sliver C2...${RESET}"
    git clone https://github.com/BishopFox/sliver.git
    cd sliver
    sudo docker build -t sliver .
    sudo docker run -d --name sliver_tmp sliver:latest
    mkdir BINS
    sudo docker cp sliver_tmp:/opt/sliver-server BINS/sliver-server-linux-bleeding
    sleep 10
    sudo docker rm sliver_tmp
    cd BINS
    wget https://github.com/BishopFox/sliver/releases/download/v1.5.42/sliver-client_linux.zip
    wget https://github.com/BishopFox/sliver/releases/download/v1.5.42/sliver-server_linux.zip
    unzip sliver-client_linux.zip
    unzip sliver-server_linux.zip
    cd ..
    cd ..

    echo -e "${YELLOW}Cloning and setting up Merlin C2...${RESET}"
    git clone https://github.com/Ne0nd0g/merlin.git
    cd merlin
    make server-darwin
    make server-linux
    cd ..

    echo -e "${YELLOW}Cloning and setting up PvJRedCell...${RESET}"
    git clone git@github.com:dichotomy/PvJRedCell.git

    echo -e "${YELLOW}Cloning and setting up AgentSmith C2...${RESET}"
    git clone git@github.com:3ndG4me/AgentSmith.git

    echo -e "${YELLOW}Cloning and setting up Gortscanner...${RESET}"
    git clone https://github.com/3ndG4me/Gortscanner

    echo -e "${YELLOW}Cloning and setting up KaliLists and SecLists...${RESET}"
    git clone https://github.com/3ndG4me/KaliLists
    git clone https://github.com/danielmiessler/SecLists.git

    echo -e "${YELLOW}Cloning and setting up Terraform Offsec Tools...${RESET}"
    git clone git@github.com:InjectionSoftwareandSecurityLLC/terraform-offsec.git

    echo -e "${YELLOW}Cloning and setting up GScripts Sample Repo...${RESET}"
    git clone https://github.com/ahhh/gscripts.git

    echo -e "${YELLOW}Cloning and setting up Lalyos UPX Container...${RESET}"
    sudo docker pull lalyos/upx:latest

    cd ~/configs
fi

# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
        echo -e "${YELLOW}Installing vim-plug files${RESET}"
        mkdir -p ~/.vim/autoload/
        wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
else
        echo -e "${GREEN}vim-plug files already installed${RESET}"
fi

# Get tmux plugin manager
rm -rf ~/.tmux/plugins/tpm
mkdir -p ~/.tmux/plugins/tpm
cd ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm
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

if [ $SHELL == "/bin/zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm ~/.zshrc
    rm ~/.oh-my-zsh/themes/hax.zsh-theme
    ln -s ~/configs/zsh_configs/zshrc ~/.zshrc
    ln -s ~/configs/zsh_configs/hax.zsh-theme ~/.oh-my-zsh/themes/hax.zsh-theme
fi


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
