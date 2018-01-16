# Always-used packages
sudo pacman -S --nocnofirm git openssh tmux chromium firefox compton i3 htop lightdm rofi xbindkeys zip

# Fonts
sudo pacman -S --noconfirm adobe-source-code-pro-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts ttf-dejavu ttf-freefont ttf-ubuntu-font-family ttf-liberation

# Sound
sudo pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-jack pamixer

# ZSH
sudo pacman -S --noconfirm zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm $(echo $HOME)/.zshrc
ln -s $(echo $HOME)/code/dotfiles/.zshrc $(echo $HOME)/.zshrc
source $(echo $HOME)/.zshrc

# VIM
sudo pacman -S --noconfirm vim
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
sudo pacman -S --noconfirm postgresql
echo "postgres password: "
sudo passwd postgres
sudo initdb --locale $LANG -E UTF8 -D '/var/lib/postrgres/data'
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Redis
sudo pacman -S --noconfirm redis
sudo systemctl enable redis
sudo systemctl start redis

# Memcached
sudo pacman -S --noconfirm memcached
sudo systemctl enable memcached
sudo systemctl start memcached

# Other configs
ln -s $(echo $HOME)/code/dotfiles/.tmux.conf $(echo $HOME)/.tmux.conf
ln -s $(echo $HOME)/code/dotfiles/.Xresources $(echo $HOME)/.Xresources
ln -s $(echo $HOME)/code/dotfiles/zsh_aliases.sh $(echo $HOME)/zsh_aliases.sh
mkdir -p $(echo $HOME)/.config
ln -s $(echo $HOME)/code/dotfiles/.config/i3 $(echo $HOME)/.config/i3
ln -s $(echo $HOME)/code/dotfiles/.config/termite $(echo $HOME)/.config/termite
mkdir -p $(echo $HOME)/.config/Code/User
ln -s $(echo $HOME)/code/dotfiles/.config/Code/User/settings.json $(echo $HOME)/.config/Code/User/settings.json

git config --global user.email "stillintop@gmail.com"
git config --global user.name "Artem Rashev"
