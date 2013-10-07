brew "autoconf"

execute "Link autoconf" do
	command "ln -s /usr/local/Cellar/autoconf/2.69/bin/autoconf /usr/bin/autoconf"
end

execute "Link autoheader" do
	command "ln -s /usr/local/Cellar/autoconf/2.69/bin/autoheader /usr/bin/autoheader"
end