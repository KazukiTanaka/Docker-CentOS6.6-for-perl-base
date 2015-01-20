#!/bin/sh
# first setup
# export AWS_ACCESS_KEY_ID=
# export AWS_SECRET_ACCESS_KEY=
# export DOCKER_REPOSITORY_BUCKET=

docker run \
         -e SETTINGS_FLAVOR=prod \
         -e AWS_BUCKET=$DOCKER_REPOSITORY_BUCKET \
         -e AWS_KEY=$AWS_ACCESS_KEY_ID \
         -e AWS_SECRET=$AWS_SECRET_ACCESS_KEY \
         -p 49000:5000 \
         stackbrew/registry
