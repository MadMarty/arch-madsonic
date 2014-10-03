FROM binhex/arch-base:2014091500
MAINTAINER binhex

# install application
#####################

# update package databases from the server
RUN pacman -Sy --noconfirm

# install pre-req for application
RUN pacman -S libcups jre7-openjdk-headless fontconfig unzip --noconfirm

# make destination folders
RUN mkdir -p /var/madsonic/media
RUN mkdir -p /var/madsonic/transcode

# download madsonic
ADD http://madsonic.org/download/5.1/20140927_madsonic-5.1.5150-standalone.zip /var/madsonic/madsonic.zip

# unzip to folder
RUN unzip /var/madsonic/madsonic.zip -d /var/madsonic

# remove zip
RUN rm /var/madsonic/madsonic.zip

# force process to run as foreground task
RUN sed -i 's/-jar madsonic-booter.jar > \${LOG} 2>\&1 \&/-jar madsonic-booter.jar > \${LOG} 2>\&1/g' /var/madsonic/madsonic.sh

# install transcoders
#####################

# download madsonic transcoders
ADD http://madsonic.org/download/transcode/20140927_madsonic-transcode_latest_x64.zip /var/madsonic/transcode/transcode.zip

# unzip to folder
RUN unzip /var/madsonic/transcode/transcode.zip -d /var/madsonic/transcode

# remove zip
RUN rm /var/madsonic/transcode/transcode.zip

# copy transcode script to madsonic install dir (copies transcoders to madsonic install dir)
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

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
