#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd ${SCRIPTPATH}

docker run --rm -it \
  -v ${SCRIPTPATH}/data:/srv/jupyterhub \
  -v ${SCRIPTPATH}/user_homes:/home \
  -v ${SCRIPTPATH}/shared_data:/shared_data:ro \
  -p 8000:8000 --name jupyterhub test_jupyterhub jupyterhub --config=/srv/jupyterhub/jupyterhub_config.py

