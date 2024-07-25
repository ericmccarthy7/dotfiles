switch (printf "1 - Lock\n2 - Log out\n3 - Reboot\n4 - Shutdown" | fuzzel --dmenu -l 4 -p "Power Menu: ")
	case "*Lock"
		hyprlock
	case "*Log out"
		hyprctl dispatch exit
	case "*Reboot"
		reboot
	case "*Shutdown"
		poweroff
end
