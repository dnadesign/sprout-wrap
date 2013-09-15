include_recipe "dna::folders"

#
# Download dotfiles
#
git "Download wilr/dotfiles" do
  repository "http://github.com/wilr/dotfiles.git"
  destination "#{node['sprout']['home']}/Scripts/dotfiles"
  action :sync
  user node['current_user']
end

#
# Download gitprompt
#
git "Download lvv/git-prompt" do
  repository "http://github.com/lvv/git-prompt.git"
  destination "#{node['sprout']['home']}/Scripts/git-prompt"
  action :sync
end

execute "Install dotfiles" do
  command "#{node['sprout']['home']}/Scripts/dotfiles/bootstrap.sh link -f"
  user node['current_user']
end