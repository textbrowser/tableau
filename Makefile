all:
	$(MAKE) -C Source -f Makefile

build-all-rpms-x86_64: build-rpm build-rpm-qt4-x86_64

build-debian-amd64: distcleanall purge
	$(MAKE) -C Source -f Makefile -j 5
	Tools/make_debian_amd64.bash

build-debug-rpm: build-src
	mkdir -p RPMBUILD/BUILD
	mkdir -p RPMBUILD/RPMS
	mkdir -p RPMBUILD/SOURCES
	mkdir -p RPMBUILD/SRPMS
	cp -p TableauSrc.tar.gz RPMBUILD/SOURCES/.
	rm -f TableauSrc.tar.gz
	rpmbuild --define '_debug debug' --define '_topdir %(pwd)/RPMBUILD' \
	-ba RPMBUILD/SPECS/tableau.spec

build-distribution: distcleanall purge
	$(MAKE) -C Source -f Makefile install
	tar -cvzf TableauDist.tar.gz \
	Build Data/Databases Data/Displays \
	Desktop Documentation Qwt/Library Source/UI/Icons \
	--exclude icons.qrc

build-rpm: build-src
	mkdir -p RPMBUILD/BUILD
	mkdir -p RPMBUILD/RPMS
	mkdir -p RPMBUILD/SOURCES
	mkdir -p RPMBUILD/SRPMS
	cp -p TableauSrc.tar.gz RPMBUILD/SOURCES/.
	rm -f TableauSrc.tar.gz
	rpmbuild --define '_topdir %(pwd)/RPMBUILD' \
	-ba RPMBUILD/SPECS/tableau.spec

build-src: distcleanall purge
	tar -cvzf TableauSrc.tar.gz `ls` \
	--exclude TableauSrc.tar.gz \
	--exclude RPMBUILD

clean:
	$(MAKE) -C Source -f Makefile clean

debug:
	$(MAKE) -C Source -f Makefile debug

distclean: clean purge
	$(MAKE) -C Source -f Makefile distclean
	rm -fr Build

distcleanall: deb-distclean distclean rpm-distclean

install: all
	$(MAKE) -C Source -f Makefile install

purge:
	$(MAKE) -C Source -f Makefile purge
	find . -name '*~*' -exec rm {} \;

qwt:
	./Tools/qwt.bash

rpm-distclean:
	rm -fr RPMBUILD/BUILD RPMBUILD/BUILDROOT \
	RPMBUILD/SOURCES RPMBUILD/RPMS RPMBUILD/SRPMS
	rm -fr TableauSrc.tar.gz
