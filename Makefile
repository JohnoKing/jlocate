# Copyright © 2018-2020 Johnothan King. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Support a prefix of either /usr or /usr/local
prefix := /usr/local

# Tells the user to run `make install`
all:
	@echo 'To install jlocate, run `make install`'

# Install jlocate without overriding existing implementations of locate(1), parsing of #DEF is done here
install:
	@mkdir -p "$(DESTDIR)/etc" "$(DESTDIR)/$(prefix)/bin"
	@if [ ! -e "$(DESTDIR)/etc/jlocate.conf" ]; then install -Dm0644 jlocate.conf "$(DESTDIR)/etc"; fi
	@install -Dm0755 jlocate jupdatedb "$(DESTDIR)/$(prefix)/bin"
	@if [ `uname` = FreeBSD ]; then \
		sed -i '' "/#DEF Linux/,/#ENDEF/d" "$(DESTDIR)/etc/jlocate.conf" ;\
		sed -i '' "/#DEF FreeBSD/d"        "$(DESTDIR)/etc/jlocate.conf" ;\
		sed -i '' "/#ENDEF/d"              "$(DESTDIR)/etc/jlocate.conf" ;\
	else \
		sed -i "/#DEF FreeBSD/,/#ENDEF/d" "$(DESTDIR)/etc/jlocate.conf" ;\
		sed -i "/#DEF Linux/d"            "$(DESTDIR)/etc/jlocate.conf" ;\
		sed -i "/#ENDEF/d"                "$(DESTDIR)/etc/jlocate.conf" ;\
	fi
	@echo "Successfully installed jlocate!"

# Remove jlocate from the system
uninstall:
	@rm -rf "$(DESTDIR)/etc/jlocate.conf" "$(DESTDIR)/$(prefix)/bin/jlocate" "$(DESTDIR)/$(prefix)/bin/jupdatedb" "$(DESTDIR)/var/db/jlocate"
	@echo "Successfully uninstalled jlocate!"

# Optimize the git repo's size
clean:
	@git gc >> /dev/null 2> /dev/null
	@git repack >> /dev/null 2> /dev/null

# Reset the git repo
clobber: clean
	git reset --hard

# Alias for clobber
mrproper: clobber
