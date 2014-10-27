#!/bin/sh

# enable/disable ssl based on env variable set from docker container run command
 if [[ $SSL == "yes" ]]; then
	sed -i 's/MADSONIC_HTTPS_PORT=0/MADSONIC_HTTPS_PORT=4050/g' /var/madsonic/madsonic.sh
	echo "Enabling SSL for Madsonic"
	
 elif [[ $SSL == "no" ]]; then
 	sed -i 's/MADSONIC_HTTPS_PORT=4050/MADSONIC_HTTPS_PORT=0/g' /var/madsonic/madsonic.sh
 	echo "Disabling SSL for Madsonic"
 
 else
 	sed -i 's/MADSONIC_HTTPS_PORT=4050/MADSONIC_HTTPS_PORT=0/g' /var/madsonic/madsonic.sh
  	echo "SSL not defined, defaulting to disabled"
	
 fi
 
# copy over ffmpeg and other transcoders
mkdir -p /config/transcode
cp /var/madsonic/transcode/linux/* /config/transcode/

# set permissions for user nobody group users
chown -R nobody:users /config
chmod +x /config/transcode/*