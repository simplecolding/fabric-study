echo -e "\n锚节点更新配置+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
cd ..
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

peer channel create -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel update -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/Org1MSPanchors.tx  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_ADDRESS=peer0.org2.example.com:8051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

peer channel update -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/Org2MSPanchors.tx  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export CORE_PEER_LOCALMSPID=Org3MSP
export CORE_PEER_ADDRESS=peer0.org3.example.com:9051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp

peer channel update -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/Org3MSPanchors.tx  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo -e "\n开始安装链码+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
# 安装链码，第一个先打包
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

peer channel create -o orderer1.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem
peer channel join -b mychannel.block
peer lifecycle chaincode package sacc.tar.gz --path /opt/gopath/src/github.com/hyperledger/fabric-cluster/chaincode/go/ --label sacc_1
peer lifecycle chaincode install sacc.tar.gz




export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_ADDRESS=peer0.org2.example.com:8051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
peer channel join -b mychannel.block
peer lifecycle chaincode install sacc.tar.gz





export CORE_PEER_LOCALMSPID=Org3MSP
export CORE_PEER_ADDRESS=peer0.org3.example.com:9051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
peer channel join -b mychannel.block
peer lifecycle chaincode install sacc.tar.gz


# 定义链码ID变量
echo -e "\n定义链码ID变量+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
export CC_PACKAGE_ID=sacc_1:511f0cb68d0bb7e9e49c5cdc9074a7460fe3c5bcde660a3ce599cc214b6c3707


export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp


export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer lifecycle chaincode approveformyorg --channelID mychannel --name sacc --version 1.0 --collections-config /opt/gopath/src/github.com/hyperledger/fabric-cluster/chaincode/collections_config.json --signature-policy "OR('Org1MSP.member','Org2MSP.member')" --package-id $CC_PACKAGE_ID --sequence 1 --tls true --cafile $ORDERER_CA

export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_ADDRESS=peer0.org2.example.com:8051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer lifecycle chaincode approveformyorg --channelID mychannel --name sacc --version 1.0 --collections-config /opt/gopath/src/github.com/hyperledger/fabric-cluster/chaincode/collections_config.json --signature-policy "OR('Org1MSP.member','Org2MSP.member')" --package-id $CC_PACKAGE_ID --sequence 1 --tls true --cafile $ORDERER_CA


# 组织1和2同意链码的安装
echo -e "\n同意安装链码+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export ORG2_CA=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

peer lifecycle chaincode commit -o orderer1.example.com:7050 \
--ordererTLSHostnameOverride orderer1.example.com --channelID mychannel \
--name sacc --version 1.0 --sequence 1 \
--collections-config /opt/gopath/src/github.com/hyperledger/fabric-cluster/chaincode/collections_config.json \
--signature-policy "OR('Org1MSP.member','Org2MSP.member')" \
--tls --cafile $ORDERER_CA \
--peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles $ORG1_CA \
--peerAddresses peer0.org2.example.com:8051 --tlsRootCertFiles $ORG2_CA



# 存储私有数据
echo -e "\n存储私有数据+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

export MARBLE=$(echo -n "{\"name\":\"marble1\",\"color\":\"blue\",\"size\":35,\"owner\":\"tom\",\"price\":99}" | base64 | tr -d \\n)

peer chaincode invoke -o orderer1.example.com:7050 --ordererTLSHostnameOverride orderer1.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n sacc -c '{"Args":["InitMarble"]}' --transient "{\"marble\":\"$MARBLE\"}"


# 休眠2s
sleep 2s

# Go to Org1
echo -e "\n用组织1查询2个都可以看到的数据+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
# 授权节点查询私有数据
# 查询2个组织都可以见到的数据
peer chaincode query -C mychannel -n sacc -c '{"Args":["ReadMarble","marble1"]}'
echo -e "查询只有组织1才能见到的数据price+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\
peer chaincode query -C mychannel -n sacc -c '{"Args":["ReadMarble","marble1"]}'\n
-------------------------------------------------------------------------------------------\n"
# 查询只有组织1才能见到的数据
peer chaincode query -C mychannel -n sacc \
-c '{"Args":["ReadMarblePrivateDetails","marble1"]}'

# 未授权的节点查询
echo -e "\n\n组织2查询price(未授权)+++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\-----------------------------------------"
export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_ADDRESS=peer0.org2.example.com:8051
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

peer chaincode query -C mychannel -n sacc \
-c '{"Args":["ReadMarblePrivateDetails","marble1"]}'

