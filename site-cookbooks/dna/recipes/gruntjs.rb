package "node"

execute "Install Grunt" do
  
  command "npm install -g grunt-cli"
  not_if "which grunt"
end
