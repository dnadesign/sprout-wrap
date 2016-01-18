#execute "tap PHP homebrew versions" do
#	command "brew tap homebrew/versions"
#end

#execute "tap PHP" do
#	command "brew tap homebrew/homebrew-php"
#end

package "php56", {:brew_args => "--with-mysql --with-pgsql"}

package "php56-xdebug"
package "php56-yaml"
package "php56-imagick"
package "php56-solr"
package "php56-twig"


template "/usr/local/etc/php/5.6/php.ini" do
	source "php.ini.erb"
	owner node['current_user']
end

execute "setup pear" do
	command "chmod -R ug+w `brew --prefix php56`/lib/php \
		&& pear config-set php_ini /usr/local/etc/php/5.6/php.ini \
		&& pear config-set auto_discover 1 \
		&& pear update-channels \
		&& pear upgrade"
end

execute "Start PHP" do
	command "ln -sfv /usr/local/opt/php56/*.plist ~/Library/LaunchAgents/"
end

package "php56-mongo"
package "php56-mcrypt"
package "php56-tidy"
package "php56-xhprof"
package "php56-ssh2"
package "composer"

execute "Create symlink to xhprof" do
	command "ln -s /usr/local/opt/php56-xhprof/xhprof_html/ #{node['sprout']['home']}/Sites/xhprof"
	not_if { ::File.exists?("#{node['sprout']['home']}/Sites/xhprof") }
end

execute "Install composer" do
	command "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"
	not_if { File.exists?("/usr/local/bin/composer") }
end
