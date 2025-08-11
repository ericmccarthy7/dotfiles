#!/bin/bash
# ~/.config/hypr/startup.sh

hyprctl dispatch workspace 2
wezterm &

hyprctl dispatch workspace 1
firefox &
