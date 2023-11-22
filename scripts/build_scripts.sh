#!/bin/bash

export WKSDIR=${WORKSPACE:-"$(pwd)"}

getImageVersion() {
    local imageType="$1"
    local isSnapshot="$2"
    local versionFile=""
    case ${imageType} in
        almalinux)
            versionFile="${WKSDIR}/jdk11/almalinux/almalinux8/hotspot/version.txt"
            ;;
        debian)
            versionFile="${WKSDIR}/jdk11/debian/bookworm/version.txt"
            ;;
    esac
    if [ ! -f "${versionFile}" ]; then
        echo "Version file ${versionFile} does not exists. Stopping build...."
        exit 1
    fi
    imageVersion=$(cat ${versionFile})
    if [ "${isSnapshot}" == "true" ]; then
        timestamp=$(date +"%Y%m%d%H%M%S")
        echo "${imageVersion}-${timestamp}-SNAPSHOT"
    else
        echo "${imageVersion}"
    fi
}

dockerLogin() {
    local userName="$1"
    echo ${DOCKERHUB_TOKEN} | docker login --username ${userName} --password-stdin 
}

dockerBuildAndPublish() {
    local imageType="$1"
    local isSnapshot="$2"
    imageVersion=$(getImageVersion ${imageType} ${isSnapshot})
    local contextFile=""

    case ${imageType} in
        almalinux)
            contextFile="${WKSDIR}/jdk11/almalinux/almalinux8/hotspot/Dockerfile"
            ;;
        debian)
            contextFile="${WKSDIR}/jdk11/debian/bookworm/Dockerfile"
            ;;
    esac

    if [ ! -f "${contextFile}" ]; then
        echo "Context file ${contextFile} does not exists. Stopping build...."
        exit 1
    fi

    echo -e "\nBuilding image ${imageType} with version ${imageVersion}\n"
    
    docker buildx create --name jenkins_jcasc_builder --platform linux/amd64 --use --bootstrap

    docker buildx build --push \
    --platform linux/amd64 \
    --tag ${DOCKERHUB_NAMESPACE}/jenkins_jcasc:${imageType}-${imageVersion} \
    -f ${contextFile} .
    docker buildx stop jenkins_jcasc_builder
    docker buildx rm jenkins_jcasc_builder
}

dockerBuildAndLoad() {
    local imageType="$1"
    local isSnapshot="$2"
    imageVersion=$(getImageVersion ${imageType} ${isSnapshot})
    local contextFile=""

    case ${imageType} in
        almalinux)
            contextFile="${WKSDIR}/jdk11/almalinux/almalinux8/hotspot/Dockerfile"
            ;;
        debian)
            contextFile="${WKSDIR}/jdk11/debian/bookworm/Dockerfile"
            ;;
    esac

    if [ ! -f "${contextFile}" ]; then
        echo "Context file ${contextFile} does not exists. Stopping build...."
        exit 1
    fi

    echo -e "\nBuilding image ${imageType} with version ${imageVersion}\n"
    
    docker buildx create --name jenkins_jcasc_builder --platform linux/amd64 --use --bootstrap

    docker buildx build --load \
    --platform linux/amd64 \
    --tag ${DOCKERHUB_NAMESPACE}/jenkins_jcasc:${imageType}-${imageVersion} \
    -f ${contextFile} .

    docker buildx stop jenkins_jcasc_builder
    docker buildx rm jenkins_jcasc_builder
}