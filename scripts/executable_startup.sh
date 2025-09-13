#!/bin/bash

wait_for_window() {
    local class_name="$1"
    while ! hyprctl clients -j | jq -e ".[] | select(.initialTitle == \"$class_name\")" >/dev/null; do
        sleep 0.1
    done
}

hyprctl dispatch workspace 2
foot &
wait_for_window "foot"

hyprctl dispatch workspace 1
firefox &
