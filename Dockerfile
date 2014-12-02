# Docker file to run OpenCPU cloud server
# Requires docker version 1.0 or higher!
# Note that AppArmor security is disabled in Docker.
#
# Run as executable: docker run -t -p 80:8006 -p 443:8007 javimarlop/ocpu-docker
# Run in background: docker run -t -d -p 80:8006 -p 443:8007 javimarlop/ocpu-docker
# Run with shell: docker run -t -i -p 80:8006 -p 443:8007 javimarlop/ocpu-docker sh -c 'service opencpu restart && /bin/bash'
# docker run --privileged -tiv /media/sda6:/opt/sda6 -p 80:8006 -p 443:8007 javimarlop/ocpu-docker sh -c 'service opencpu restart && /bin/bash'

# To see the demo app go to: http://172.17.0.2/ocpu/library/ocpuRadarplot/www/ in your web browser.

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

RUN apt-get install -y wget mc git libxml2 libxml2-dev gdal-bin libgeos-3.4.2 libgeos-dev libproj0 libproj-dev libgdal-dev python-gdal libgdal1h libgdal1-dev 

RUN echo "local({r <- getOption('repos');r['CRAN'] <- 'http://cran.rstudio.com/';options(repos = r)})" > /etc/R/Rprofile.site

RUN Rscript -e "install.packages('XML', type = 'source');install.packages(c('devtools','png','rgdal','raster','yaml','base64enc'));devtools::install_github('ramnathv/rCharts@dev');devtools::install_github('ramnathv/rMaps');devtools::install_github('javimarlop/ocpu-radarplot-sochi')"

# Apache ports (without caching)
EXPOSE 80
EXPOSE 443

# Nginx ports (with caching)
EXPOSE 8006
EXPOSE 8007

# Define default command.
CMD service opencpu restart && tail -F /var/log/opencpu/apache_access.log
