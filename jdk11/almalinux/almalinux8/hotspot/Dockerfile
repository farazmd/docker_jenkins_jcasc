FROM jenkins/jenkins:2.414.3-almalinux

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV BASH_ENV /home/jenkins/.bashrc

USER root

RUN dnf update -y && \
    dnf upgrade -y && \
    dnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y sudo  && \
    dnf clean all
RUN dnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y git curl python3.11 && \ 
    dnf clean all
RUN mkdir -p /home/jenkins && cd /home/jenkins && touch .bashrc && \
    usermod -d /home/jenkins jenkins && chown -R jenkins:jenkins /home/jenkins && \
    usermod --shell /bin/bash jenkins

RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
