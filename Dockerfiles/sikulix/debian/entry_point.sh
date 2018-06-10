#!/bin/bash 
# 
# IMPORTANT: Change this file only in directory StandaloneDebug!

export DEBUG="${DEBUG:=true}"

source /opt/bin/functions.sh

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
echo $GEOMETRY
function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

SERVERNUM=$(get_server_num)

Xvfb $DISPLAY -screen 0 $GEOMETRY &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
for i in $(seq 1 10)
do
  xdpyinfo -display $DISPLAY >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    break
  fi
  echo Waiting xvfb...
  sleep 0.5
done

fluxbox -display $DISPLAY &


if [ "$DEBUG" == "true" ]
then
    x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &
    echo "VNC in port 5900"
fi

wait $NODE_PID