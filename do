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

service="$1"
action="$2"

if [[ ! "$service" =~ ^mongo$|^mssql$|^pgsql$|^rmq$ ]]; then
	log_warning ">>> Unknown service: ${service}."
	log_warning "$ ./do mongo|mssql|pgsql|rmq <action>"

elif [[ ! "$action" =~ ^build$|^start$|^stop$|^reset$|^rm$ ]]; then
	log_warning ">>> Unknown action: ${action}."
	log_warning "$ ./do <service> build|start|stop|reset|rm"

elif [ -x "${service}/do" ]; then
	. "${service}/do" "$action"

else
	log_warning ">>> Unknown request: ${service}."
	log_warning "$ ./do <service> <action>"
	log_warning "services: mongo, mssql, pgsql, rmq"
	log_warning "actions: build, start, stop, reset, rm"
fi