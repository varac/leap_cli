About LEAP command line interface
===================================================

This gem installs an executable 'leap' that allows you to manage servers using the LEAP platform. You can read about the [platform on-line](https://leap.se).

Installation
===================================================

Install prerequisites:

    sudo apt-get install git ruby ruby-dev rsync openssh-client openssl rake

NOTE: leap_cli requires ruby 1.9 or later.

Optionally install Vagrant in order to be able to test with local virtual machines (recommended):

    sudo apt-get install vagrant virtualbox zlib1g-dev

NOTE: the packaged virtualbox and vagrant that comes with Debian and Ubuntu are rather ancient. Most people have better luck by downloading these packages from the upstream:

* https://downloads.vagrantup.com/
* https://www.virtualbox.org/wiki/Downloads

Install the `leap` command:

    sudo apt-get install rake
    git clone https://leap.se/git/leap_cli.git
    cd leap_cli
    rake build

Install as root user (recommended):

    sudo rake install

Install as unprivileged user:

    rake install
    # watch out for the directory leap is installed to, then i.e.
    sudo ln -s ~/.gem/ruby/1.9.1/bin/leap /usr/local/bin/leap

With both methods, you can use now /usr/local/bin/leap, which in most cases will be in your $PATH.

To run directly from a clone of the git repo, see "Development", below.

Usage
===================================================

* Run `leap help` for a help with commands.
* Visit https://leap.se/docs/platform for tutorials and detailed documentation.

Development
===================================================

How to set up your environment for developing the ``leap`` command.

Prerequisites
---------------------------------------------------

Debian Squeeze

    sudo apt-get install git ruby ruby-dev rubygems
    sudo gem install bundler rake
    export PATH=$PATH:/var/lib/gems/1.8/bin

Debian Wheezy

    sudo apt-get install git ruby ruby-dev bundler

Ubuntu

    sudo apt-get install git ruby ruby-dev
    sudo gem install bundler

Install from git
---------------------------------------------------

Download the source:

    git clone https://github.com/leapcode/leap_cli.git
    cd leap_cli

Running from the source directory
---------------------------------------------------

To run the ``leap`` command directly from the source tree, you need to install
the required gems using ``bundle`` and symlink ``bin/leap`` into your path:

    cd leap_cli
    bundle                        # install required gems
    ln -s `pwd`/bin/leap ~/bin    # link executable somewhere in your bin path
    which leap                    # make sure you will run leap_cli/bin/leap
    leap help

If you get an error, make sure to check ``which leap``. Some versions of ``bundle`` will
incorrectly install a broken ``leap`` command in the gem bin directory when you do ``bundle``.

Why not use ``bundle exec leap`` to run the command? This works, so long as your current
working directory is under leap_cli. Because the point is to be able to run ``leap`` in
other places, it is easier to create the symlink. If you run ``leap`` directly, and not via
the command launcher that rubygems installs, leap will run in a mode that simulates
``bundle exec leap`` (i.e. only gems included in Gemfile are allowed to be loaded).

Changes
====================================================

1.7

* requires platform 0.7
* deployment logging (see /var/log/leap)
* compatible with new tapicero
* selectively destroy some dbs with `leap db destroy`
* faster apt-get update
* added `leap scp` command
* bug fixes

1.6.2

* auto generate certs on compile
* use internal ruby md5sum for compatibility on mac
* may override or customize tests by putting tests in `files/tests`
* bug fixes

1.6.1

* requires platform 0.6
* better `leap test run`
* added `leap tunnel` command
* only print stack trace if `--debug` flag was specified
* prompt user to upgrade host ssh key if a better one exists
* bug fixes
