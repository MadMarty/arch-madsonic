#!/bin/sh

# copy over ffmpeg and other transcoders
mkdir -p /config/transcode
cp /var/madsonic/transcode/linux/* /config/transcode/

# set permissions for user nobody group users
chown -R nobody:users /config
chmod +x /config/transcode/*