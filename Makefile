all:
	@echo "Available commands:"
	@grep "^[^#[:space:]].*:$$" Makefile | sort

install:
	sudo gem install bundler
    sudo ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future bundle
	caffeinate bundle exec soloist

install_recipe:
	caffeinate bundle exec soloist run_recipe $(recipe)