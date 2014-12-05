execute "Set the open files limit" do
  command "launchctl limit maxfiles 65536 65536"
end

cookbook_file 'limit.maxfiles.plist' do
  path '/Library/LaunchDaemons/limit.maxfiles.plist'
  # Ownership and permissions are important here
  owner 'root'
  group 'wheel'
  mode '0644'
end

cookbook_file 'limit.maxproc.plist' do
  path '/Library/LaunchDaemons/limit.maxproc.plist'
  # Ownership and permissions are important here
  owner 'root'
  group 'wheel'
  mode '0644'
end
