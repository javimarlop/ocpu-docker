ocpu-docker
===========

*adaptation from https://github.com/jeroenooms/docker*

It is an [OpenCPU](https://www.opencpu.org/) server and [app](https://github.com/javimarlop/ocpu-radarplot-sochi) installed on a Docker machine. [Docker](https://www.docker.com/) needs to be installed in your OS.

# How to run it:

```bash
# Pull the image
docker pull javimarlop/ocpu-docker
# Run a container
docker run -t -i -p 80:8006 -p 443:8007 javimarlop/ocpu-docker sh -c 'service opencpu restart && /bin/bash'
#then you will get the IP from the container exposed to the host and you can directly try:

http://xxx.xx.x.x/ocpu/library/ocpuRadarplot/www/

# ... and access the web app from your host web-browser.
```
For any user of the host OS to be able to use docker without admin rights, it should just be added to the docker group like this:

```bash
sudo usermod -aG docker username
```

