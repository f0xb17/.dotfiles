# https://github.com/blueman-project/blueman/issues/1495#issuecomment-915788723

#!/bin/sh
blueman-applet &
while ! pgrep -x blueman-tray; do
    sleep 0.01
done
killall -e blueman-tray
