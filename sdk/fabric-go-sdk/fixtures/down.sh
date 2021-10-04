#!/bin/bash
docker-compose down
docker rm -f $(sudo docker ps -aq)
sudo yes y|docker network prune
sudo yes y|docker volume prune
sudo yes y|docker system prune
sudo rm -rf ./channel-artifacts/*
sudo rm -rf ./crypto-config/*
