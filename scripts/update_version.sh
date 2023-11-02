#!/bin/bash

export MAJOR_VERSION="major"
export MINOR_VERSION="minor"
export PATCH_VERSION="patch"

if [[ $# -lt 2 ]]; then
    echo "Usage:"
    echo "update_version.sh <version-type> <base-image>"
    echo -e "\t version-type\t major | minor | patch "
    echo -e "\t base-image\t debian | centos | almalinux"
    exit 1
fi

export UPDATE_TYPE="$1"
export UPDATE_IMAGE="$2"

case "${UPDATE_TYPE}" in
    ${MAJOR_VERSION} | ${MINOR_VERSION} | ${PATCH_VERSION}):
        ;;
    *)
        echo "Arg 1 should be one of major | minor | patch "
        exit 1
        ;;
esac

case "${UPDATE_IMAGE}" in
    "debian" | "centos" | "almalinux"):
        ;;
    *)
        echo "Arg 2 should be one of debian | centos | almalinux"
        exit 1
        ;;
esac


echo "Updating image: ${UPDATE_IMAGE} with version type: ${UPDATE_TYPE}"
