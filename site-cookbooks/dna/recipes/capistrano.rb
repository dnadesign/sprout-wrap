# gem_package causes error on our particular build on Gems
# http://stackoverflow.com/questions/15328369/error-executing-action-install-on-resource-chef-gemmysql-installing-ruby
execute "Install capistrano" do
	command "gem install capistrano -v 2.15.5"
end

execute "Install capistrano friends" do
	command "gem install railsless-deploy capistrano_rsync_with_remote_cache"
end