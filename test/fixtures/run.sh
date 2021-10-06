#!/bin/bash
docker-compose -f docker-compose-cli.yaml down
docker rm -f $(sudo docker ps -aq)
sudo yes y|docker network prune
sudo yes y|docker volume prune
sudo yes y|docker system prune
sudo rm -rf ./channel-artifacts/*
sudo rm -rf ./crypto-config/*
rm -rf mychannel.block
cryptogen generate --config=crypto-config.yaml
echo "生成创世区块+++++++++++++++++++++++++++++++++++++++++++++++"
configtxgen -profile GenesisChannel -outputBlock ./channel-artifacts/genesis.block -channelID  fabric-channel
echo "生成通道配置文件+++++++++++++++++++++++++++++++++++++++++++"
configtxgen -profile ALLChannel -outputCreateChannelTx  ./channel-artifacts/channel.tx -channelID mychannel
echo "生成个组织的锚节点文件+++++++++++++++++++++++++++++++++++++"
configtxgen -profile ALLChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -asOrg Org1MSP

configtxgen -profile ALLChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -asOrg Org2MSP

configtxgen -profile ALLChannel -channelID mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -asOrg Org3MSP
echo "开启启动docker-compose++++++++++++++++++++++++++++++++++++"
docker-compose -f docker-compose-cli.yaml up 


