#!/usr/bin/env bash

docker build -t jenkins-image ../
docker run -it -p 8080:8080 -p 50000:50000 --name jenkins-container -v //var/run/docker.sock:/var/run/docker.sock -d jenkins-image
docker start jenkins-container
