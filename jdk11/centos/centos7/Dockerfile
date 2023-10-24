FROM jenkins/jenkins:2.410-centos7

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV BASH_ENV /home/jenkins/.bashrc

USER root

RUN yum update -y && yum upgrade -y && yum -y install sudo
RUN yum install git curl python && yum clean all
RUN mkdir -p /home/jenkins && cd /home/jenkins && touch .bashrc && \
    usermod -d /home/jenkins jenkins && chown -R jenkins:jenkins /home/jenkins && \
    usermod --shell /bin/bash jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY --from=docker:dind --chown=jenkins:jenkins /usr/local/bin/docker /usr/local/bin/

USER jenkins
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
