#!/usr/bin/env ksh

# installing minimal app set
sudo pkg_add arandr cmixer fvwm2+fvicons gcc htop mc mozilla-dicts-be mozilla-dicts-ru \
mozilla-dicts-uk noto-cjk obfs4proxy seamonkey slim slim-themes tor unifont \
unzip-6.0p13-iconv vim wget

# installing additional app set
#sudo pkg_add cmus compton innoextract mcabber mediainfo mpv neofetch nmap rtorrent \
#tshark zathura zathura-djvu

# applying post-install settings
cd /tmp
wget http://prdownloads.sourceforge.net/fvwm-themes/fvwm-themes-0.7.0.tar.gz
wget http://prdownloads.sourceforge.net/fvwm-themes/fvwm-themes-extra-0.7.0.tar.gz
tar xzvf fvwm-themes-0.7.0.tar.gz
cd fvwm-themes-0.7.0
./configure
make && sudo make install
cd ..
fvwm-themes-config --site --install fvwm-themes-extra-0.7.0.tar.gz
ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz
cd /usr
sudo tar xzvf /tmp/ports.tar.gz
echo 'exec fvwm-themes-start' > ~/.xinitrc
sudo sh -c "echo 'WRKOBJDIR=/usr/obj/ports' > /etc/mk.conf"
sudo sh -c "echo 'DISTDIR=/usr/distfiles' >> /etc/mk.conf"
sudo sh -c "echo 'PACKAGE_REPOSITORY=/usr/packages' >> /etc/mk.conf"
sudo sh -c "echo wsmoused_flags=-p /dev/ums0 > /etc/rc.conf.local"
sudo sh -c "echo pkg_scripts="messagebus" >> /etc/rc.conf.local"
sudo sh -c "echo dbus_daemon="YES" >> /etc/rc.conf.local"
#sudo sh -c "echo kern.audio.record=1 >> /etc/sysctl.conf"

# setting up zsh
sudo pkg_add zsh
#echo 'export QT_QPA_PLATFORMTHEME=gtk2' > ~/.zprofile
#sudo cp ~/.zprofile /root
