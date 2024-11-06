# During startup mc tries to resolve the local hostname to an IP address which can be slow
# run `hostname` then add the hostname for 127.0.0.1 in /etc/hosts.

CONFIG_FILE="$HOME/.config/mc/ini"

if [[ -f "$CONFIG_FILE" ]]; then
    sed -i 's/^skin=.*/skin=nicedark/' "$CONFIG_FILE"
    echo "The skin setting has been updated to 'nicedark' in $CONFIG_FILE."
else
    echo "Configuration file not found at $CONFIG_FILE."
fi
