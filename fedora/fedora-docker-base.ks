# This is a minimal Fedora install designed to serve as a Docker base image.
#
# To keep this image minimal it only installs English language. You need to change
# yum configuration in order to enable other languages.

cmdline
bootloader --location=none
timezone America/New_York --utc
rootpw --iscrypted $1$LavxjqeE$jpe3h0.y9.kajMo9hnKfa/
lang en_US.UTF-8

keyboard us
firewall --disable
zerombr
clearpart --all
part / --size 3000 --fstype ext2
network --device eth0 --bootproto dhcp
reboot

%packages --excludedocs
bash
-kernel

%post --log=/tmp/anaconda-post.log

LANG="en_US"
echo "%_install_lang $LANG" > /etc/rpm/macros.image-language-conf

awk '(NF==0&&!done){print "override_install_langs='$LANG'\ntsflags=nodocs";done=1}{print}' \
    < /etc/yum.conf > /etc/yum.conf.new
mv /etc/yum.conf.new /etc/yum.conf

rm -f /usr/lib/locale/locale-archive
rm -rf /var/cache/yum/*

