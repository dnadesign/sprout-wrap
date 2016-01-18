include_recipe "dna::folders"

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

package "homebrew/apache/httpd24"

template "/usr/local/etc/apache2/2.4/httpd.conf" do
  source "httpd.conf.erb"
  owner node['current_user']
end

execute "Load HTTPD at boot" do
  command "cp -fv /usr/local/opt/httpd24/homebrew.mxcl.httpd24.plist /Library/LaunchDaemons/ &&
           chown -v root:wheel /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist &&
           sudo chmod -v 644 /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist"
  not_if { ::File.exists?("/Library/LaunchDaemons/homebrew.mxcl.httpd24.plist") }
end

# execute "stop stock system apache" do
#   command "launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist"
#   not_if "launchctl list | grep org.apache.httpd"
# end

execute "load apache"   do
  command "launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist"
  not_if "launchctl list | grep httpd24"
end
