dmg_package "SourceTree" do
  source 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.8.1.dmg'
  action :install
  owner node['current_user']
end