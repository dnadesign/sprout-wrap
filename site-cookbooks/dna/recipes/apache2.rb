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

brew "djl/apache2/apache22"

template "/usr/local/etc/apache2/httpd.conf" do
  source "httpd.conf.erb"
  owner node['current_user']
end

template "/Library/LaunchDaemons/homebrew.mxcl.apachectl.plist" do
  source "homebrew.mxcl.apachectl.plist"
  owner 'root'
end