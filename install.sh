#!/usr/bin/env zsh

BASEDIR="$(cd "$(dirname "${ZSH_SOURCE[0]}")" && pwd)"

echo "Updating submodules..."
git submodule update --init --recursive --remote

echo "Linking files..."
ln -sfn ${BASEDIR}/vim/vim $HOME/.vim
ln -sfn ${BASEDIR}/vim/vimrc $HOME/.vimrc
ln -sfn ${BASEDIR}/vim/gvimrc $HOME/.gvimrc

ln -sfn ${BASEDIR}/zsh/zsh $HOME/.zsh
ln -sfn ${BASEDIR}/zsh/zprofile $HOME/.zprofile
ln -sfn ${BASEDIR}/zsh/zshenv $HOME/.zshenv
ln -sfn ${BASEDIR}/zsh/zshrc $HOME/.zshrc

ln -sfn ${BASEDIR}/tmux/tmux.conf $HOME/.tmux.conf
ln -sfn ${BASEDIR}/git/gitconfig $HOME/.gitconfig
ln -sfn ${BASEDIR}/ag/agignore $HOME/.agignore

echo "Installing Vim plugins..."
vim -E -c PlugInstall -c qall

echo "Source Zsh files"
source $HOME/.zshrc

mkdir  $HOME/Workspace

if [[ $DISPLAY ]]; then
  [ -d $HOME/Workspace/fonts/ ] && exit
  echo "Installing Fonts..."
  git clone https://github.com/powerline/fonts.git $HOME/Workspace/fonts/
  pushd $HOME/Workspace/fonts && ./install.sh && popd

  git clone https://github.com/sebastiencs/icons-in-terminal.git $HOME/Workspace/fonts/icons-in-terminal
  pushd $HOME/Workspace/fonts/icons-in-terminal && ./install.sh && popd
fi
