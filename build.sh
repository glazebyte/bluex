#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

virtualbox_failed=0


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install blivet-gui alacarte waydroid gns3-server VirtualBox
akmods --force --kernels "${KERNEL}" --kmod VirtualBox
modinfo /usr/lib/modules/${KERNEL}/extra/VirtualBox/{vboxdrv,vboxnetadp,vboxnetflt}.ko.xz > /dev/null \
|| (find /var/cache/akmods/VirtualBox/ -name \*.log -print -exec cat {} \; && exit 1)


# this would install a package from rpmfusion
# rpm-ostree install vlc


#### Example for enabling a System Unit File
# systemctl enable podman.socket
systemctl enable waydroid-container.service
