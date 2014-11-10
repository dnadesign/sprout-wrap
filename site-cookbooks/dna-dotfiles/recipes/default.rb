%w[
  .ackrc
  .aliases
  .bash_profile
  .exports
  .functions
  .git-prompt.conf
  .gitattributes
  .gitignore
  .gitmodules
  .gvimrc
  .inputrc
  .osx
  .profile
  .screenrc
  .vimrc
  .wgetrc
].each do |dotfile|

  cookbook_file dotfile do
    source dotfile
    path "#{node['sprout']['home']}/#{dotfile}"
    mode '0755'
    owner node['current_user']
  end

end

username = node['current_user']
full_name = username.split('.').map(&:capitalize).join(' ')
email = "#{username}@dna.co.nz"

template '.gitconfig' do
  source 'gitconfig.erb'
  path "#{node['sprout']['home']}/.gitconfig"
  variables({
    :name => full_name,
    :email => email
  })
  mode '0755'
  owner node['current_user']
end
