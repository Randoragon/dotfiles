#!/bin/sh

appmap () {
    riverctl map normal "$1" "$2" spawn "$3"
}

appmap Super         Return 'st'
appmap Super         O      'dmenu_run'
appmap Super         Space  '~/.scripts/mousemode-run'
appmap Super         C      'snippet'
appmap Super+Shift   O      '~/.scripts/passcpy'
appmap Super+Control O      '~/.scripts/usercpy'
appmap Super+Shift   N      'note'
appmap Super+Control N      'note -e'
appmap Super+Control equal  '~/.scripts/pladd_select'
appmap Super         slash  'st -c floatme -t qalc -e qalc'
appmap Super+Shift   slash  'groff -ms -t -T pdf -dpaper=a3l -P-pa3 -P-l ~/dotfiles/.other/shortcuts.ms | zathura --mode=fullscreen -'


riverctl declare-mode launcher
riverctl map normal   Super 0      enter-mode launcher
riverctl map launcher None  Escape enter-mode normal
launcher () {
    riverctl map launcher None "$1" spawn "$2"
}

launcher I 'st -e lf'
launcher W '~/.scripts/surfbm'
launcher D 'discord'
launcher F 'fsearch'
