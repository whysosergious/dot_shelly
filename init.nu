
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

	# install deno
	cargo binstall deno
}


const GHURL = "https://github.com/whysosergious/"

# handle owned dependancies
def ws_build_deps [
	$repo_name: string
] {
	print $"cloning repo ($repo_name)"

	let repo_url = $"($GHURL)($repo_name).git"
	let target_path = [$env.HOME, ".shelly" $repo_name] | path join

	print $"cloning ($repo_url)"

	git clone $repo_url $target_path
	
	cargo install --path $target_path
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


	let skip_config = [true false] | input list "skip porting config files?"

	if $skip_config == false {
		## configs
		["nushell", "nvim", "rio"] | each { |name| 
			handle_config $name 
		}
	}

	
	let skip_ws_build = [true false] | input list "skip building ws dependensies?"

	if $skip_ws_build == false {
		ws_build_deps "shelly-run";
	}


	print "____ doneski ____"
	print "clone the main shelly repo and run 'shelly-run nu -n shelly.np srv --master'"
}
