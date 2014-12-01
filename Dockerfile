# Docker file to run OpenCPU cloud server
# Requires docker version 1.0 or higher!
# Note that AppArmor security is disabled in Docker.
#
# Run as executable: docker run -t -p 80:8006 -p 443:8007 jeroenooms/opencpu-dev
# Run in background: docker run -t -d -p 80:8006 -p 443:8007 jeroenooms/opencpu-dev
# Run with shell: docker run -t -i -p 80:8006 -p 443:8007 jeroenooms/opencpu-dev sh -c 'service opencpu restart && /bin/bash'
# docker run --privileged -tiv /media/sda6:/opt/sda6 -p 80:8006 -p 443:8007 jeroenooms/opencpu-dev sh -c 'service opencpu restart && /bin/bash'

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:opencpu/opencpu-dev && \
  apt-get update && \
  apt-get install -y opencpu

# Install RStudio (doesn't work)
# RUN apt-get install rstudio-server
# RUN rm /etc/apparmor.d/rstudio-server
# EXPOSE 8787

RUN apt-get install -y git
RUN git clone http://github.com/javimarlop/ocpu-radarplot-sochi.git

# Apache ports (without caching)
EXPOSE 80
EXPOSE 443

# Nginx ports (with caching)
EXPOSE 8006
EXPOSE 8007

# Define default command.
CMD service opencpu restart && tail -F /var/log/opencpu/apache_access.log
