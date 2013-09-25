
# use smtp.php to save the email locally and not use any mail server. Prevents
# sending local email to people we really shouldn't.
template "#{node['sprout']['home']}/Scripts/smtp.php" do
  source "smtp.php"
  owner node['current_user']
end

execute "fix permissions on smtp.php" do
  command "chmod +x #{node['sprout']['home']}/Scripts/smtp.php"
end

execute "Setup smtp mail folder" do
  command "mkdir -p #{node['sprout']['home']}/Scripts/smtp/"
  user node['current_user']
  cwd "#{node['sprout']['home']}/"
  not_if { ::File.exists?("#{node['sprout']['home']}/Scripts/smtp") }
end