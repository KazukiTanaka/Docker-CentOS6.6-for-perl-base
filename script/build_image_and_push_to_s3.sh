#!/bin/sh

docker build -t nohana/centos6.5perl5.18.2 ./dockerfiles/centos_perl
docker tag nohana/centos6.5perl5.18.2 127.0.0.1:49000/centos6.5perl5.18.2
docker push 127.0.0.1:49000/centos6.5perl5.18.2


