FROM jenkins/jenkins:lts-jdk11

RUN apt-get update && apt-get upgrade && apt-get install -y git \
    python3 python3-pip python3-dev python3-venv
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
    && nvm --version