#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common ffmpeg-mini

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
if [ "${DEVEL_RELEASE-}" = 1 ]; then
	package=melonds-git
else
	package=melonds
fi

make-aur-package "$package"
pacman -Q "$package" | awk '{print $2; exit}' > ~/version
