
execute "Setup site folder" do
	command "mkdir -p #{node['sprout']['home']}/Sites"
    user node['current_user']
    cwd "#{node['sprout']['home']}/"
    not_if { ::File.exists?("#{node['sprout']['home']}/Sites") }
end

execute "Setup site tools folder" do
	command "mkdir -p #{node['sprout']['home']}/Sites/tools/"
    user node['current_user']
    cwd "#{node['sprout']['home']}/"
    not_if { ::File.exists?("#{node['sprout']['home']}/Sites/tools") }
end

execute "Setup scripts folder" do
	command "mkdir -p #{node['sprout']['home']}/Scripts/"
    user node['current_user']
    cwd "#{node['sprout']['home']}/"
    not_if { ::File.exists?("#{node['sprout']['home']}/Scripts") }
end