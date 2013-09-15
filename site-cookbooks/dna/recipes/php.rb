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