FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases from the server
RUN pacman -Sy --noconfirm

# install pre-req for application
RUN pacman -S jre7-openjdk-headless libcups unzip --noconfirm

# make destination folder
RUN mkdir -p /opt/madsonic

# download madsonic
ADD http://madsonic.org/download/5.0/20140208_madsonic-5.0.3860-standalone.zip /opt/madsonic/madsonic.zip

# unzip to folder
RUN unzip /opt/madsonic/madsonic.zip -d /opt/madsonic

# remove files in tmp
RUN rm /opt/madsonic/madsonic.zip

# copy modified script to madsonic install dir (forces madsonic to be a foreground process)
ADD madsonic.sh /opt/madsonic/madsonic.sh

# install transcoders
#####################

# download from madsonic website
ADD http://madsonic.org/download/transcode/20140411_madsonic-transcode_latest_x64.zip /tmp/transcode.zip

# unzip to tmp folder
RUN unzip /tmp/transcode.zip -d /tmp

# remove files in tmp
RUN rm /tmp/transcode.zip

# copy transcode script to madsonic install dir (downloads and copies transcoders to madsonic homedir)
ADD transcode.sh /opt/madsonic/transcode.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 4040

# expose port for https
EXPOSE 4050

# set permissions
#################

# change owner
RUN chown -R nobody:users /opt/madsonic

# set permissions
RUN chmod -R 775 /opt/madsonic

# add conf file
###############

ADD madsonic.conf /etc/supervisor/conf.d/madsonic.conf

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
