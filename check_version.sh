#!/bin/bash

function detect_scriptversion()
{
	SCRIPT_VERSION=$(fgrep "$2=" "$1")
	if [[ "$SCRIPT_VERSION" ]]; then
		expr "$SCRIPT_VERSION" : ".*=\(.*\)"
	else
		echo "0"
	fi
}

function detect_changelogversion()
{
	printf "%1.1d%1.1d%1.1d%3.3d\n" `head -1 debian/changelog | sed 's/.*(\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)).*/\1 \2 \3 \4/'`
}

SCRIPT_VERSION=`detect_scriptversion $1 STEAMSCRIPT_VERSION`
CHANGELOG_VERSION=`detect_changelogversion $2`
if [ "$SCRIPT_VERSION" != "$CHANGELOG_VERSION" ]; then
	echo "$1 is at version $SCRIPT_VERSION which doesn't match $2 at $CHANGELOG_VERSION"
	exit 1
fi
exit 0
