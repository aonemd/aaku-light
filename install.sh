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

ln -sfn ${BASEDIR}/git/gitconfig $HOME/.gitconfig
ln -sfn ${BASEDIR}/git/gitignore $HOME/.gitignore
ln -sfn ${BASEDIR}/git/gitattributes $HOME/.gitattributes

ln -sfn ${BASEDIR}/tmux/tmux.conf $HOME/.tmux.conf
ln -sfn ${BASEDIR}/rg/rgignore $HOME/.rgignore

[ -d $HOME/.ctags.d/ ] || mkdir -p $HOME/.ctags.d
ln -sfn ${BASEDIR}/ctags/ctags $HOME/.ctags.d/default.ctags

ln -sfn ${BASEDIR}/ruby/irbrc $HOME/.irbrc
ln -sfn ${BASEDIR}/scheme/csirc $HOME/.csirc

echo "Installing Vim plugins..."
vim -E -c PlugInstall -c qall
vim -c 'CocInstall -sync coc-go coc-tsserver coc-html coc-css coc-emmet coc-solargraph|q'

echo "Source Zsh files..."
source $HOME/.zshrc

if [ -n $DISPLAY ]; then
  [ -d $HOME/Workspace/fonts/ ] && exit

  echo "Installing Fonts..."
  git clone https://github.com/powerline/fonts.git $HOME/Workspace/fonts/
  pushd $HOME/Workspace/fonts && ./install.sh && popd
fi
