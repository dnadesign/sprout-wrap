# 2013-07-09 Install 5.6.10 because 5.6.12 doesn't work with mysql2 gem
# https://github.com/pivotal-sprout/sprout-wrap/issues/11

package "mysql"

require 'pathname'

PASSWORD = node["mysql_root_password"]

# The next two directories will be owned by node['current_user']
DATA_DIR = "/usr/local/var/mysql"
PARENT_DATA_DIR = "/usr/local/var"


[ "#{node['sprout']['home']}/Library/LaunchAgents",
  PARENT_DATA_DIR,
  DATA_DIR ].each do |dir|
  directory dir do
    owner node['sprout']['user']
    action :create
  end
end


ruby_block "copy mysql plist to ~/Library/LaunchAgents" do
  block do
    active_mysql = Pathname.new("/usr/local/bin/mysql").realpath
    plist_location = (active_mysql + "../../"+"homebrew.mxcl.mysql.plist").to_s
    destination = "#{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
    system("cp #{plist_location} #{destination} && chown #{node['sprout']['user']} #{destination}") || raise("Couldn't find the plist")
  end
  not_if { ::File.exists?("#{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mysql.plist") }
end

ruby_block "mysql_install_db" do
  block do
    active_mysql = Pathname.new("/usr/local/bin/mysql").realpath
    basedir = (active_mysql + "../../").to_s
    data_dir = "/usr/local/var/mysql"
    system("mysql_install_db --verbose --user=#{node['sprout']['user']} --basedir=#{basedir} --datadir=#{DATA_DIR} --tmpdir=/tmp && chown #{node['current_user']} #{data_dir}") || raise("Failed initializing mysqldb")
  end
  not_if { File.exists?("/usr/local/var/mysql/mysql/user.MYD")}
end

execute "load the mysql plist into the mac daemon startup" do
  command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
  user node['sprout']['user']
  not_if { system("launchctl list com.mysql.mysqld") }
end

ruby_block "Checking that mysql is running" do
  block do
    Timeout::timeout(60) do
      until system("ls /tmp/mysql.sock")
        sleep 1
      end
    end
  end
end

#execute "set the root password to the default" do
#  command "mysqladmin -uroot password #{PASSWORD}"
#end

execute "insert time zone info" do
  command "mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/XXT/' | mysql -uroot -p#{PASSWORD} mysql"
  not_if "mysql -uroot -p#{PASSWORD} mysql -e 'select * from time_zone_name' | grep -q UTC"
end
