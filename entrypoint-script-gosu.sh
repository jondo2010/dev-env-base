#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or fallback

# We use an ENV variable to specify the user to run in the container instead of
# using Docker's --user flag so that this script maintains root access for the
# entrypoint.

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user
echo "user:user" | chpasswd
adduser user sudo

exec /usr/local/bin/gosu user "$@"
