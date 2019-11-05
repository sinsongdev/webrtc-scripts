#!/bin/bash

GOPATH=/home/ubuntu/apprtc/tools/work
ROOM_SERVER_URL=http://IP:8080
SIGNAL_SERVER_PORT=8089

if [ $# -eq 0 ] ; then

  collider="`ps ax|grep -v grep |grep collidermain |wc -l`"
  echo $collider

  if [ "$collider" -eq "0" ] ; then
        echo "start.."
        $GOPATH/bin/collidermain -room-server=$ROOM_SERVER_URL -port=$SIGNAL_SERVER_PORT -tls=false &
  elif [ "$collider" -eq "1" ] ; then
        echo "running.."
  else
        echo "restart.."
        ps -ef | grep collidermain | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOPATH/bin/collidermain -room-server=$ROOM_SERVER_URL -port=$SIGNAL_SERVER_PORT -tls=false &
  fi

else

  if [ "$1" == "restart" ] ; then
        echo "restart.."
        ps -ef | grep collidermain | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOPATH/bin/collidermain -room-server=$ROOM_SERVER_URL -port=$SIGNAL_SERVER_PORT -tls=false &
  elif [ "$1" == "stop" ] ; then
        echo "stop.."
        ps -ef | grep collidermain | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
  fi

fi
