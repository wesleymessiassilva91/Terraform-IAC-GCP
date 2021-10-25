FROM maven:3.8.1-jdk-11

RUN apt-get update > /dev/null && apt-get install -y apt-transport-https dirmngr > /dev/null && echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list && apt-get update > /dev/null && apt-get install -y curl tar bash procps docker.io > /dev/null

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]