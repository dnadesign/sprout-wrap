execute "Install Grunt" do
  command "npm install -g grunt-cli"
  not_if "which grunt"
end

execute "Ensure that Grunt has enough files to watch" do
  command "launchctl limit maxfiles 10480 10480"
end