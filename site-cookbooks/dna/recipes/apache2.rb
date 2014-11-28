include_recipe "sprout-osx-base::homebrew"
include_recipe "dna::folders"

execute "tap the homebrew/apache repo" do
    command "brew tap homebrew/apache"
    not_if { system("brew tap | grep 'apache' > /dev/null 2>&1") }
end

template "#{node['sprout']['home']}/Sites/tools/setdocroot.php" do
  source "setdocroot.php"
  owner node['current_user']
end

template "#{node['sprout']['home']}/Sites/tools/php.prepend.php" do
  source "php.prepend.php"
  owner node['current_user']
  mode "0755"
end

template "#{node['sprout']['home']}/Sites/tools/php.append.php" do
  source "php.append.php"
  owner node['current_user']
  mode "0755"
end

execute "fix permissions on docroot" do
  command "chmod -R 755 #{node['sprout']['home']}/Sites/tools/setdocroot.php"
end

brew "homebrew/apache/httpd24"

template "/usr/local/etc/apache2/2.4/httpd.conf" do
  source "httpd.conf.erb"
  owner node['current_user']
end

execute "Load HTTPD at boot" do
  command "ln -sfv /usr/local/opt/httpd24/*.plist ~/Library/LaunchAgents/"
end
