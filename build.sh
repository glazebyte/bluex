#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
KERNEL="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
wget wget https://packages.microsoft.com/keys/microsoft.asc
curl https://packages.microsoft.com/yumrepos/edge/config.repo | tee > /etc/yum.repos.d/microsoft-edge.repo
# this installs a package from fedora repos
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install blivet-gui appeditor waydroid gns3-server VirtualBox microsoft-edge-stable /tmp/rpms/kmods/kmod-VirtualBox*.rpm


# this would install a package from rpmfusion
# rpm-ostree install vlc


#### Example for enabling a System Unit File
# systemctl enable podman.socket
systemctl enable waydroid-container.service
