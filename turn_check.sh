#!/bin/bash

TURN_SERVER=/usr/local/bin/turnserver
TURN_SERVER_INTERNAL_IP=Private IP.
TURN_SERVER_EXTERNAL_IP=Public IP.
TURN_SERVER_PORT=3478
TURN_SERVER_USER_ACCOUNT=username:password
TURN_SERVER_REALM=realm-token

if [ $# -eq 0 ] ; then

  ps_cnt="`ps ax|grep -v grep |grep turnserver |wc -l`"
  echo "process_count = " $ps_cnt

  if [ "$ps_cnt" -eq "0" ] ; then
        echo "start.."
        $TURN_SERVER -a -v -n -u $TURN_SERVER_USER_ACCOUNT -p $TURN_SERVER_PORT -L $TURN_SERVER_INTERNAL_IP -r $TURN_SERVER_REALM -X $TURN_SERVER_EXTERNAL_IP -E $TURN_SERVER_INTERNAL_IP --no-dtls --no-tls --log-file /dev/null --no-stdout-log --simple-log &
  elif [ "$ps_cnt" -eq "1" ] ; then
        echo "running.."
  else
        echo "restart.."
        ps -ef | grep turnserver | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $TURN_SERVER -a -v -n -u $TURN_SERVER_USER_ACCOUNT -p $TURN_SERVER_PORT -L $TURN_SERVER_INTERNAL_IP -r $TURN_SERVER_REALM -X $TURN_SERVER_EXTERNAL_IP -E $TURN_SERVER_INTERNAL_IP --no-dtls --no-tls --log-file /dev/null --no-stdout-log --simple-log &
  fi

else

  if [ "$1" == "restart" ] ; then
        echo "restart.."
        ps -ef | grep turnserver | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $TURN_SERVER -a -v -n -u $TURN_SERVER_USER_ACCOUNT -p $TURN_SERVER_PORT -L $TURN_SERVER_INTERNAL_IP -r $TURN_SERVER_REALM -X $TURN_SERVER_EXTERNAL_IP -E $TURN_SERVER_INTERNAL_IP --no-dtls --no-tls --log-file /dev/null --no-stdout-log --simple-log &
  elif [ "$1" == "stop" ] ; then
        echo "stop.."
        ps -ef | grep turnserver | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
  fi

fi