#!/bin/sh

# Unlimited dwm-like scratchpads for HerbstluftWM.
#
# Usage:
#     scratchpad.sh NAME show|hide|toggle [CMD...]
#
# NAME - a WM_CLASS instance name (must be unique).
# CMD  - an optional command that spawns a scratchpad if it does not
#        exist when needing to be shown. The command MUST guarantee
#        that the program has WM_CLASS instance property set to NAME.
#
# show   - shows a given scratchpad, runs CMD if non-existent
# hide   - hides a given scratchpad, if it exists
# toggle - toggles between shown and hidden states (default)
#
# Example:
#     scratchpad.sh sp_term toggle st -n sp_term

# Parse command-line arguments
[ $# -lt 2 ] && exit 1
name="$1"
action="$2"
shift 2

ATTR_PREFIX=my_spwid_ # must begin with "my_" (herbstluftwm(1))

hc () {
    herbstclient "$@"
}

wid="$(hc get_attr "$ATTR_PREFIX$name")"
[ "$action" = toggle ] && {
    action=show
    [ -n "$wid" ] && hc compare clients."$wid".visible = 1 && \
        action=hide
}

if [ "$action" = show ]; then
    # shellcheck disable=SC2015
    # This is NOT an if-else block, it's supposed to be like this
    [ -n "$wid" ] && hc bring "$wid" || {
        [ $# -gt 0 ] && {
            HOOK_PREFIX=spwid_

            # Listen to store the about-to-be-spawned-window's id
            hc -w rule "$HOOK_PREFIX$name" | cut -f3 | while read -r newwid; do
                hc new_attr string "$ATTR_PREFIX$name" "$newwid"
            done &
            hc rule once instance="$name" hook="$HOOK_PREFIX$name"

            "$@" &

            # If the scratchpad terminates, clear the cached attribute
            wait $!
            hc remove_attr "$ATTR_PREFIX$name"
        }
    }
elif [ "$action" = hide ]; then
    hc set_attr clients."$wid".minimized true
else
    echo "scratchpad.sh: invalid action" >&2
fi
