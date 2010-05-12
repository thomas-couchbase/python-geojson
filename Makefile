ROOTCMD      = fakeroot
BUILD_NUMBER ?= 1

.PHONY: debian/changelog

debian/changelog:
	-git branch -D changelog
	git checkout -b changelog
	git-dch -a --debian-branch changelog --snapshot \
            --snapshot-number=$(BUILD_NUMBER)

dist:
	mkdir -p $@

deb: debian/changelog dist
	dpkg-buildpackage -r$(ROOTCMD) -us -uc
	mv ../python-geojson_* dist/

sdist:
	python setup.py sdist

clean:
	rm -rf dist
	$(ROOTCMD) debian/rules clean