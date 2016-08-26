FROM x110dc/base
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yq openssh-client openjdk-7-jre

# Add the install commands
ADD ./install.sh /
RUN chmod 777 ./install.sh

ADD ./run.sh /
RUN chmod 777 ./run.sh

# Change Rundeck admin password from default
ENV RDPASS Globiq2015#

# set the host
#ENV MYHOST $(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}')

ENV MYHOST 172.16.3.132

# From address when sending email
ENV MAILFROM MAILFROM

# Download Rundeck
ADD http://download.rundeck.org/deb/rundeck-2.5.2-1-GA.deb /tmp/rundeck.deb

# Run the installation script
RUN /install.sh
RUN chown rundeck /tmp/rundeck

ENTRYPOINT /run.sh

COPY ./runtalendjob.sh /
RUN chmod 777 ./runtalendjob.sh

#ADD ./rundeckdeploy/* /etc/talend/jobs/

#VOLUMES
VOLUME /var/lib/rundeck/data
VOLUME /var/lib/rundeck/var
VOLUME /var/lib/rundeck/logs
VOLUME /var/rundeck/projects
VOLUME /etc/talend/jobs

EXPOSE 4440 4443 993
