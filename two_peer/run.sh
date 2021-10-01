#!/bin/bash
docker rm -rf $(sudo docker ps -aq)
sudo yes y|docker network prune
sudo yes y|docker volume prune
sudo yes y|docker system prune
sudo rm -rf ./channel-artifacts
sudo rm -rf ./crypto-config
cryptogen generate --config=crypto-config.yaml

configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block -channelID  fabric-channel

configtxgen -profile TwoOrgsChannel -outputCreateChannelTx  ./channel-artifacts/channel.tx -channelID mychannel


configtxgen -profile TwoOrgsChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -asOrg Org1MSP

configtxgen -profile TwoOrgsChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -asOrg Org2MSP


sudo docker-compose -f docker-compose-cli.yaml up





