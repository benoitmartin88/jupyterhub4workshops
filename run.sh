#!/bin/bash

DOCKER_IMAGE_NAME=jupyterhub_tmp
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd ${SCRIPTPATH}

# build docker image
docker build -t ${DOCKER_IMAGE_NAME} .

docker run --rm -it \
  -v ${SCRIPTPATH}/data:/srv/jupyterhub \
  -v ${SCRIPTPATH}/user_homes:/home \
  -v ${SCRIPTPATH}/shared_data:/shared_data:ro \
  -p 8000:8000 --name jupyterhub ${DOCKER_IMAGE_NAME} jupyterhub --config=/srv/jupyterhub/jupyterhub_config.py

docker rmi ${DOCKER_IMAGE_NAME}
