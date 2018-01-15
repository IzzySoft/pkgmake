As a software developer, you sometimes want to release a new version of your
product. For most of my programs, the steps for this process are quite
identical:

  1. Make a copy of the source tree, e.g. `cp -pr /usr/src/prog /tmp/prog-0.1.2`
  1. Cleanup the copy, e.g. remove all `CVS/*` and/or `.svn/*` files if they exist
  1. Make a tarball of that copy and remove the copy
  1. Place the tarball in the `SOURCES/` directory of your build directory
  1. Edit the `.spec` file
  1. run rpmbuild or debbuild

pkgmake was written to automate these steps. What it basically does, is:

  1. It makes the copy (see the `-d` command line switch)
  1. It cleans up that copy
  1. It makes the tarball, and…
  1. ...places it in the `SOURCES/` directory
  1. It generates the needed `.spec` file out of a given template (see `-t` switch) and the information passed on the command line (see general syntax)
  1. It runs rpmbuild or debbuild, depending on your configuration

Looks like a complete automated build process? Well, almost. In most cases you
will still have to fiddle around with the `%files` section of the `.spec` file, 
unless your source 100% reflects the final location of the files as seen from
the root (/) directory - in which case the `__DIR__` placeholder can be used in 
the .spec template file (see `man pkgmake.tpl` after installation.

For more details, please see the project wiki.