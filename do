#!/bin/bash

script_name="$(basename ${BASH_SOURCE[0]})"
script_reldir="$(dirname ${BASH_SOURCE[0]})"
script_absdir="$(cd $script_reldir > /dev/null && pwd)"

. "$script_absdir"/misc.sh

set -e
trap trap_error ERR
trap trap_exit EXIT
trap trap_user_exit INT

pushd "$script_absdir" >/dev/null

action="$1"
service="$2"

if [[ ! "$service" =~ ^mongo$|^mssql$|^pgsql$|^rmq$ ]]; then
	log_warning ">>> Unknown service: ${service}."
	log_warning "$ ./do <action> mongo|mssql|pgsql|rmq"

elif [[ ! "$action" =~ ^build$|^start$|^stop$|^reset$|^rm$ ]]; then
	log_warning ">>> Unknown action: ${action}."
	log_warning "$ ./do build|start|stop|reset|rm <service>"

elif [ -x "${service}/do" ]; then
	. "${service}/do" "$action"

else
	log_warning ">>> Unknown request: ${service}."
	log_warning "$ ./do <action> <service>"
	log_warning "actions: build, start, stop, reset, rm"
	log_warning "services: mongo, mssql, pgsql, rmq"
fi