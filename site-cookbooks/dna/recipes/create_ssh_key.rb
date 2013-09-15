
execute "create ssh key" do
  command "ssh-keygen -t rsa -f #{node['sprout']['home']}/.ssh/id_rsa"
  user node['current_user']
  not_if { ::File.exists?("#{node['sprout']['home']}/.ssh/id_rsa.pub") }
end