#!/usr/bin/env python

### Script main entry

import os
import sys

import lib.common as common
import framework.dispatch as dispatch

def main():
    workdir = common.getworkdir()
    print "work directory: %s" % (workdir)
    ## add for import path
    srcdir = common.getfiledir(__file__)
    sys.path.append(srcdir)
    
    dispatcher = dispatch.Dispatch(workdir, srcdir, sys.argv);
    dispatcher.run()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print "\nUser Press Ctrl+C, exit\n"
