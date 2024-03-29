#!/bin/sh

wid="$1"
class="$2"
insta="$3"
consequences="$4"
title="$(xdotool getwindowname "$wid")"

# xev
[ "$title" = 'Event Tester' ] && {
    echo 'state=floating'
}

# Zoom
[ "$class" = 'zoom' ] && \
[ "$insta" = 'zoom' ] && \
case "$title" in
    zoom) echo 'manage=off' ;;
    Settings) echo 'state=floating' ;;
esac

# Hydrogen
[ "$class" = 'Hydrogen' ] && \
[ "$insta" = 'hydrogen' ] && \
case "$title" in
    Mixer) echo 'state=floating' ;;
    LADSPA*Properties) echo 'state=floating' ;;
esac
