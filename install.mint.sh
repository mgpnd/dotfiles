# Common packages
sudo apt-get -y install build-essential
sudo apt-get -y install util-linux

# ZSH
sudo apt-get -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm $(echo $HOME)/.zshrc
ln -s $(echo $HOME)/code/dotfiles/.zshrc $(echo $HOME)/.zshrc
source $(rach $HOME)/.zshrc

# VIM
sudo apt-get -y install vim
ln -s $(echo $HOME)/code/dotfiles/.vimrc $(echo $HOME)/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Ruby
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
rvm install ruby

# Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# PostgreSQL
postgresql libpq-dev
sudo postgresql-setup --initdb --unit postgresql
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Redis
sudo apt-get -y install redis-server
sudo systemctl enable redis
sudo systemctl start redis

# Other configs
ln -snf $(echo $HOME)/code/dotfiles/.Xresources $(echo $HOME)/.Xresources
ln -snf $(echo $HOME)/code/dotfiles/.tmux.conf $(echo $HOME)/.tmux.conf
ln -snf $(echo $HOME)/code/dotfiles/zsh_aliases.sh $(echo $HOME)/zsh_aliases.sh
mkdir -p $(echo $HOME)/.config
ln -snf $(echo $HOME)/code/dotfiles/.config/i3 $(echo $HOME)/.config/i3
ln -snf $(echo $HOME)/code/dotfiles/.config/termite $(echo $HOME)/.config/termite
mkdir -p $(echo $HOME)/.config/Code/User
ln -snf $(echo $HOME)/code/dotfiles/.config/Code/User/settings.json $(echo $HOME)/.config/Code/User/settings.json

git config --global user.email "stillintop@gmail.com"
git config --global user.name "Artem Rashev"
