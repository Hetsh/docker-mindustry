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
update_image "library/alpine" "Alpine Linux" "false" "\d{8}"

# Mindustry Server
CURRENT_APP_VERSION="${_CURRENT_VERSION%-*}"
NEW_APP_VERSION=$(curl --silent --location "https://api.github.com/repos/Anuken/Mindustry/releases/latest" | jq -r ".tag_name" | sed "s/^v//")
if [ "$CURRENT_APP_VERSION" != "$NEW_APP_VERSION" ]; then
	prepare_update "APP_VERSION" "Mindustry Server" "$CURRENT_APP_VERSION" "$NEW_APP_VERSION"
	update_version "$NEW_APP_VERSION"
fi

# OpenJRE
update_pkg "openjdk11-jre-headless" "OpenJRE" "false" "https://pkgs.alpinelinux.org/package/edge/community/x86_64" "(\d+\.)+\d+_p\d+-r\d+"

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
