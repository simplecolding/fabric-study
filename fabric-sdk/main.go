package main

import (
	"fabric-new-start/fabric-sdk/sdkInit"
	"fmt"
)

const (
	configFile  = "config.yaml"
	initialized = false
	SimpleCC    = "simplecc"
)

func main() {
	initInfo := &sdkInit.InitInfo{
		ChannelID:      "mychannel",
		ChannelConfig:  "/home/demo/go/src/fabric-new-start/fabric-sdk/fixtures/channel-artifacts/channel.tx",
		OrgName:        "Org1",
		OrgAdmin:       "Admin",
		OrdererOrgName: "orderer.example.com",
	}
	sdk, err := sdkInit.Setup(configFile, initialized)
	if err != nil {
		fmt.Printf(err.Error())
		return
	}
	fmt.Println(initInfo)
	defer sdk.Close()
	err = sdkInit.CreateChannel(sdk, initInfo)
	if err != nil {
		fmt.Printf(err.Error())
		return
	}
}
