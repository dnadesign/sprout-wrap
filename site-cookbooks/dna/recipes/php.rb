template "/usr/local/etc/php/5.4/php.ini" do
	source "php.ini.erb"
	owner node['current_user']
end

execute "setup pear" do
	command "chmod -R ug+w `brew --prefix php54`/lib/php \
		&& pear config-set php_ini /usr/local/etc/php/5.4/php.ini \
		&& pear config-set auto_discover 1 \
		&& pear update-channels \
		&& pear upgrade"
end

execute "install PHPUnit" do
	command "pear install pear.phpunit.de/PHPUnit PHP_CodeSniffer"
end

execute "link PHPunit" do
	command "ln -s -f `brew --prefix php54`/bin/phpunit /usr/local/bin/phpunit"
end

brew "php54-mongo"
brew "php54-mcrypt"
brew "php54-tidy"
brew "php54-xhprof"
brew "php54-ssh2"
brew "composer"

execute "Create symlink to xhprof" do
	command "ln -s /usr/local/opt/php54-xhprof/xhprof_html/ #{node['sprout']['home']}/Sites/xhprof"
	not_if { ::File.exists?("#{node['sprout']['home']}/Sites/xhprof") }
end

execute "Install composer" do
	command "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"
	not_if { File.exists?("/usr/local/bin/composer") }
end
