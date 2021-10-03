#!/bin/bash
docker-compose down
docker rm -f $(sudo docker ps -aq)
sudo yes y|docker network prune
sudo yes y|docker volume prune
sudo yes y|docker system prune
sudo rm -rf ./channel-artifacts/*
sudo rm -rf ./crypto-config/*

cryptogen generate --config=crypto-config.yaml
# 生成创世块
configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block -channelID  fabric-channel

# 新建通道
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx  ./channel-artifacts/channel.tx -channelID mychannel

# 设置锚节点
configtxgen -profile TwoOrgsChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -asOrg Org1MSP

docker-compose up
