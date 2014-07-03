FROM binhex/arch-base
MAINTAINER binhex

# madsonic
##########

# update package databases from the server
RUN pacman -Sy --noconfirm

# run packer to install madsonic and pre-reqs
RUN packer -S madsonic --noconfirm

# run pacman to install correct version of java (aur package incorrectly downloads the wrong version of java)
RUN pacman -S jre7-openjdk-headless --noconfirm

# map /config to host defined config to store logs, config etc
VOLUME /config

# map /data to host defined data which contains data to index
VOLUME /data

# expose port for http
EXPOSE 4040

# expose port for https
EXPOSE 4050

# copy modified script to madsonic install dir (forces madsonic to be a foreground process)
ADD madsonic.sh /var/madsonic/madsonic.sh

# set owner to user "nobody" group "users" recursively
RUN chown -R nobody:users /var/madsonic

# set permissions recursively
RUN chmod -R 775 /var/madsonic

# set process to run as user "nobody" group "users"
USER nobody:users

# run script with home dir, host ip and port specified (http and https)
CMD /var/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040 --https-port=4050