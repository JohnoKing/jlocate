jlocate
=======
_Multi-process implementation of locate(1)_  
This is a small multi-process implementation of locate(1) with configurable 
compression.

## Installation
To install jlocate, run `make install` (does not override any existing implementations of locate(1))
Your user must be a member of the 'wheel' group to read the database.

## Configuration
The config file is /etc/jlocate.rc, which can configure the location of 
the database, as well as the program and flags used for compression.
