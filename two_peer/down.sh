#!/bin/bash
docker rm -rf $(sudo docker ps -aq)
yes y|docker network prune
yes y|docker volume prune
yes y|docker system prune
