#!/bin/sh

# Start SSH Daemon for azure webSSH
service ssh start >> /dev/null

export BUNDLE_WITHOUT=development:test
export BOOTSNAP_CACHE_DIR=/home/site/bootsnap/

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

# Starting rails on port 8080
STARTUPCOMMAND=${@:-bin/rails s -p 8080 --pid /tmp/puma.pid}

echo "Running Startup Command: $STARTUPCOMMAND"
$STARTUPCOMMAND
