#!/bin/bash

if [ -e ~/.local/bin/gnome-first-start.sh.done ]; then
  exit 0
fi

# Extensions to manual download from web:
# hidetopbar@mathieu.bidon.ca

gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable GPaste@gnome-shell-extensions.gnome.org
gnome-extensions enable workspace-indicator@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

# Keyboard layout
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'dk+nodeadkeys')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'ctrl:nocaps']"

# Window manager settings
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 2
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower'
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.mutter center-new-windows true

# Window manager keybindings
gsettings set org.gnome.shell.keybindings toggle-message-tray "@as []"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m']"
gsettings set org.gnome.desktop.wm.keybindings maximize-horizontally "['<Super>h']"
gsettings set org.gnome.desktop.wm.keybindings maximize-vertically "['<Super>v']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>Right']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>Left']"

# Shell keybindings
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>s']"

# Shell settings
gsettings set org.gnome.shell.window-switcher current-workspace-only true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Desktop settings
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-seconds false

# Shell extensions
gsettings set org.gnome.shell.extensions.window-list display-all-workspaces false

# Custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "termite"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"

# Clear existing keybinding
gsettings set org.gnome.shell.keybindings focus-active-notification "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Neovim"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "/home/enrique/bin/xneovim"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>n"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "1Password quickaccess"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "1password --quick-access"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Ctrl><Shift>Q"

# Font settings
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

# Theme settings
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

EXPERIMENTAL_FEATURES=$(zenity --list --checklist --width 500 --height 400 \
  --title 'Select Mutter experimental features' \
  --text 'Select features to enable' \
  --column 'Enable' \
  --column 'Key' \
  --column 'Comment' \
  FALSE 'kms-modifiers' 'Nvidia Mutter support' \
  FALSE 'scale-monitor-framebuffer' 'Fractional scaling' \
  FALSE 'variable-refresh-rate' 'Variable refresh rate')

if [[ "x$EXPERIMENTAL_FEATURES" != 'x' ]]; then
  SELECTED_EXPERIMENTAL_FEATURES=()

  OLD_IFS=$IFS

  IFS="|" ; for FEAT in $EXPERIMENTAL_FEATURES ; do
    SELECTED_EXPERIMENTAL_FEATURES+=("'$FEAT'")
  done

  IFS=$OLD_IFS

  FORMATTED=$(printf ",%s" "${SELECTED_EXPERIMENTAL_FEATURES[@]}")
  FORMATTED=${FORMATTED:1}

  gsettings set org.gnome.mutter experimental-features "[$FORMATTED]"
fi

touch ~/.local/bin/gnome-first-start.sh.done

notify-send "Gnome first start was run"
