#!/bin/bash
set -ex

#check NEEDED environement are given
function check_env() {
    if [ -z $1 ];
    then
        exit 1
    fi
}

check_env $WORKDIR
check_env $PS_HOST
check_env $WORK_HOST


#get environemnt from hostname.Please follow the name rules to make it works
export TASK_INDEX=$(hostname| grep -o '[0-9]')
export JOB_NAME=$(hostname| grep -o -e "worker" -e "ps")
cd $(dirname $WORKDIR)


#start check if name server start working
/ipcheck

#tensorflow start
python $(basename $WORKDIR) --ps_hosts=$PS_HOST --worker_hosts=$WORK_HOST --job_name=$JOB_NAME --task_index=$TASK_INDEX
