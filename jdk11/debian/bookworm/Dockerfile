FROM jenkins/jenkins:2.414.3-jdk11

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV BASH_ENV /home/jenkins/.bashrc

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install sudo && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
RUN apt-get install -y git \
    curl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN mkdir -p /home/jenkins && cd /home/jenkins && touch .bashrc && \
    usermod -d /home/jenkins jenkins && chown -R jenkins:jenkins /home/jenkins && \
    usermod --shell /bin/bash jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
