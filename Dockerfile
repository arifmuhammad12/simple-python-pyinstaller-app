FROM jenkins/jenkins:2.462.1-lts-jdk17

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y lsb-release curl gnupg \
    && curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
       https://download.docker.com/linux/debian/gpg \
    && echo "deb [arch=$(dpkg --print-architecture) \
       signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
       https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli \
    && apt-get clean

USER jenkins

# Install BlueOcean + Docker Pipeline plugins
RUN jenkins-plugin-cli --plugins \
    "blueocean:1.27.9 docker-workflow:572.v950f58993843"
