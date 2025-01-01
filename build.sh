#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install blivet-gui alacarte waydroid gns3-server


# this would install a package from rpmfusion
# rpm-ostree install vlc

# this would install a package from a other repo
rpm-ostree install VirtualBox || virtualbox_failed=1

if [ ${virtualbox_failed:-0} -eq 1 ]; then
    echo "Failed to install VirtualBox. retry to build akmods"
    akmodsbuild /usr/src/akmods/VirtualBox-kmod.latest
    vboxconfig
fi

# configure pacakage
usermod -aG vboxusers $USER

#### Example for enabling a System Unit File
# systemctl enable podman.socket
systemctl enable waydroid-container.service
