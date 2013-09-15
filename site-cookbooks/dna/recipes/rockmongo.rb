#
# Downloads RockMongo into the sites/tools folder. It is then available at
# tools.dev/rockmongo
#
unless File.exists?("#{node['sprout']['home']}/Sites/tools/rockmongo")
  remote_file "#{Chef::Config[:file_cache_path]}/rockmongo.zip" do
    source "http://rockmongo.com/release/rockmongo-1.1.5.zip"
    owner node['current_user']
  end

  execute "unzip RockMongo" do
    # -o to override
    command "unzip -o #{Chef::Config[:file_cache_path]}/rockmongo.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "Ensure that the tools folder exists in $HOME/Sites/tools" do
	command "mkdir -p #{node['sprout']['home']}/Sites && mkdir -p #{node['sprout']['home']}/Sites/tools"
	user node['current_user']
  end

  execute "copy RockMongo to $HOME/Sites/tools/rockmongo" do
    command "mv #{Chef::Config[:file_cache_path]}/rockmongo #{node['sprout']['home']}/Sites/tools/"
    user node['current_user']
    group "admin"
  end
end
