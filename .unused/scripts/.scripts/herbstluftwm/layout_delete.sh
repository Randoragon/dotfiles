#!/bin/sh
# shellcheck disable=SC2016
#
# Deletes a layout from LAYOUT_DIR.

LAYOUT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/herbstluftwm/layouts"
AWK_FILTER='{sub("^.*/", ""); printf("%-2d %s\n", NR, $0)}'

[ ! -d "$LAYOUT_DIR" ] && exit

name="$(stat -c '%Y %n' "$LAYOUT_DIR"/* | sort -n | awk "$AWK_FILTER" \
      | dmenu -f -l 10 -p 'Delete Layout:' | sed 's/^[0-9]\+\s*//')"
[ -z "$name" ] || [ ! -r "$LAYOUT_DIR/$name" ] && exit

ans="$(printf 'Y\nN' | dmenu -f -i -p "Delete layout '$name'?")"
[ "$ans" = Y ] && rm -f -- "$LAYOUT_DIR/$name"
