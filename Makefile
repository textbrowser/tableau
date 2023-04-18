all:
	$(MAKE) -C Source -f Makefile

build-debian-amd64: distcleanall purge
	$(MAKE) -C Source -f Makefile -j 10
	Tools/make_debian_amd64.bash

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
	--exclude RPMBUILD \
	--exclude TableauSrc.tar.gz

clean:
	$(MAKE) -C Source -f Makefile clean

debug:
	$(MAKE) -C Source -f Makefile debug

distclean: clean purge
	$(MAKE) -C Source -f Makefile distclean
	rm -fr Build

distcleanall: distclean rpm-distclean

install: all
	$(MAKE) -C Source -f Makefile install

purge:
	$(MAKE) -C Source -f Makefile purge
	find . -name '*~*' -exec rm {} \;

qwt:
	./Tools/qwt.bash

rpm-distclean:
	rm -fr RPMBUILD/BUILD \
	       RPMBUILD/BUILDROOT \
	       RPMBUILD/RPMS \
	       RPMBUILD/SOURCES \
	       RPMBUILD/SRPMS
	rm -fr TableauSrc.tar.gz
