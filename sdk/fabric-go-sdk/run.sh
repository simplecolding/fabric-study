#!/bin/bash
cd ./fixtures
docker-compose down
docker rm -rf $(sudo docker ps -aq)
yes y|docker network prune
yes y|docker volume prune
docker-compose up -d
cd ..
rm -rf ./fabric-go-sdk
go build
./fabric-go-sdk
