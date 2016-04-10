FROM resin/raspberrypi2-debian
MAINTAINER justin@dray.be

# Let's start with some basic stuff.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from hypriot repos
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 37BBEE3F7AD95B3F && \
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
#    echo "deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ wheezy main" > /etc/apt/sources.list.d/hypriot.list && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-precise main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-hypriot docker-compose

COPY ./wrapdocker /usr/local/bin/wrapdocker

COPY ./apps /apps
WORKDIR /apps

# Define additional metadata for our image.
VOLUME /var/lib/docker
ADD start /start
CMD /start
