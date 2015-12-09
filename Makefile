#! /bin/make -f

all:
	@echo 'Run steam with "./steam" or install it with "sudo make install"'

install: install-bin install-docs install-icons install-bootstrap install-desktop install-apt-source

install-bin:
	install -d -m 755 $(DESTDIR)$(PREFIX)/bin/
	install -p -m 755 $(PACKAGE) $(DESTDIR)$(PREFIX)/bin/
	install -p -m 755 $(PACKAGE)deps $(DESTDIR)$(PREFIX)/bin/

install-docs:
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/doc/$(PACKAGE)/
	install -p -m 644 README steam_install_agreement.txt $(DESTDIR)$(PREFIX)/share/doc/$(PACKAGE)/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/man/man6/
	install -m 644 $(PACKAGE).6 $(DESTDIR)$(PREFIX)/share/man/man6/

install-icons:
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/icons/hicolor/16x16/apps/
	install -p -m 644 icons/16/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/icons/hicolor/16x16/apps/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/icons/hicolor/24x24/apps/
	install -p -m 644 icons/24/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/icons/hicolor/24x24/apps/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/icons/hicolor/256x256/apps/
	install -p -m 644 icons/256/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/icons/hicolor/256x256/apps/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/icons/hicolor/32x32/apps/
	install -p -m 644 icons/32/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/icons/hicolor/32x32/apps/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/icons/hicolor/48x48/apps/
	install -p -m 644 icons/48/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/icons/hicolor/48x48/apps/
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/pixmaps/
	install -p -m 644 icons/48/$(PACKAGE).png $(DESTDIR)$(PREFIX)/share/pixmaps/
	install -p -m 644 icons/48/$(PACKAGE)_tray_mono.png $(DESTDIR)$(PREFIX)/share/pixmaps

install-bootstrap:
	install -d -m 755 $(DESTDIR)$(PREFIX)/lib/$(PACKAGE)/
	install -p -m 644 bootstraplinux_ubuntu12_32.tar.xz $(DESTDIR)$(PREFIX)/lib/$(PACKAGE)/

install-desktop:
	install -d -m 755 $(DESTDIR)$(PREFIX)/share/applications/
	install -p -m 644 steam.desktop $(DESTDIR)$(PREFIX)/share/applications/

install-apt-source:
	if [ -d /etc/apt ]; then \
		install -d -m 755 $(DESTDIR)/etc/apt/sources.list.d/; \
		install -p -m 644 steam.list $(DESTDIR)/etc/apt/sources.list.d/; \
		install -d -m 700 $(CURDIR)/gpg; \
		gpg --homedir=$(CURDIR)/gpg --no-default-keyring --keyring=$(CURDIR)/steam.gpg --import steam-key.asc; \
		install -d -m 755 $(DESTDIR)/etc/apt/trusted.gpg.d/; \
		install -p -m 644 steam.gpg $(DESTDIR)/etc/apt/trusted.gpg.d/; \
		rm -rf $(CURDIR)/steam.gpg* $(CURDIR)/gpg; \
	fi

#########################
CLIENT=../../../../client
BINARIES=$(CLIENT)/ubuntu12_32
PACKAGE=steam
PREFIX?=/usr

RUNTIME_FILES := \
	steam-runtime/COPYING						\
	steam-runtime/README.txt					\
	steam-runtime/common-licenses					\
	steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1		\
	steam-runtime/i386/usr/lib/gcc/i686-linux-gnu/4.6.3		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6.0.18	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libX11.so.6		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libX11.so.6.3.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXau.so.6		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXau.so.6.0.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1.1.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXdmcp.so.6		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXdmcp.so.6.0.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXext.so.6		\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXext.so.6.4.0 	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXinerama.so.1	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXinerama.so.1.0.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXrandr.so.2 \
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXrandr.so.2.2.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXrender.so.1	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libXrender.so.1.3.0	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libfreetype.so.6	\
	steam-runtime/i386/usr/lib/i386-linux-gnu/libfreetype.so.6.8.0	\
	steam-runtime/i386/usr/share/doc/gcc-4.6-base/copyright		\
	steam-runtime/i386/usr/share/doc/libgcc1			\
	steam-runtime/i386/usr/share/doc/libstdc++6			\
	steam-runtime/i386/usr/share/doc/libx11-6/copyright		\
	steam-runtime/i386/usr/share/doc/libxau6/copyright		\
	steam-runtime/i386/usr/share/doc/libxcb1/copyright		\
	steam-runtime/i386/usr/share/doc/libxrandr2/copyright		\
	steam-runtime/i386/usr/share/doc/libxrender1/copyright		\
	steam-runtime/i386/usr/share/doc/libfreetype6/copyright		\
	steam-runtime/i386/usr/share/doc/libxdmcp6/copyright


check-version:
	./check_version.sh $(CLIENT)/bin_steam.sh debian/changelog

source-package: check-version
	install -p -m 755 $(CLIENT)/bin_steam.sh $(PACKAGE)
	install -p -m 755 $(CLIENT)/bin_steamdeps.py $(PACKAGE)deps
	install -p -m 644 $(CLIENT)/steam_install_agreement.txt .
	install -p -m 644 $(CLIENT)/public/steam_tray_mono.png icons/48/$(PACKAGE)_tray_mono.png
	mkdir -p bootstrap/ubuntu12_32
	mkdir -p bootstrap/linux32
	install -p -m 755 $(CLIENT)/linux32/steamerrorreporter bootstrap/linux32
	install -p -m 644 $(CLIENT)/steam_install_agreement.txt bootstrap/
	install -p -m 755 $(CLIENT)/steam.sh bootstrap/
	install -p -m 644 $(CLIENT)/steamdeps.txt bootstrap/
	install -p -m 755 $(BINARIES)/steam bootstrap/ubuntu12_32/
	install -p -m 755 $(BINARIES)/crashhandler.so bootstrap/ubuntu12_32/
	cat $(BINARIES)/steam-runtime.tar.xz.part* | tar xJf - -C bootstrap/ubuntu12_32/ $(RUNTIME_FILES)
	(cd bootstrap; tar caf ../bootstraplinux_ubuntu12_32.tar.xz *)
	rm -rf bootstrap
	dpkg-buildpackage -S -us -uc

.PHONY: all install install-bin install-docs install-icons install-bootstrap install-desktop install-apt-source check-version source-package
