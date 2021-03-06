include Make.include

DISTFILES=\
add-xscreensaver \
COMPILE \
COPYING \
ChangeLog \
debian/ \
Make.include.in \
Makefile \
README \
TODO \
config.h.in \
configure \
configure.ac \
fireflies.spec.in \
fireflies.xml \
install-sh \
installit.in \
libgfx-1.1.0/ \
win32/

all:	libgfx-1.1.0/src/libgfx.a
	cd src && make

libgfx-1.1.0/src/libgfx.a:
	cd libgfx-1.1.0 && echo CONFIGURE && ./configure && echo CONFIGURE DONE && cd src && make

install: all
	sh ./installit $(DESTDIR)

clean:
	make -C src clean
	make -C win32 clean

dist:
	rm -rf fireflies-$(VERSION)
	mkdir fireflies-$(VERSION)
	cp -a src fireflies-$(VERSION)
	cp -a $(DISTFILES) fireflies-$(VERSION)

	# need Make.include temporarily to run make
	cp Make.include fireflies-$(VERSION)
	make -C fireflies-$(VERSION) clean
	rm -f fireflies-$(VERSION)/Make.include

	# don't want to include debian's buildroot
	rm -rf fireflies-$(VERSION)/debian/fireflies

	tar czf fireflies-$(VERSION).tar.gz fireflies-$(VERSION)
	rm -rf fireflies-$(VERSION)
