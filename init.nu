
# clear & copy configuration files
def handle_config [
	name: string	# target config
] {
	let source_path = [".config", $name] | path join 
	let target_path = [$env.HOME, ".config", $name] | path join

	rm -rf $target_path
	cp -r $source_path $target_path 

	print $"handled ($name) config"
}



# install pre-req
def handle_install [] {

	# update apt 
	sudo apt update;


	## install

	# gh install & auth
	print "*** installing gh ***"
	sudo apt install gh;
	

	let skip_gh_auth = [true false] | input list "skip github login?"
	if $skip_gh_auth == false {
		print "*** auth github ***"
		gh auth login;
	}


	# nvim pre-req
	print "*** installing nvim pre-req ***"
	sudo apt install ripgrep;
	sudo apt install fonts-noto-color-emoji
}



def main [] {
	print "*** dot_shelly init ***"

	let skip_install = [true false] | input list "skip install?"

	## install
	if $skip_install == false {
		handle_install;
	}


	## configs
	["nushell", "nvim", "rio"] | each { |name| 
		handle_config $name 
	}

	print "____ doneski ____"
}
