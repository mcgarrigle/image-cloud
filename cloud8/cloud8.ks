cdrom
install

lang en
keyboard uk
skipx

# -----------------------------------------------

network --hostname=node
network --device=eth0 --noipv6 --bootproto=dhcp

# -----------------------------------------------

authconfig --useshadow --passalgo=sha256 --kickstart

rootpw "letmein"
user --name=rescue --plaintext --password letmein

timezone --utc UTC

# -----------------------------------------------

bootloader --location=mbr --append="nofb quiet splash=quiet"

zerombr
clearpart --all

part / --size=1 --ondisk=vda --grow

# -----------------------------------------------

text
reboot

%packages --ignoremissing
dnf
dhclient
bash-completion
wget
vim
git
cloud-init
cloud-utils-growpart
@Core
%end

%post --log=/root/kickstart-post.log
  echo "UseDNS no" >> /etc/ssh/sshd_config
  echo "rescue ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/rescue
%end
