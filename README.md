# sprout-wrap

Prepares a Mac running OS X Mountain Lion for web development at DNA using [soloist](https://github.com/mkocher/soloist) and [Sprout](https://github.com/pivotal-sprout/sprout).

This DNA implementation differs as we not only do Ruby work but a mix of PHP,
Node.js and a variety of other technologies.

## Installation

### 1. Install XCode

[![Xcode - Apple](http://r.mzstatic.com/images/web/linkmaker/badge_macappstore-lrg.gif)](https://itunes.apple.com/us/app/xcode/id497799835?mt=12&uo=4)

### 2. Install Command Line Tools

	xcode-select --install

Accept the license terms (requested upon first command called provided by tools - e.g. git)

	sudo git --help
	q
	agree

### 3. Clone this project

    mkdir -p ~/Scripts
    git clone https://github.com/dnadesign/sprout-wrap.git ~/Scripts/dna_sprout
    cd ~/Scripts/dna_sprout

### 4. Install soloist & and other required gems

    sudo gem install bundler
    sudo ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future bundle install

### 5. Run soloist

    bundle exec soloist

## Troubleshooting

	`Chef Client is running hangs`

Remove the pid file from `/var/chef/cache/chef-client-running.pid`.

For issues with installing homebrew libraries:

	brew update
	brew doctor
	# move or delete any "Unexpected dylibs" shown
	# Update xcode command line tools (e.g. git and compilers etc)
	xcode-select --install

For further debugging the package being installed via homebrew look at the output of running these commands manually:

	brew info PACKAGE
	brew install PACKAGE

Postgresql installation issues:

	brew uninstall postgresql
	brew install postgresql
	# To re-initialize the postgresql db (deletes all data)
	rm -rf /usr/local/var/postgres
	initdb -D /usr/local/var/postgres -E utf8
	createuser $(whoami)
	createdb $(whoami)
	createuser postgres

## Configuration

Check the soloistc file for the packages in use and site-cookbooks/dna for a
complete list but at a high level this project adds the following installations
(mostly through homebrew)

	- PHP 5.4 (with our usual extensions)
	- Apache 2.4
	- MySQL, PostgreSQL, Redis, Mongo (incl backend GUIs for those)
	- Node, NPM, Grunt development tools
	- Unit / Behaviour testing frameworks (PHPUnit, XDebug..)
	- Ruby, Jekyll core
	- Capistrano for deployments
	- Tested with Wordpress, SilverStripe, Capistrano, Jekyll
	- Dev applications (Colloquy, Tower, FTP, SublimeText2)
	- Bash improvements (dotfiles)
	- Misc configuration for consistency

This also sets the machine up to use wildcard domains. Projects in ~/Sites are
automatically accessible at site.dev

For more details consult the Welcome To DNA PDF containing the introduction to
your machine.

## Getting updates

To keep your machine consistent with any packages that we need for clients or
other work, update this project through git pull and run `bundle exec soloist`
again. You may want to restart your terminal window in that event as the
updates will muck with your bash session.

If you know a specific recipe has been updated and you just need to run soloist
with the recipe as the argument

	bundle exec soloist run_recipe dna:dotfiles

