all:
	@echo "Available commands:"
	@grep "^[^#[:space:]].*:$$" Makefile | sort

install:
	bundle exec soloist

install_recipe:
	bundle exec soloist run_recipe $(recipe)	
