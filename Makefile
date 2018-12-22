# Copyright (c) 2018 Johnothan King. All rights reserved.
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

# Tells the user to run `make install`
all:
	@echo 'To install jlocate, run `make install`'

# Install jlocate without overriding existing implementations of locate(1)
install:
	@mkdir -p $(DESTDIR)/etc $(DESTDIR)/usr/local/bin
	@if [ ! -r $(DESTDIR)/etc/jlocate.rc ]; then install -Dm0644 jlocate.rc $(DESTDIR)/etc; fi
	@install -Dm0755 jlocate jupdatedb $(DESTDIR)/usr/local/bin
	@echo "Successfully installed jlocate!"

# Remove jlocate from the system
uninstall:
	@rm -rf $(DESTDIR)/etc/jlocate.rc $(DESTDIR)/usr/local/bin/jlocate $(DESTDIR)/usr/local/bin/jupdatedb $(DESTDIR)/var/db/jlocate
	@echo "Successfully uninstalled jlocate!"

# Resets the git repo
clobber:
	git reset --hard
