#!/usr/bin/env bash


# Abort on any error
set -e -u

# Simpler git usage, relative file paths
CWD=$(dirname "$0")
cd "$CWD"

# Load helpful functions
source libs/common.sh
source libs/docker.sh

# Check dependencies
assert_dependency "jq"
assert_dependency "curl"

# Alpine Linux
update_image "amd64/alpine" "Alpine Linux" "false" "\d{8}"

# Mindustry Server
update_github "Anuken/Mindustry" "Mindustry Server" "APP_VERSION" "(\d+\.)*\d+"

# OpenJRE
update_pkg "openjdk17-jre-headless" "OpenJRE" "false" "https://pkgs.alpinelinux.org/package/edge/community/x86_64" "(\d+\.)+\d+_p\d+-r\d+"

if ! updates_available; then
	#echo "No updates available."
	exit 0
fi

# Perform modifications
if [ "${1-}" = "--noconfirm" ] || confirm_action "Save changes?"; then
	save_changes

	if [ "${1-}" = "--noconfirm" ] || confirm_action "Commit changes?"; then
		commit_changes
	fi
fi
