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

# Variables
CC     := cc
CFLAGS := -O2 -fno-math-errno -fomit-frame-pointer -pipe

# Compile jfork(1)
all:
	$(CC) $(CFLAGS) -o jfork fork.c $(LDFLAGS)

# Install jlocate without overriding existing implementations of locate(1)
install:
	mkdir -p $(DESTDIR)/etc $(DESTDIR)/usr/local/bin $(DESTDIR)/usr/local/man/man1
	install -Dm0644 jlocate.rc $(DESTDIR)/etc
	install -Dm0644 fork.1 $(DESTDIR)/usr/local/man/man1/jfork.1
	install -Dm0755 jfork jlocate jupdatedb $(DESTDIR)/usr/local/bin

# Remove jlocate from the system
uninstall:
	rm -rf $(DESTDIR)/etc/jlocate.rc $(DESTDIR)/usr/local/bin/jlocate $(DESTDIR)/usr/local/bin/jupdatedb $(DESTDIR)/usr/local/man/man1/jfork.1 $(DESTDIR)/usr/local/bin/jfork $(DESTDIR)/var/db/jlocate

# Deletes the compiled jfork binary
clean:
	rm -f jfork

# Calls clean, then resets the git repo
clobber: clean
	git reset --hard
