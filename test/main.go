/*
 * @Description: sdk操作主程序
 * @Author: Yan Jiang
 * @Date: 2021-10-06 15:12:35
 * @Reference:
 */
package main

import (
	"fmt"
	"os"
	"test/sdkInit"

	"github.com/hyperledger/fabric-sdk-go/pkg/fabsdk"
)

const (
	cc_name    = "simplecc"
	cc_version = "1.0.0"
)

var App sdkInit.Application

func main() {
	// org1 := []*sdkInit.OrgInfo{
	// 	{
	// 		OrgAdminUser:  "Admin",
	// 		OrgName:       "Org1",
	// 		OrgMspId:      "Org1MSP",
	// 		OrgUser:       "User1",
	// 		OrgPeerNum:    1,
	// 		OrgAnchorFile: "/home/demo/go/src/test/fixtures/channel-artifacts/Org1MSPanchors.tx",
	// 	},
	// }
	org2 := []*sdkInit.OrgInfo{
		{
			OrgAdminUser:  "Admin",
			OrgName:       "Org2",
			OrgMspId:      "Org2MSP",
			OrgUser:       "User1",
			OrgPeerNum:    1,
			OrgAnchorFile: "/home/demo/go/src/test/fixtures/channel-artifacts/Org2MSPanchors.tx",
		},
	}

	// init sdk env info
	// info1 := sdkInit.SdkEnvInfo{
	// 	ChannelID:        "mychannel",
	// 	ChannelConfig:    "/home/demo/go/src/test/fixtures/channel-artifacts/channel.tx",
	// 	Orgs:             org1,
	// 	OrdererAdminUser: "Admin",
	// 	OrdererOrgName:   "OrdererOrg",
	// 	OrdererEndpoint:  "orderer1.example.com",
	// 	ChaincodeID:      cc_name,
	// 	ChaincodePath:    "/home/demo/go/src/test/chaincode/",
	// 	ChaincodeVersion: cc_version,
	// }
	info2 := sdkInit.SdkEnvInfo{
		ChannelID:        "mychannel",
		ChannelConfig:    "/home/demo/go/src/test/fixtures/channel-artifacts/channel.tx",
		Orgs:             org2,
		OrdererAdminUser: "Admin",
		OrdererOrgName:   "OrdererOrg",
		OrdererEndpoint:  "orderer1.example.com",
		ChaincodeID:      cc_name,
		ChaincodePath:    "/home/demo/go/src/test/chaincode/",
		ChaincodeVersion: cc_version,
	}
	// fmt.Println(info1)
	// sdk setup
	//sdk1 := newClient("config-org1.yaml", &info1)
	sdk2 := newClient("config-org2.yaml", &info2)
	//defer sdk1.Close()

	// create channel and join
	// if err := sdkInit.CreateAndJoinChannel(&info1); err != nil {
	// 	fmt.Printf(">> Create channel and join error:\n %v", err)
	// 	os.Exit(-1)
	// }

	if err := sdkInit.CreateAndJoinChannel(&info2); err != nil {
		fmt.Printf(">> Create channel and join error:\n %v", err)
		os.Exit(-1)
	}
	defer sdk2.Close()
}
func newClient(config string, info *sdkInit.SdkEnvInfo) *fabsdk.FabricSDK {
	sdk, err := sdkInit.Setup(config, info)
	if err != nil {
		fmt.Println(">> SDK setup error:", err)
		os.Exit(-1)
	}
	fmt.Println("通过配置文件生成sdk实例成功")
	return sdk
}
