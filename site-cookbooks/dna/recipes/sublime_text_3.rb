include_recipe "pivotal_workstation::user_owns_usr_local"

dmg_package "Sublime Text" do
  source "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203047.dmg"
  checksum "7b60d9398514caa000fc65140fc6ac5e9332413489ed86cfcfac248d23b8a303"
  owner node['current_user']
end

link "/usr/local/bin/subl" do
  to "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
end

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text 3", "Packages"]
sublime_user_path = sublime_package_path.dup << "User"

recursive_directories sublime_user_path do
  owner node['current_user']
end

# The rest of the sublime configuration is keep in dotfiles
include_recipe "dna::dotfiles"

# Fix permission
recursive_directories(["#{node['sprout']['home']}/Library/Application Support", "Sublime Text 3", "Installed Packages"]) do
  owner node['current_user']
end

# Link the sublime configuration
# execute "Install dotfiles sublime configuration" do
#  command "#{node['sprout']['home']}/Scripts/dotfiles/bootstrap.sh subl -f"
#  user node['current_user']
# end