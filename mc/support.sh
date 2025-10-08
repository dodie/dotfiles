CONFIG_FILE="$HOME/.config/mc/ini"

if [[ ! -f "$CONFIG_FILE" ]]; then
  exit 1
fi
