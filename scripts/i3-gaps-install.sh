#!/bin/bash

sudo apt install -y \
  libxcb1-dev \
  libxcb-keysyms1-dev \
  libpango1.0-dev \
  libxcb-util0-dev \
  libxcb-icccm4-dev \
  libyajl-dev \
  libstartup-notification0-dev \
  libxcb-randr0-dev \
  libev-dev \
  libxcb-cursor-dev \
  libxcb-xinerama0-dev \
  libxcb-xkb-dev \
  libxkbcommon-dev \
  libxkbcommon-x11-dev \
  autoconf \
  libxcb-xrm-dev \
  i3status \
  i3lock

if ! i3_loc="$(type -p i3)" || [[ -z $i3_loc ]]; then
  if ! i3 --version | grep -Fq gaps-next
  then
    ######  i3-gaps install ######
    cd $HOME/.dotfiles/repos

    # clone the repository
    if [ -d "i3-gaps" ]; then
      cd i3-gaps; git pull
    else
      git clone https://www.github.com/Airblader/i3 i3-gaps
      cd i3-gaps
    fi

    # compile & install
    autoreconf --force --install
    rm -rf build/
    mkdir -p build && cd build/

    # Disabling sanitizers is important for release versions!
    # The prefix and sysconfdir are, obviously, dependent on the distribution.
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make
    sudo make install
  fi
fi
