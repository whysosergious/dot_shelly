
# clear & copy configuration files
def handle_config [
	name: string	# target config
] {
	let source_path = [".config", $name] | path join 
	let target_path = [$env.HOME, ".config", $name] | path join

	rm -r -f $target_path
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



# .shelly
def handle_shelly [] {
	let shelly_path = [$env.HOME ".shelly"] | path join
	let bin_path = [$shelly_path "bin"] | path join
	let nvim_source_path = ["./nvim"] | path join
	let nvim_target_path = [$shelly_path "nvim"] | path join

	rm -r -f $shelly_path
	mkdir $shelly_path
	mkdir $bin_path
	cp -r $nvim_source_path $nvim_target_path
	
	print "~/.shelly/ - ok"
}



def main [] {
	print "*** dot_shelly init ***"

	let skip_install = [true false] | input list "skip install?"

	## install
	if $skip_install == false {
		handle_install;
	}


	## init .shelly
	handle_shelly;


	## configs
	["nushell", "nvim", "rio"] | each { |name| 
		handle_config $name 
	}

	print "____ doneski ____"
}
