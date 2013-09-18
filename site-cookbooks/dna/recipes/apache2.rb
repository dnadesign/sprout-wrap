include_recipe "sprout-osx-base::homebrew"
include_recipe "dna::folders"

execute "tap the djl repo" do
    command "brew tap djl/homebrew-apache2"
    not_if { system("brew tap | grep 'djl' > /dev/null 2>&1") }
end

template "#{node['sprout']['home']}/Sites/tools/setdocroot.php" do
  source "setdocroot.php"
  owner node['current_user']
end

execute "fix permissions on docroot" do
  command "chmod -R 755 #{node['sprout']['home']}/Sites/tools/setdocroot.php"
end

brew "djl/apache2/apache22"

template "/usr/local/Cellar/apache22/2.2.25/conf/httpd.conf" do
  source "httpd.conf.erb"
  owner node['current_user']
end

template "#{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.apachectl.plist" do
  source "homebrew.mxcl.apachectl.plist"
  owner node['current_user']
end

execute "load apachectl via launchctl" do
  command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.apachectl.plist"
  owner node['current_user']
  not_if "launchctl list | grep apache"
end