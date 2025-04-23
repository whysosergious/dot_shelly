
# linux config

# load .env into env
let config_dir = ($nu.config-path | path dirname)
open $"($config_dir)/.env"
  | lines
  | filter { |line| ($line | str trim) !~ '^#' and ($line | str trim) != '' }
  | parse "{key}={value}"
  | reduce -f {} { |row, acc| $acc | merge { ($row.key): $row.value } }
  | load-env



# neovim binary
$env.path ++= ["~/.shelly/nvim/bin/", "~/.shelly/bin", "~/.cargo/bin"]

# default editor
$env.config.buffer_editor = "nvim"



