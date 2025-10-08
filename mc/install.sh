# Hint: During startup mc tries to resolve the local hostname to an IP address which can be slow
# run `hostname` then add the hostname for 127.0.0.1 in /etc/hosts.

CONFIG_FILE="$HOME/.config/mc/ini"
sed -i 's/^skin=.*/skin=nicedark/' "$CONFIG_FILE"
