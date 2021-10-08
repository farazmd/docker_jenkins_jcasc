FROM jenkins/jenkins:lts-jdk11

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV NVM_DIR /home/jenkins/.nvm
ENV BASH_ENV /home/jenkins/.bashrc

USER root

RUN apt-get update && apt-get upgrade -y && apt-get -y install sudo
RUN apt-get install -y git python3 python3-pip python3-dev python3-venv
RUN mkdir -p /home/jenkins && cd /home/jenkins && touch .bashrc && \
usermod -d /home/jenkins jenkins && chown -R jenkins:jenkins /home/jenkins && \
usermod --shell /bin/bash jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
RUN mkdir -p $NVM_DIR && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY --chown=jenkins:jenkins casc.yaml /var/jenkins_home/casc.yaml