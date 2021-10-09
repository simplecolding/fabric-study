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
	org := []*sdkInit.OrgInfo{
		{
			OrgAdminUser:  "Admin",
			OrgName:       "Org1",
			OrgMspId:      "Org1MSP",
			OrgUser:       "User1",
			OrgPeerNum:    1,
			OrgAnchorFile: "/home/demo/go/src/test/fixtures/channel-artifacts/Org1MSPanchors.tx",
		},
		{
			OrgAdminUser:  "Admin",
			OrgName:       "Org2",
			OrgMspId:      "Org2MSP",
			OrgUser:       "User1",
			OrgPeerNum:    1,
			OrgAnchorFile: "/home/demo/go/src/test/fixtures/channel-artifacts/Org2MSPanchors.tx",
		},
		{
			OrgAdminUser:  "Admin",
			OrgName:       "Org3",
			OrgMspId:      "Org3MSP",
			OrgUser:       "User1",
			OrgPeerNum:    1,
			OrgAnchorFile: "/home/demo/go/src/test/fixtures/channel-artifacts/Org3MSPanchors.tx",
		},
	}
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
	info := sdkInit.SdkEnvInfo{
		ChannelID:        "mychannel",
		ChannelConfig:    "/home/demo/go/src/test/fixtures/channel-artifacts/channel.tx",
		Orgs:             org,
		OrdererAdminUser: "Admin",
		OrdererOrgName:   "OrdererOrg",
		OrdererEndpoint:  "orderer1.example.com",
		ChaincodeID:      cc_name,
		ChaincodePath:    "/home/demo/go/src/test/chaincode/",
		ChaincodeVersion: cc_version,
	}
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
	fmt.Println(info2)
	// sdk setup
	sdk := newClient("config-org1.yaml", &info)
	// sdk2 := newClient("config-org2.yaml", &info2)
	//defer sdk1.Close()
	// create channel and join
	if err := sdkInit.CreateAndJoinChannel(&info); err != nil {
		fmt.Printf(">> Create channel and join error:\n %v", err)
		os.Exit(-1)
	}

	// if err := sdkInit.CreateAndJoinChannel(&info2); err != nil {
	// 	fmt.Printf(">> Create channel and join error:\n %v", err)
	// 	os.Exit(-1)
	// }
	defer sdk.Close()
	// defer sdk2.Close()
	// create chaincode lifecycle
	if err := sdkInit.CreateCCLifecycle(&info, 1, false, sdk); err != nil {
		fmt.Println(">> create chaincode lifecycle error: %v", err)
		os.Exit(-1)
	}

	// invoke chaincode set status
	fmt.Println(">> 通过链码外部服务设置链码状态......")

	if err := info.InitService(info.ChaincodeID, info.ChannelID, info.Orgs[0], sdk); err != nil {

		fmt.Println("InitService successful")
		os.Exit(-1)
	}

	App = sdkInit.Application{
		SdkEnvInfo: &info,
	}
	fmt.Println(">> 设置链码状态完成")

	a := []string{"set", "ID", "123"}
	ret, err := App.Set(a)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("<--- 添加信息　--->：", ret)

	b := []string{"get", "ID"}
	response, err := App.Get(b)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("<--- 查询信息　--->：", response)
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
