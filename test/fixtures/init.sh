#!/bin/bash
export FABRIC_CFG_PATH=/home/demo/go/src/github.com/hyperledger/fabric/scripts/config

configtxgen -profile ALLChannel  -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel  -asOrg Org1MSP

configtxgen -profile ALLChannel  -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel  -asOrg Org2MSP

configtxgen -profile ALLChannel  -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID mychannel  -asOrg Org3MSP

peer channel create -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem
