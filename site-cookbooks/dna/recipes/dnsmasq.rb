# 
# Based on the following blog article
# http://www.echoditto.com/blog/never-touch-your-local-etchosts-file-os-x-again
#
brew "dnsmasq"

execute "copy dnsmasq for launchd" do
  command "cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons"
  not_if { ::File.exists?("/Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist") }
end

template "/etc/resolv.conf" do
  source "resolv.conf"
  owner node['current_user']
end

execute "load locate dnsmasq daemon via launchctl"   do
  command "launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"
  not_if "launchctl list | grep dnsmasq"
end

execute "create resolver for dev" do
  command "mkdir -p /etc/resolver && bash -c 'echo \"nameserver 127.0.0.1\" > /etc/resolver/dev'"
  not_if { ::File.exists?("/etc/resolver/dev") }
end

template "/usr/local/etc/dnsmasq.conf" do
  source "dnsmasq.conf"
  owner node['current_user']
end