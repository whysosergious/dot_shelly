
# clear & copy configuration files
def handle_config [
	name: string	# target config
] {
	print $"*** handle ($name) config ***"
	
	let source_path = [".config", $name] | path join 
	let target_path = [$env.HOME, ".config", $name] | path join

	rm -rf $target_path
	cp -r $source_path $target_path 

	print $"copied ($name)"
}



# install pre-req
def handle_istall [] {

	# update apt 
	sudo apt update;


	## install

	# gh install & auth
	print "*** installing gh ***"
	sudo apt install gh;
	
	print "*** auth github ***"
	gh auth login;


	# nvim pre-req
	print "*** installing nvim pre-req ***"
	sudo apt install ripgrep;
	sudo apt install fonts-noto-color-emoji
}



def main [] {
	print "*** dot_shelly init ***"


	## install
	# handle_install;


	## configs
	["nushell", "nvim", "rio"] | each { |name| 
		handle_config $name 
	}
}
