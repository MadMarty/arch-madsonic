FROM binhex/base-arch
MAINTAINER binhex

# madsonic
##########

# run command to download app and all pre-req from aur
RUN packer -S madsonic --noconfirm

# expose config to store logs, config etc
VOLUME /config

# expose port
EXPOSE 4040

# copy modified script to madsonic install dir (forces madsonic to be a foreground process)
ADD madsonic.sh /var/madsonic/madsonic.sh

# set permissions and owner to user nobody, group users
RUN chown -R nobody:users /var/madsonic
RUN chmod -R 775 /var/madsonic

# set process to run as user nobody
USER nobody

# run script with home dir, host ip and port specified
CMD /var/madsonic/madsonic.sh --home=/config --host=0.0.0.0 --port=4040