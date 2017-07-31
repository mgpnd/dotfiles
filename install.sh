# Common packages
sudo dnf -y group install "Development Tools"
sudo dnf -y install util-linux-user

# ZSH
sudo dnf -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm $(echo $HOME)/.zshrc
ln -s $(echo $HOME)/code/dotfiles/.zshrc $(echo $HOME)/.zshrc
source $(echo $HOME)/.zshrc

# VIM
sudo dnf -y install vim-enhanced
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
sudo dnf -y install postgresql postgresql-devel postgresql-server postgresql-contrib
sudo postgresql-setup --initdb --unit postgresql
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Other configs
ln -s $(echo $HOME)/code/dotfiles/.tmux.conf $(echo $HOME)/.tmux.conf
ln -s $(echo $HOME)/code/dotfiles/.Xresources $(echo $HOME)/.Xresources
ln -s $(echo $HOME)/code/dotfiles/zsh_aliases.sh $(echo $HOME)/zsh_aliases.sh
mkdir -p $(echo $HOME)/.config
ln -s $(echo $HOME)/code/dotfiles/.config/i3 $(echo $HOME)/.config/i3
ln -s $(echo $HOME)/code/dotfiles/.config/termite $(echo $HOME)/.config/termite

git config --global user.email "stillintop@gmail.com"
git config --global user.name "Artem Rashev"

# Set close button to the left corner in gnome
gsettings set org.gnome.desktop.wm.preferences button-layout 'close:'
