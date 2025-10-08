My dotfiles.

Based on the structure and setup scripts created by
Zach Holman: https://github.com/holman/dotfiles

## Install

```sh
git clone https://github.com/dodie/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
# ... provide info ...
script/install
# Avoid overwriting existing dotfiles
```

Consider manually migrating to the new environment if necessary:
- Browser bookmarks
- .zsh_history
- SSH keys (or generate new ones as needed, set up proper permissions with `chmod go-rwx *`)
- Any "temporary" stuff that might be needed:
  - Documents
  - Downloads
  - Programs

See extra steps for Windows in [windows-customizations.md]()

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic/\*.configlink**: Similar to .symlinks, but these files will be linked into $HOME/.config

## Notable archives

Check git history for (outdated) config for the following tools:

- xmonad
- konsole
- synclient
