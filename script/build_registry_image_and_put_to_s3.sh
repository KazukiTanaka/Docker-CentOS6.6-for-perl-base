#!/bin/sh

# first setup
# aws configure
# export DOCKER_REPOSITORY_BUCKET=

docker pull stackbrew/registry
docker save stackbrew/registry | gzip - > registry-image.tgz
aws s3 cp registry-image.tgz s3://$DOCKER_REPOSITORY_BUCKET/registry-image.tgz
rm registry-image.tgz
