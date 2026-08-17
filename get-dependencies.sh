#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common ffmpeg-mini

if [ "${DEVEL_RELEASE-}" = 1 ]; then
	package=melonds-git
else
	package=melonds
fi

make-aur-package "$package"
pacman -Q "$package" | awk '{print $2; exit}' > ~/version
