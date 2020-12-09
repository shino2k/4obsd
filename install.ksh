#!/usr/bin/env ksh

# installing minimal app set
sudo pkg_add cmus compton gcc gmrun gnome-themes-extra innoextract make mc mcabber \
mediainfo mozilla-dicts-be mozilla-dicts-ru mozilla-dicts-uk mpv noto-cjk obconf \
obmenu openbox pavucontrol rtorrent seamonkey slim slim-themes tilda tint2 tor-browser \
unifont unzip-6.0p13-iconv vim zsh

# installing ports tree
cd /tmp
ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz
cd /usr
sudo tar xzvf /tmp/ports.tar.gz
sudo sh -c "echo 'WRKOBJDIR=/usr/obj/ports' > /etc/mk.conf"
sudo sh -c "echo 'DISTDIR=/usr/distfiles' >> /etc/mk.conf"
sudo sh -c "echo 'PACKAGE_REPOSITORY=/usr/packages' >> /etc/mk.conf"

# applying post-install settings
echo 'exec openbox-session' > ~/.xinitrc
sudo sh -c "echo '/etc/rc.d/slim start' > /etc/rc.local"
sudo sh -c "echo 'pkg_scripts="messagebus"' > /etc/rc.conf.local"
sudo sh -c "echo 'dbus_daemon=YES' >> /etc/rc.conf.local"
