package "autoconf"

execute "Link autoconf" do
	command "ln -s /usr/local/Cellar/autoconf/2.69/bin/autoconf /usr/local/bin/autoconf"
	not_if { ::File.exists?("/usr/local/bin/autoconf") }
end

execute "Link autoheader" do
	command "ln -s /usr/local/Cellar/autoconf/2.69/bin/autoheader /usr/local/bin/autoheader"
	not_if { ::File.exists?("/usr/local/bin/autoheader") }
end