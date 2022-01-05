#!/bin/bash

if [ -e ~/.local/bin/gnome-first-start.sh.done ]; then
  exit 0
fi

# Extensions to manual download from web:
# hidetopbar@mathieu.bidon.ca
# workspace-switch-wraparound@theychx.org
# Move_Clock@rmy.pobox.com
#
# Maybe settings:
#     org.gnome.desktop.interface font-hinting 'full'
#     org.gnome.desktop.interface font-antialiasing 'rgba'

gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable GPaste@gnome-shell-extensions.gnome.org
gnome-extensions enable gTile@vibou
gnome-extensions enable workspace-indicator@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'ctrl:nocaps']"
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m']"
gsettings set org.gnome.desktop.wm.keybindings maximize-horizontally "['<Super>h']"
gsettings set org.gnome.desktop.wm.keybindings maximize-vertically "['<Super>v']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>s']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left']"
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.extensions.window-list display-all-workspaces false
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 2
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.mutter center-new-windows true

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "termite"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"

# Clear existing keybinding
gsettings set org.gnome.shell.keybindings focus-active-notification "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Neovim"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "~/bin/xneovim"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>n"

touch ~/.local/bin/gnome-first-start.sh.done

notify-send "Gnome first start was run"
