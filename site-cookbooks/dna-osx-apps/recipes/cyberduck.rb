unless File.exists?("/Applications/CyberDuck.app")

  remote_file "#{Chef::Config[:file_cache_path]}/CyberDuck.zip" do
    source "http://cyberduck.ch/Cyberduck-4.3.1.zip"
    owner node['current_user']
  end

  execute "unzip CyberDuck" do
    command "unzip #{Chef::Config[:file_cache_path]}/CyberDuck.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy CyberDuck to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/CyberDuck.app #{Regexp.escape("/Applications/CyberDuck.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if CyberDuck.app was installed" do
    block do
      raise "CyberDuck.app was not installed" unless File.exists?("/Applications/CyberDuck.app")
    end
  end
end
