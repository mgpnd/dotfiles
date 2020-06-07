# Common packages
sudo apt -y update
sudo apt -y install build-essential
sudo apt -y install util-linux
sudo apt -y install curl gnupg2 i3 telegram-desktop feh compton rofi htop tmux

# ZSH
sudo apt -y install zsh zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm $(echo $HOME)/.zshrc
ln -s $(echo $HOME)/code/dotfiles/.zshrc $(echo $HOME)/.zshrc
source $(echo $HOME)/.zshrc
sudo chsh -s /usr/bin/zsh

# VIM
sudo apt -y install vim
ln -s $(echo $HOME)/code/dotfiles/.vimrc $(echo $HOME)/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Ruby
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.7

# Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install stable

# Docker
sudo apt -y install apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt -y update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker

# PostgreSQL
sudo apt install postgresql
# Don't install because it's going to be installed with docker
# sudo apt installlibpq-dev
# sudo postgresql-setup --initdb --unit postgresql
# sudo systemctl enable postgresql
# sudo systemctl start postgresql

# Redis
# Don't install because it's going to be installed with docker
sudo apt -y install redis-server
sudo systemctl enable redis-server
sudo systemctl start redis-server

# Cleanup
sudo apt -y autoremove

# Other configs
ln -snf $(echo $HOME)/code/dotfiles/.Xresources $(echo $HOME)/.Xresources
ln -snf $(echo $HOME)/code/dotfiles/.tmux.conf $(echo $HOME)/.tmux.conf
ln -snf $(echo $HOME)/code/dotfiles/zsh_aliases.sh $(echo $HOME)/zsh_aliases.sh
mkdir -p $(echo $HOME)/.config
ln -snf $(echo $HOME)/code/dotfiles/.config/i3 $(echo $HOME)/.config/i3
ln -snf $(echo $HOME)/code/dotfiles/.config/termite $(echo $HOME)/.config/termite
mkdir -p $(echo $HOME)/.config/Code/User
ln -snf $(echo $HOME)/code/dotfiles/.config/Code/User/settings.json $(echo $HOME)/.config/Code/User/settings.json
ln -snf $(echo $HOME)/code/dotfiles/.config/polybar $(echo $HOME)/.config/polybar

git config --global user.email "artem.rashev@protonmail.com"
git config --global user.name "Artem Rashev"

# Steps left:
# 1. Install vte-ng + termite
# 2. Install polybar
