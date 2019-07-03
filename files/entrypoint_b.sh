#!/bin/sh
curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
sleep 30
curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
sleep 30
curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
sleep 30
curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
sleep 30
curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
sleep 240

while :
do
    curl -i -H "Content-Type: application/json" -X POST -d '{"mac_id":"'$(cat /sys/class/net/eth0/address)'", "time":"'$(date +%s)'"}' http://status-dashboard/status/update
    sleep 30
done