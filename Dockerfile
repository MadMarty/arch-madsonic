FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases from the server
RUN pacman -Sy --noconfirm

# install pre-req for application
RUN pacman -S libcups jre7-openjdk-headless fontconfig unzip --noconfirm

# make destination folder
RUN mkdir -p /var/madsonic/media

# download madsonic
ADD http://madsonic.org/download/5.0/20140702_madsonic-5.0.3880-standalone.zip /var/madsonic/madsonic.zip

# unzip to folder
RUN unzip /var/madsonic/madsonic.zip -d /var/madsonic

# remove zip
RUN rm /var/madsonic/madsonic.zip

# force process to run as foreground task
RUN sed -i 's/-jar madsonic-booter.jar > \${LOG} 2>\&1 \&/-jar madsonic-booter.jar > \${LOG} 2>\&1/g' /var/madsonic/madsonic.sh

# install transcoders
#####################

# download from madsonic website
ADD http://madsonic.org/download/transcode/20140702_madsonic-transcode_latest_x64.zip /tmp/transcode.zip

# unzip to tmp folder
RUN unzip /tmp/transcode.zip -d /tmp

# remove files in tmp
RUN rm /tmp/transcode.zip

# copy transcode script to madsonic install dir (downloads and copies transcoders to madsonic homedir)
ADD transcode.sh /var/madsonic/transcode.sh

# docker settings
#################

# set env variable for java
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk/jre

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
RUN chown -R nobody:users /var/madsonic

# set permissions
RUN chmod -R 775 /var/madsonic

# add conf file
###############

ADD madsonic.conf /etc/supervisor/conf.d/madsonic.conf

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
