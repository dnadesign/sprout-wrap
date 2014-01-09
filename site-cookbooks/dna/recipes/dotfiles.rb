include_recipe "dna::folders"

#
# Download dotfiles
#
git "Download dnadesign/dotfiles" do
  repository "http://github.com/dnadesign/dotfiles.git"
  destination "#{node['sprout']['home']}/Scripts/dotfiles"
  action :sync
  user node['current_user']
  not_if { ::File.exists?("#{node['sprout']['home']}/Scripts/dotfiles") }
end

#
# Download gitprompt
#
git "Download lvv/git-prompt" do
  repository "http://github.com/lvv/git-prompt.git"
  destination "#{node['sprout']['home']}/Scripts/git-prompt"
  reference "eeff805e0bcdab5317ed1027bef2b625a8f7f94b"
  action :sync
end

execute "Install dotfiles" do
  command "#{node['sprout']['home']}/Scripts/dotfiles/bootstrap.sh link -f"
  user node['current_user']
end