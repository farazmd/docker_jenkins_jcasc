# Docker Jenkins JCasC

Jenkins setup on docker via Jenkins configuration as code (JCasC)

## Prerequisites

- docker
- docker-compose

## Usage

- The `casc.yaml` file contains all the configuration to setup jenkins.
- The layout of the configuration can be found [here](https://github.com/jenkinsci/configuration-as-code-plugin)
- The following environment variables are setup to replace values in `casc.yaml`
  - `JENKINS_ADMIN_PASSWORD`
  - `JENKINS_ADMIN_ID`
  - `JENKINS_SERVER`

### Using locally via docker-compose
- Create a .env file to set the following values:
  - `JENKINS_ADMIN_PASSWORD`
  - `JENKINS_ADMIN_ID`
  - `JENKINS_SERVER`
- This will replace the values as environments in the `casc.yaml` file

- Run the following command to setup jenkins
  ```shell
    docker-compose --env-file < .env file created > up -d
  ```

- If you want to re build the container post changes, add the `--build` flag as follows

  ```shell
    docker-compose --env-file <.env file created> up --build -d
  ```

### Using locally via docker commands

- Build the image using the instructions below.
- Run the following command
  ```shell
  docker container run jenkins -e JENKINS_SERVER=<value> -e JENKINS_ADMIN_ID=<value> -e JENKINS_ADMIN_PASSWORD=<value> -p 8080:8080 -p 50000:50000 -d <image_name>:<tag_name>
  ```

## Build

### Using docker command
- Run the following command to build the image
  ```shell
    docker build -t <image_name>:<tag_name> .
  ```

### Using docker-compose

- Run the following command
  ```shell
    docker-compose build 
  ```