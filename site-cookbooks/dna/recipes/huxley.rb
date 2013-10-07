execute "Install PIP" do
	command "easy_install pip"
end

execute "Install Dependancies" do
	command "pip install jsonpickle plac selenium pil"
end

execute "Install Huxley" do
	command "pip install huxley"
end