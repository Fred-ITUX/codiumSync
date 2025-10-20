#!/bin/bash

# Detect session type (Wayland or X11)
sessionType="${XDG_SESSION_TYPE:-unknown}"


get_formatted_date(){
    date +%a\ %b\ %d\ %Y\ %H:%M:%S  #### python %a %b %d %Y %H:%M:%S
}


#### Get WM (window manager)
get_wm(){
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        echo "Mutter"
    elif [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
        echo "KWin"
    else
        wm="$(xprop -root _NET_SUPPORTING_WM_CHECK 2>/dev/null | awk -F'#' '/^_NET_SUPPORTING_WM_CHECK/ {print $2}' | xargs -I{} xprop -id {} _NET_WM_NAME 2>/dev/null | cut -d '"' -f2)"
        echo "${wm:-Unknown}"
    fi
}

#### Get compositor
get_compositor() {
    if pgrep -x picom > /dev/null; then
        echo "picom"
    elif pgrep -x compton > /dev/null; then
        echo "compton"
    elif [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
        echo "KWin (built-in)"
    elif [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        echo "Mutter (built-in)"
    else
        echo "Unknown"
    fi
}

#### Get system GTK theme, icon theme, and font (GNOME and compatible DEs)
get_gtk_theme() {
    gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'"
}
get_icon_theme() {
    gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null | tr -d "'"
}
get_font_name() {
    gsettings get org.gnome.desktop.interface font-name 2>/dev/null | tr -d "'"
}

#### Get shell version
get_shell_version() {
    case "$SHELL" in
        */bash) bash --version | head -n1 ;;
        */zsh) zsh --version ;;
        */fish) fish --version ;;
        *) echo "$SHELL" ;;
    esac
}


#### Get gnome version (only if the DE is GNOME)
get_gnome_version(){

isGnome=$(echo "$XDG_CURRENT_DESKTOP")

if [ "$isGnome" == "GNOME" ]; then
    printOut=$(echo -e "$(gnome-shell --version 2>/dev/null | cut -d' ' -f3)")

else
    printOut=""    
fi

echo "$printOut"

}


#### Bold title
echo -e "\033[1mSystem Info:\033[0m $(get_formatted_date)" 
echo -e "OS: $(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/*release | cut -d= -f2 | tr -d \")"
echo -e "Kernel: $(uname -r)"
# echo -e "Uptime: $(uptime -p | sed 's/up //')"
echo -e "Packages: $(dpkg -l | wc -l)"
echo -e "Flatpak pkg: $(flatpak list  | wc -l)"
echo -e "Shell: $(get_shell_version)"
echo -e "DE: ${XDG_CURRENT_DESKTOP:-Unknown} $(get_gnome_version)" 
echo -e "Session: $sessionType"
echo -e "WM: $(get_wm)"
echo -e "Compositor: $(get_compositor)"
echo -e "Theme: $(get_gtk_theme)"
echo -e "Icons: $(get_icon_theme)"
echo -e "Font: $(get_font_name)"
echo -e "CPU: $(lscpu | grep 'Model name' | sed 's/Model name:\s*//')"
echo -e "GPU: $(lspci | grep VGA | cut -d: -f3 | xargs)"
echo -e "RAM: $(free -h | awk '/Mem:/ {print $3 " / " $2}')"
echo -e "SWAP: $(free -h | awk '/Swap:/ {print $3 " / " $2}')"
