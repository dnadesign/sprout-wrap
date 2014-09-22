include_recipe "pivotal_workstation::create_var_chef_cache"
include_recipe "pivotal_workstation::sshd_on"
include_recipe "pivotal_workstation::screen_sharing_app"
include_recipe "pivotal_workstation::screen_sharing_on"
# include_recipe "pivotal_workstation::set_screensaver_preferences"
include_recipe "pivotal_workstation::keyboard_preferences"
include_recipe "dna::dotfiles"

# Turn on develop bar
osx_defaults "set safari to show develop bar" do
  domain 'com.apple.safari'
  key 'WebKitDeveloperExtras'
  boolean true
end
