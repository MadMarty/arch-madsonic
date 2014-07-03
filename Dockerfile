FROM binhex/arch-base
MAINTAINER binhex

# madsonic
##########

# run command to force download of correct java version (aur has incorrect version defined)
RUN pacman -S jre7-openjdk-headless libcups --noconfirm

# run command to download app and all pre-req from aur (ignore jre7-openjdk, wrong java version)
RUN packer -S madsonic --aur --noconfirm

# map /config to host defined config to store logs, config etc
VOLUME /config

# map /data to host defined data which contains data to index
VOLUME /data

# expose port
EXPOSE 4040

# copy modified script to madsonic install dir (forces madsonic to be a foreground process)
ADD madsonic.sh /var/madsonic/madsonic.sh

# set permissions and owner to user nobody, group users
RUN chown -R nobody:users /var/madsonic
RUN chmod -R 775 /var/madsonic

# set process to run as user nobody
USER nobody:users

# run script with home dir, host ip and port specified
CMD /var/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040