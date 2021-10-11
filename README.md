# Docker Jenkins JCasC

Jenkins setup on docker via Jenkins configuration as code (JCasC)

## Prerequisites

- docker
- docker-compose

## Usage

### Using locally via docker-compose
- Create a .env file to set the following values:
  - `JENKINS_ADMIN_PASSWORD`
  - `JENKINS_ADMIN_ID`
  - `JENKINS_SERVER`
- This will replace the values as environments in the `casc.yaml` file
- The `casc.yaml` file contains all the configuration to setup jenkins.
- The layout of the configuration can be found [here](https://github.com/jenkinsci/configuration-as-code-plugin)

- Run the following command to setup jenkins
  ```shell
    docker-compose --env-file < .env file created > up -d
  ```

- If you want to re build the container post changes, add the `--build` flag as follows

  ```shell
    docker-compose --env-file <.env file created> up --build -d
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