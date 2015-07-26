#!/bin/sh

#create folders on config
mkdir -p /config/transcode

#copy transcode to config directory - transcode directory is subdir of path set from --home flag, do not alter
cp /opt/madsonic/transcode/linux/* /config/transcode/

# enable/disable ssl based on env variable set from docker container run command
 if [[ $SSL == "yes" ]]; then
        echo "Enabling SSL for Madsonic"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --https-port=4050 --default-music-folder=/media 
 elif [[ $SSL == "no" ]]; then
        echo "Disabling SSL for Madsonic"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040 --default-music-folder=/media 
 else
        echo "SSL not defined, defaulting to disabled"
        /opt/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040 --default-music-folder=/media 
 fi
