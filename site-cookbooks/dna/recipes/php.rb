brew "php56", {:brew_args => "--with-mysql --with-pgsql"}

brew "php56-xdebug"
brew "php56-yaml"
brew "php56-imagick"
brew "php56-solr"
brew "php56-twig"


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

execute "install PHPUnit" do
	command "pear install pear.phpunit.de/PHPUnit PHP_CodeSniffer"
end

execute "link PHPunit" do
	command "ln -s -f `brew --prefix php56`/bin/phpunit /usr/local/bin/phpunit"
end

execute "Start PHP" do
	command "ln -sfv /usr/local/opt/php56/*.plist ~/Library/LaunchAgents/"
end

brew "php56-mongo"
brew "php56-mcrypt"
brew "php56-tidy"
brew "php56-xhprof"
brew "php56-ssh2"
brew "composer"

execute "Create symlink to xhprof" do
	command "ln -s /usr/local/opt/php56-xhprof/xhprof_html/ #{node['sprout']['home']}/Sites/xhprof"
	not_if { ::File.exists?("#{node['sprout']['home']}/Sites/xhprof") }
end

execute "Install composer" do
	command "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"
	not_if { File.exists?("/usr/local/bin/composer") }
end
