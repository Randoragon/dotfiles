#!/usr/bin/python3

# This script intakes a m3u playlist path, reads the current playing song in MPD,
# and then appends the song's path to the playlist file IF the song isn't already
# on the playlist.

import os
import sys
import subprocess

def rprint(msg):
    return os.system('rofi -e "{}" -markup'.format(msg))

if __name__ == '__main__':
    if len(sys.argv) != 2:
        rprint('<i>E: playlists_add.py:</i> <b>Exactly one parameter required (received {})</b>'.format(len(sys.argv)-1))
        sys.exit(1)
    
    playlist = str(sys.argv[1])
    proc = subprocess.Popen('mpc current -f %file% --port=6601', stdout=subprocess.PIPE, shell=True)
    song = str(proc.stdout.read())[2:-3]

    f = open(playlist, 'r')
    if song not in list(filter(lambda x: x.replace('\n', ''), f.readlines())):
        f.close()
        f = open(playlist, 'a')
        f.write('\n'+song)
        f.close()
        sys.exit(0)
    else:
        rprint('<i>I: playlists_add.py:</i> <b>This song is already on the playlist!</b>')
        sys.exit(2)