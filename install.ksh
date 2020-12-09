#!/usr/bin/env ksh

# installing minimal app set
sudo pkg_add cmus compton curl ftp gcc gmrun gnome-themes-extra innoextract libiconv make mc \
mcabber mediainfo mpv noto-cjk obconf obmenu openbox pavucontrol rtorrent seamonkey slim \
slim-themes tilda tint2 tor-browser unifont unzip-iconv vim zsh

# installing ports tree
cd /tmp
ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/{ports.tar.gz,SHA256.sig}
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz
cd /usr
sudo tar xzf /tmp/ports.tar.gz
sudo echo 'WRKOBJDIR=/usr/obj/ports' > /etc/mk.conf
sudo echo 'DISTDIR=/usr/distfiles' >> /etc/mk.conf
sudo echo 'PACKAGE_REPOSITORY=/usr/packages' >> /etc/mk.conf

# applying post-install settings
echo 'exec openbox-session' > ~/.xinitrc
sudo echo '/etc/rc.d/slim start' > /etc/rc.local
sudo echo 'pkg_scripts="messagebus"' > /etc/rc.conf.local
sudo echo 'dbus_daemon=YES' >> /etc/rc.conf.local