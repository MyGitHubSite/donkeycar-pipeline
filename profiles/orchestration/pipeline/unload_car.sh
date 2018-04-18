#!/usr/bin/env bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>./unload_car.log 2>&1

function echo_log {
    echo "[$(date +'%Y/%m/%d %H:%M:%S%z %Z' )]: $1"
}

echo_log "Starting Up"
eval `ssh-agent -s`
ssh-add ~/jenkins/jenkins

CAR_IP="192.168.1.46"
CAR_USER="pi"
CAR_PATH="~/d2/data/*"
TUB_IN_PATH="/Users/tspeckhart/Documents/GitRepositories/donkeycar-pipeline/data/data-in/"

time rsync -rt --stats ${CAR_USER}@${CAR_IP}:${CAR_PATH} ${TUB_IN_PATH}
echo_log "Ending."
