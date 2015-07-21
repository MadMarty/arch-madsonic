#!/bin/bash

#create folders on config
mkdir -p /config/media/incoming
mkdir -p /config/media/podcasts
mkdir -p /config/playlists/import
mkdir -p /config/playlists/export
mkdir -p /config/playlists/backup
mkdir -p /config/transcode

#copy transcode to config directory - transcode directory is subdir of path set from --home flag, do not alter
cp /opt/madsonic/transcode/linux/* /config/transcode/

# enable/disable ssl based on env variable set from docker container run command
 if [[ $SSL == "yes" ]]; then
        echo "Enabling SSL for Madsonic"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --https-port=4050 --default-music-folder=/media --default-podcast-folder=/config/media/podcasts --default-playlist-import-folder=/config/playlists/import --default-playlist-export-folder=/config/playlists/export --default-playlist-backup-folder=/config/playlists/backup
 elif [[ $SSL == "no" ]]; then
        echo "Disabling SSL for Madsonic"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040 --default-music-folder=/media --default-podcast-folder=/config/media/podcasts --default-playlist-import-folder=/config/playlists/import --default-playlist-export-folder=/config/playlists/export --default-playlist-backup-folder=/config/playlists/backup
 else
        echo "SSL not defined, defaulting to disabled"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040 --default-music-folder=/media --default-podcast-folder=/config/media/podcasts --default-playlist-import-folder=/config/playlists/import --default-playlist-export-folder=/config/playlists/export --default-playlist-backup-folder=/config/playlists/backup
 fi
