#!/usr/bin/env ksh

# installing minimal app set

sudo pkg_add arandr cabextract catfish cmake cmixer compton e2fsprogs ffmpeg firefox gcc \
gnome-themes-extra gpicview htop ibm-plex innoextract mac-telnet mozilla-dicts-be \
mozilla-dicts-ru mozilla-dicts-uk mygui neofetch ninja nitrogen nmap noto-cjk obconf \
obfs4proxy obmenu openal openbox openscenegraph py3-pip qtstyleplugins qttools ru-ptsans \
sdl2 slim slim-themes tilda tint2 tor-browser tshark unifont unshield unzip-6.0p13-iconv \
vim wget xfe

cp gtkrc /etc/gtk-2.0/
cp settings.ini /etc/gtk-3.0/
cp warp /etc/tor/
sudo mkdir /var/log/tor/
sudo touch /var/log/tor/notices.log
sudo touch /var/log/tor/debug.log
sudo chown -R _tor:_tor /var/log/tor/
sudo chmod 700 /var/log/tor/

ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz
cd /usr
sudo tar xzvf /tmp/ports.tar.gz
sudo sh -c "echo 'WRKOBJDIR=/usr/obj/ports' > /etc/mk.conf"
sudo sh -c "echo 'DISTDIR=/usr/distfiles' >> /etc/mk.conf"
sudo sh -c "echo 'PACKAGE_REPOSITORY=/usr/packages' >> /etc/mk.conf"
cd ports/fonts/msttcorefonts/
sudo make install
cd /tmp

# applying post-install settings

sudo sh -c "echo wsmoused_flags=-p /dev/ums0 > /etc/rc.conf.local"
sudo sh -c "echo tor_flags=-f /etc/tor/warp >> /etc/rc.conf.local"
sudo sh -c "echo pkg_scripts="messagebus" >> /etc/rc.conf.local"
sudo sh -c "echo /usr/local/bin/slim -d > /etc/rc.local"
#sudo sh -c "echo kern.audio.record=1 >> /etc/sysctl.conf"
echo 'exec openbox-session' > ~/.xinitrc

# setting up zsh

sudo pkg_add zsh
echo 'export QT_QPA_PLATFORMTHEME=gtk2' > ~/.zprofile
sudo cp ~/.zprofile /root
