# Common packages
sudo dnf install sudo dnf install util-linux-user

# ZSH
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm $(echo $HOME)/.zshrc
ln -s $(echo $HOME)/code/dotfiles/.zshrc $(echo $HOME)/.zshrc
chsh -s $(which zsh) $(echo $USERNAME)
source $(echo $HOME)/.zshrc

# VIM
sudo dnf install vim
ln -s $(echo $HOME)/code/dotfiles/.vimrc $(echo $HOME)/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Ruby
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
rvm install ruby

# Other configs
ln -s $(echo $HOME)/code/dotfiles/.tmux.conf $(echo $HOME)/.tmux.conf
ln -s $(echo $HOME)/code/dotfiles/.Xresources $(echo $HOME)/.Xresources
ln -s $(echo $HOME)/code/dotfiles/zsh_aliases.sh $(echo $HOME)/zsh_aliases.sh
mkdir -p $(echo $HOME)/.config
ln -s $(echo $HOME)/code/dotfiles/.config/i3 $(echo $HOME)/.config/i3
ln -s $(echo $HOME)/code/dotfiles/.config/termite $(echo $HOME)/.config/termite

git config --global user.email "stillintop@gmail.com"
git config --global user.name "Artem Rashev"
