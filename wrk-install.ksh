#!/usr/bin/env ksh

# installing app set
sudo pkg_add arandr audacity cmixer compton dia filezilla fvwm2 gcc gigolo gimp gmrun gns3 \
gpicview htop innoextract lame libreoffice libreoffice-i18n-ru mozilla-dicts-be \
mozilla-dicts-ru mozilla-dicts-uk neofetch nitrogen nmap-zenmap noto-cjk obfs4proxy \
p5-XML-Parser pcmanfm putty py3-pip qbittorrent qemu qtstyleplugins seamonkey slim \
slim-themes tkabber-plugins tor tshark unifont unzip-6.0p13-iconv vim vlc wget \
xsane-0.999p4-gimp zathura zathura-djvu

# applying post-install settings
cd /tmp
git clone https://github.com/bfmartin/fvwm-config-on-openbsd.git
cd fvwm-config-on-openbsd
chmod +x ./bin/install.sh
sh ./bin/install.sh
cd ..
ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz
cd /usr
sudo tar xzvf /tmp/ports.tar.gz
echo 'exec fvwm' > ~/.xinitrc
sudo sh -c "echo 'WRKOBJDIR=/usr/obj/ports' > /etc/mk.conf"
sudo sh -c "echo 'DISTDIR=/usr/distfiles' >> /etc/mk.conf"
sudo sh -c "echo 'PACKAGE_REPOSITORY=/usr/packages' >> /etc/mk.conf"
sudo sh -c "echo wsmoused_flags=-p /dev/ums0 > /etc/rc.conf.local"
sudo sh -c "echo pkg_scripts="avahi_daemon messagebus" >> /etc/rc.conf.local"
sudo sh -c "echo dbus_daemon="YES" >> /etc/rc.conf.local"
sudo sh -c "echo /usr/local/bin/slim -d > /etc/rc.local"
#sudo sh -c "echo kern.audio.record=1 >> /etc/sysctl.conf"

# setting up zsh
sudo pkg_add zsh
echo 'export QT_QPA_PLATFORMTHEME=gtk2' > ~/.zprofile
sudo cp ~/.zprofile /root
