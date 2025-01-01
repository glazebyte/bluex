#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install blivet-gui alacarte waydroid @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras gns3-server

# this would install a package from rpmfusion
# rpm-ostree install vlc

# this would install a package from a other repo
rpm-ostree install VirtualBox-7.1

# configure pacakage
usermod -aG vboxusers $USER

#### Example for enabling a System Unit File
# systemctl enable podman.socket
systemctl enable waydroid-container.service
