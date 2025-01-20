# Get current settings: dconf dump /org/gnome/terminal/

if command -v gnome-terminal 2>&1 >/dev/null
then
  dconf write /org/gnome/terminal/legacy/keybindings/move-tab-left "'<Primary><Shift>Left'"
  dconf write /org/gnome/terminal/legacy/keybindings/move-tab-right "'<Primary><Shift>Right'"
  dconf write /org/gnome/terminal/legacy/keybindings/next-tab "'<Shift>Right'"
  dconf write /org/gnome/terminal/legacy/keybindings/prev-tab "'<Shift>Left'"
  dconf write /org/gnome/terminal/legacy/keybindings/reset-and-clear "'<Primary><Shift>k'"
  dconf write /org/gnome/terminal/legacy/keybindings/select-all "'<Primary><Shift>a'"
  dconf write /org/gnome/terminal/legacy/keybindings/toggle-menubar "'<Primary><Shift>m'"
  dconf write /org/gnome/terminal/legacy/keybindings/zoom-in "'<Primary>KP_Add'"
  dconf write /org/gnome/terminal/legacy/keybindings/zoom-out "'<Primary>KP_Subtract'"

  gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false # Ensure F10 is not caught
fi

# TODO: font installation is in nvim/install.sh, merge it here.
# Sadly, it may not be easy to automatically use it because it's associated to a profile.
# If there's a default profile, it could be used to register it.
#
# Also set up unlimited scrollback, which is on the profile.
#
# For reference:
# [legacy/profiles:/:some-id]
# font='JetBrainsMonoNL Nerd Font 22'
# scrollback-unlimited=true
# use-system-font=false

