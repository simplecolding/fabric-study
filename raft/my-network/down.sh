#!/bin/bash
docker-compose -f docker-compose-cli.yaml down
docker rm $(sudo docker ps -aq)
sudo yes y|docker network prune
sudo yes y|docker volume prune
sudo yes y|docker system prune
