unless File.exists?("/Applications/Colloquy.app")

  remote_file "#{Chef::Config[:file_cache_path]}/Colloquy.zip" do
    source "http://colloquy.info/downloads/colloquy-latest.zip"
    owner node['current_user']
  end

  execute "unzip Colloquy" do
    command "unzip #{Chef::Config[:file_cache_path]}/Colloquy.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy Colloquy to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Colloquy.app #{Regexp.escape("/Applications/Colloquy.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if Colloquy.app was installed" do
    block do
      raise "Colloquy.app was not installed" unless File.exists?("/Applications/Colloquy.app")
    end
  end
end
