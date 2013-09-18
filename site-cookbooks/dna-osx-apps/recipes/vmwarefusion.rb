dmg_package "VMWare Fusion" do
  source 'https://download3.vmware.com/software/fusion/file/VMware-Fusion-6.0.0-1296151.dmg'
  checksum "02ccb07a1ed5c6837ecd802523ec68b323eea7434435c2d7b37ab7de79e702e4"
  action :install
  owner node['current_user']
end