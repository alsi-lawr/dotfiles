#!/bin/bash

# Define the keymaps.lua file path
KEYMAPS_FILE="/usr/share/config/.config/nvim/lua/alsi/core/keymaps.lua"

# Ensure gum is installed
if ! command -v gum &> /dev/null
then
    echo "gum could not be found. Please install gum first."
    exit 1
fi

# Function to handle script interruption
function handle_interrupt {
    echo "Script interrupted. Exiting."
    exit 1
}

# Trap SIGINT (Ctrl+C) to handle interruption
trap handle_interrupt SIGINT

# Prompt for mode selection
echo "Select modes (use space to select multiple, enter to confirm)"
modes=($(gum choose --no-limit "n" "i" "v" "x" "s" "o" "c" "t"))
if [[ -z "${modes[@]}" ]]; then
    echo "No mode selected. Exiting."
    exit 1
fi

mode_list=$(printf '"%s", ' ${modes[@]} | sed 's/, $//')

# Prompt for keybinding
keybinding=$(gum input --placeholder "Enter keybind (e.g., <leader>h)")
if [[ -z "$keybinding" ]]; then
    echo "No keybinding entered. Exiting."
    exit 1
fi

# Prompt for command
command=$(gum input --placeholder "Enter the command (e.g., :w)")
if [[ -z "$command" ]]; then
    echo "No command entered. Exiting."
    exit 1
fi

# Prompt for description
description=$(gum input --placeholder "Enter the description (e.g., Save file)")
if [[ -z "$description" ]]; then
    echo "No description entered. Exiting."
    exit 1
fi

# Check if the keymaps file exists
if [[ ! -f $KEYMAPS_FILE ]]; then
    echo "The file $KEYMAPS_FILE does not exist."
    exit 1
fi

# Append the new keybinding to the keymaps.lua file
echo "keymap.set({ $mode_list }, \"$keybinding\", \"$command\", { desc = \"$description\" })" | sudo tee -a $KEYMAPS_FILE > /dev/null

echo "Keybinding added to $KEYMAPS_FILE"

