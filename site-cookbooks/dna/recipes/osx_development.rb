directory "/Users/#{node['current_user']}/Library/LaunchAgents" do
  owner node['current_user']
  action :create
end

include_recipe "dna-dotfiles"
include_recipe "dna::sublime_text_3"
include_recipe "pivotal_workstation::git_config_global_defaults"
include_recipe "pivotal_workstation::github_for_mac"
include_recipe "sprout-osx-apps::imagemagick"
include_recipe "sprout-osx-apps::svn"
include_recipe "sprout-osx-apps::pg_admin"
include_recipe "sprout-osx-settings::global_environment_variables"
include_recipe "sprout-osx-apps::iterm2"
include_recipe "sprout-osx-base::homebrew"
include_recipe "pivotal_workstation::unix_essentials"
include_recipe "sprout-osx-apps::vagrant"
include_recipe "pivotal_workstation::vim"
# include_recipe "pivotal_workstation::vim_config"
include_recipe "sprout-osx-apps::ctags_exuberant"
include_recipe "sprout-osx-apps::virtualbox"
include_recipe "pivotal_workstation::workspace_directory"
include_recipe "dna::apache2"
include_recipe "sprout-osx-apps::hub"
include_recipe "sprout-osx-apps::selenium_webdriver"
include_recipe "sprout-osx-apps::solr"
include_recipe "sprout-osx-apps::activemq"
include_recipe "sprout-osx-apps::erlang"
include_recipe "sprout-osx-apps::pg_admin"
include_recipe "pivotal_workstation::mongodb"
include_recipe "sprout-osx-apps::node_js"
# include_recipe "pivotal_workstation::rvm"
include_recipe "pivotal_workstation::gem_setup"
include_recipe "dna::mysql"
# include_recipe "pivotal_workstation::postgres"
# include_recipe "pivotal_workstation::qt"
include_recipe "dna::cleanup"
include_recipe "dna::autoconf" # fixes issue with compiling PHP extensions
include_recipe "dna::phpsmtp"
include_recipe "dna::php"
include_recipe "dna::dnsmasq" # *.dev wildcard
include_recipe "dna::gruntjs"
# include_recipe "dna::rockmongo"
#include_recipe "dna-osx-apps::cyberduck" #now in mac app store
include_recipe "dna::graphviz"
#include_recipe "dna-osx-apps::vmwarefusion"
# include_recipe "dna::huxley"
include_recipe "dna::capistrano"
include_recipe "dna::spidermonkey" # used by DNA Chef
