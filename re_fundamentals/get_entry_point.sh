#!/bin/bash
#
# get_entry_point.sh
#
# Extracts and displays ELF header information from a given binary file:
#   - Magic Number
#   - Class (32-bit / 64-bit)
#   - Byte Order (little / big endian)
#   - Entry Point Address
#
# Usage: ./get_entry_point.sh <elf_file>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the reusable display function
if [ -f "$SCRIPT_DIR/messages.sh" ]; then
    source "$SCRIPT_DIR/messages.sh"
else
    echo "Error: messages.sh not found in $SCRIPT_DIR" >&2
    exit 1
fi

# --- 1. Check that a file name argument was provided ---
if [ $# -ne 1 ]; then
    echo "Usage: $0 <elf_file>" >&2
    exit 1
fi

file_name="$1"

# --- 2. Check if the file exists ---
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist." >&2
    exit 1
fi

# --- 3. Check if the file is a valid ELF file ---
if ! readelf -h "$file_name" &>/dev/null; then
    echo "Error: '$file_name' is not a valid ELF file." >&2
    exit 1
fi

# --- 4. Extract required ELF header fields using readelf ---

# Magic Number: first line of readelf -h, e.g. "7f 45 4c 46 02 01 01 00 ..."
magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/.*Magic:[[:space:]]*//' | sed 's/[[:space:]]*$//')

# Class: e.g. "ELF64" or "ELF32"
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')

# Byte Order (Data field): readelf shows e.g. "2's complement, little endian"
# We only want "little endian" or "big endian"
byte_order=$(readelf -h "$file_name" | grep "Data:" | grep -oE "little endian|big endian")

# Entry Point Address: e.g. "0x1040"
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $NF}')

# --- 5. Display formatted output using messages.sh ---
display_elf_header_info
