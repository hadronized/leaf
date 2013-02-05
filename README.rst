leaf User Guide
===============

This document helps you getting started with ``leaf``.

I – Download / install
----------------------

You have two options to download and install ``leaf``. You can either get the latest stable git branch
of the projet, or you can get the latest ``leaf`` cabal package. There’s in theory no big differents between
those options.

1. by git
~~~~~~~~~

Get the latest branch with git clone:

    $ git clone git://github.com/skypers/leaf.git

Then ``cd`` in the project root directory, and simply install ``leaf``:

    $ cd leaf
    # cabal install

If you just want to install ``leaf`` on your home or test it, prefer not to install it the regular way but:

    $ cabal install --prefix=$HOME --user

2. by hackagedb
~~~~~~~~~~~~~~~

Simply install ``leaf`` through cabal:

    # cabal update
    # cabal install leaf

II - Using leaf
---------------

Using ``leaf`` is quite simple. Invoking ``leaf`` with no arguments prints anything you have to know and its CLI
commands.

You first have to invoke ``leaf -i your_name`` to initiate a directory in which you’ll find two subdirs: ``leaf``
and ``www`. 
