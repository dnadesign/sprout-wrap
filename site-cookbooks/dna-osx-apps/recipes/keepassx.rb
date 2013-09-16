dmg_package "KeePassX" do
  volumes_dir "KeePassX-0.4.3"
  source 'http://downloads.sourceforge.net/keepassx/KeePassX-0.4.3.dmg'
  action :install
  owner node['current_user']
end