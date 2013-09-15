template "#{node['sprout']['home']}/Sites/_ss_environment.php" do
	source "_ss_environment.php.erb"
	owner node['current_user']
end