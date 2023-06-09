#!/bin/bash

color_default="\033[0m"
fg_blue="\033[0;36m"
fg_green="\033[0;32m"
fg_orange="\033[0;33m"
fg_red="\033[0;31m"
function log_error  { >&2 echo -e "${fg_red}$1${color_default}"; }
function log_info { >&2 echo -e "${fg_blue}$1${color_default}"; }
function log_success { >&2 echo -e "${fg_green}$1${color_default}"; }
function log_warning { >&2 echo -e "${fg_orange}$1${color_default}"; }

script_name="$(basename ${BASH_SOURCE[0]})"
script_reldir="$(dirname ${BASH_SOURCE[0]})"
script_absdir="$(cd $script_reldir > /dev/null && pwd)"

trap_error () {
	exit_code=$?
	failed_cmd="$BASH_COMMAND"
	failed_line_nr="$BASH_LINENO"
	log_error ">>> Failed the execution of $script_name on line $failed_line_nr."
	log_error ">>> Command '$failed_cmd' failed with exit code $exit_code."
}

trap_exit () {
	popd >/dev/null
}

trap_user_exit () {
	[ -n "$(docker ps -q --filter name="$container")" ] &&
		docker stop "$container" &&
		log_info ">>> Stopped $container" &&
		exit 0
}

set -e
trap trap_error ERR
trap trap_exit EXIT
trap trap_user_exit INT

pushd "$script_absdir" >/dev/null

arch="${ARCH:-$(uname -m)}"
container=""
platform=""
tag=""
version="${VERSION:-4.4.22}"
volume=""

arg_pkg=""
env_port=27017
env_replSet="rs0"

# NOTE: MongoDB releases are available at
# https://www.mongodb.com/try/download/community
arg_pkg="https://fastdl.mongodb.org/linux"
if [ "$arch" == "arm64" ]; then
	arg_pkg="${arg_pkg}/mongodb-linux-aarch64-ubuntu1804-${version}.tgz"
	platform="linux/arm64/v8"
	container="psevdaisthisi-mongo-arm64-$version"
	tag="psevdaisthisi-mongo-arm64:$version"
	volume="psevdaisthisi-mongo"
elif [ "$arch" == "x86_64" ]; then
	arg_pkg="${arg_pkg}/mongodb-linux-x86_64-debian10-${version}.tgz"
	platform="linux/x86_64"
	container="psevdaisthisi-mongo-arm64-$version"
	tag="psevdaisthisi-mongo-x86:$version"
	volume="psevdaisthisi-mongo"
else
	log_error ">>> Unsupported architecture: $arch."
	exit 1
fi

if [ "$1" == "build" ]; then
	docker build --build-arg PKG="$arg_pkg" \
		--platform $platform \
		--tag $tag .

	docker volume create "$volume"

elif [ "$1" == "reset" ]; then
	docker rm "$container" || true
	docker volume rm "$volume" || true

elif [ "$1" == "rm" ]; then
	docker rm "$container" || true
	docker volume rm "$volume" || true
	docker rmi "$tag" || true

elif [ "$1" == "run" ]; then
	already_ran=$(docker ps -aq --filter name="$container")

	[ -n "$already_ran" ] && docker start "$container"

	[ -z "$already_ran" ] && docker run -d --init \
		-e port="$env_port" -e replSet="$env_replSet" \
		-p "$env_port:$env_port" \
		--mount source="$volume",target=/data/db \
		--name "$container" \
		"$tag"

	docker logs --follow --tail 15 "$container" &
	wait

elif [ "$1" == "stop" ]; then
	[ -n "$(docker ps -q --filter name="$container")" ] &&
		docker stop "$container" &&
		log_info ">>> Stopped $container"
else
	log_warning ">>> Unknown or missing action."
	log_warning "$ lets.sh build|run|stop|reset|rm"
fi