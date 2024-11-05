# Get current settings: dconf dump /org/gnome/terminal/

if command -v gnome-terminal 2>&1 >/dev/null
then
  dconf write /org/gnome/terminal/legacy/keybindings/next-tab "'<Shift>Right'"
  dconf write /org/gnome/terminal/legacy/keybindings/prev-tab "'<Shift>Left'"
  dconf write /org/gnome/terminal/legacy/keybindings/reset-and-clear "'<Primary><Shift>k'"
  dconf write /org/gnome/terminal/legacy/keybindings/select-all "'<Primary><Shift>a'"
  dconf write /org/gnome/terminal/legacy/keybindings/toggle-menubar "'<Primary><Shift>m'"
  dconf write /org/gnome/terminal/legacy/keybindings/zoom-in "'<Primary>KP_Add'"
  dconf write /org/gnome/terminal/legacy/keybindings/zoom-out "'<Primary>KP_Subtract'"
fi

