FROM binhex/arch-base:2014101300
MAINTAINER binhex

# additional files
##################

# download madsonic
ADD http://beta.madsonic.org/request.jsp?branch=5.1&target=20141017_madsonic-5.1.5200-standalone.zip /var/madsonic/madsonic.zip

# download madsonic transcoders
ADD http://beta.madsonic.org/request.jsp?branch=transcode&target=20141017_madsonic-transcode_latest_x64.zip /var/madsonic/transcode/transcode.zip

# copy transcode script to madsonic install dir (copies transcoders to madsonic install dir)
ADD transcode.sh /var/madsonic/transcode.sh

# add supervisor conf file for app
ADD madsonic.conf /etc/supervisor/conf.d/madsonic.conf

# install app
#############

# install install app using pacman, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S libcups jre7-openjdk-headless fontconfig unzip --noconfirm && \
	pacman -Scc --noconfirm && \
	mkdir -p /var/madsonic/media && \
	mkdir -p /var/madsonic/transcode && \
	unzip /var/madsonic/madsonic.zip -d /var/madsonic && \
	rm /var/madsonic/madsonic.zip && \
	unzip /var/madsonic/transcode/transcode.zip -d /var/madsonic/transcode && \
	rm /var/madsonic/transcode/transcode.zip && \
	chown -R nobody:users /var/madsonic && \
	chmod -R 775 /var/madsonic && \	
	rm -rf /archlinux/usr/share/locale && \
	rm -rf /archlinux/usr/share/man && \
	rm -rf /root/* && \
	rm -rf /tmp/*

# force process to run as foreground task
RUN sed -i 's/-jar madsonic-booter.jar > \${LOG} 2>\&1 \&/-jar madsonic-booter.jar > \${LOG} 2>\&1/g' /var/madsonic/madsonic.sh

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

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]