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

::

    $ git clone git://github.com/skypers/leaf.git

Then ``cd`` in the project root directory, and simply install ``leaf``:

::

    $ cd leaf
    # cabal install

If you just want to install ``leaf`` in your home  directory or test it, prefer not to install it the regular way but:

::

    $ cabal install --prefix=$HOME --user

2. by hackagedb
~~~~~~~~~~~~~~~

Simply install ``leaf`` through cabal:

::

    # cabal update
    # cabal install leaf

II - Using leaf
---------------

Using ``leaf`` is quite simple. Invoking ``leaf`` with no arguments prints anything you have to know.

You first have to invoke ``leaf -i your_name`` to initiate a directory in which you’ll find two subdirs: ``leaf``
and ``www``.  The first one is the directory in which you’ll find anything you edit. The second one contains the
HTML version of your portfolio.

The first thing you can do is to copy all the stylesheets (CSS) in the ``www`` folder. That will let you choose
later how your portfolio must be rendered. Here how to do on unix systems:

::

    $ cp /opt/leaf/css/* www

Then, you can start to fulfil the ``wrapper.leaf`` file in ``leaf``.

1. ``wrapper.leaf``
~~~~~~~~~~~~~~~~~~~

That file contains all general information about you. You start with a template file (there are many
``[ something ]``). You just have to replace them with the correct information. For instance, replace
``Firstname: [ your firstname ]`` with ``Firstname: Henry``.

For the ``Items`` entry, you have to separate each item with comma, and don’t use any space.

For the ``Style`` entry, type the name of the stylesheet to use, discarding the extension. Feel free to test
and contribute with new themes!

2. Bootstrap your portfolio
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once the ``wrapper.leaf`` file is fulfilled, you can bootstrap your portfolio. It will generate for you
the files you have to put your content inside:

::

    $ leaf -b

Edit all the ``.leafc`` files. It’s full markdown syntax. When you’re done, you can generate the HTML version of
your portfolio.

3. HTML generation
~~~~~~~~~~~~~~~~~~

To generate the HTML version of your portfolio:

::

    $ leaf -g

That will _always_ update the HTML files in ``www``. If you have local changes in the ``www``, you may want to
backup them before running that command.
