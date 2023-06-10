color_default="\033[0m"
fg_blue="\033[0;36m"
fg_green="\033[0;32m"
fg_orange="\033[0;33m"
fg_red="\033[0;31m"
function log_error { >&2 echo -e "${fg_red}$1${color_default}"; }
function log_info { >&2 echo -e "${fg_blue}$1${color_default}"; }
function log_success { >&2 echo -e "${fg_green}$1${color_default}"; }
function log_warning { >&2 echo -e "${fg_orange}$1${color_default}"; }

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
		log_info ">>> Stopping $container ..." &&
		docker stop "$container" &&
		log_info ">>> Stopped $container" &&
		exit 0
}