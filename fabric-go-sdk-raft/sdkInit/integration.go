/*
 * @Description:
 * @Author: Yan Jiang
 * @Date: 2021-10-06 14:45:57
 * @Reference:
 */

package sdkInit

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/client/channel"
	"github.com/hyperledger/fabric-sdk-go/pkg/common/errors/retry"
	"github.com/hyperledger/fabric-sdk-go/pkg/common/errors/status"
	contextAPI "github.com/hyperledger/fabric-sdk-go/pkg/common/providers/context"
	fabAPI "github.com/hyperledger/fabric-sdk-go/pkg/common/providers/fab"
	contextImpl "github.com/hyperledger/fabric-sdk-go/pkg/context"
	"github.com/hyperledger/fabric-sdk-go/pkg/fabsdk"

	"time"
)

/**
 * @description: 发现组织的peer节点信息
 * @param {contextAPI.ClientProvider} ctxProvider 对应组织的admin客户端上下文
 * @param {int} expectedPeers 期望得到的组织节点数，即已经指导组织有的节点数
 * @return {*}
 * @author: Yan Jiang
 * @Date: 2021-10-06 14:50:25
 */
func DiscoverLocalPeers(ctxProvider contextAPI.ClientProvider, expectedPeers int) ([]fabAPI.Peer, error) {
	// 返回一个本地的上下文信息
	ctx, err := contextImpl.NewLocal(ctxProvider)
	if err != nil {
		return nil, fmt.Errorf("error creating local context: %v", err)
	}
	// 通过传入的参数不断重试（底层为gossip）
	discoveredPeers, err := retry.NewInvoker(retry.New(retry.TestRetryOpts)).Invoke(
		func() (interface{}, error) {
			// 调用内核的peer发现
			peers, serviceErr := ctx.LocalDiscoveryService().GetPeers()
			if serviceErr != nil {
				return nil, fmt.Errorf("getting peers for MSP [%s] error: %v", ctx.Identifier().MSPID, serviceErr)
			}
			// 如果探测的peer较少
			if len(peers) < expectedPeers {
				return nil, status.New(status.TestStatus, status.GenericTransient.ToInt32(), fmt.Sprintf("Expecting %d peers but got %d", expectedPeers, len(peers)), nil)
			}
			return peers, nil
		},
	)
	if err != nil {
		return nil, err
	}
	// 返回该组织内的所有peer信息
	return discoveredPeers.([]fabAPI.Peer), nil
}
func (t *SdkEnvInfo) InitService(chaincodeID, channelID string, org *OrgInfo, sdk *fabsdk.FabricSDK) error {
	handler := &SdkEnvInfo{
		ChaincodeID: chaincodeID,
	}
	//prepare channel client context using client context
	// 获得指定组织用户的channel上下文
	clientChannelContext := sdk.ChannelContext(channelID, fabsdk.WithUser(org.OrgUser), fabsdk.WithOrg(org.OrgName))
	// Channel client is used to query and execute transactions (Org1 is default org)
	var err error
	t.Client, err = channel.New(clientChannelContext)
	if err != nil {
		return nil
	}
	handler.Client = t.Client
	return nil
}

func regitserEvent(client *channel.Client, chaincodeID, eventID string) (fabAPI.Registration, <-chan *fabAPI.CCEvent) {

	reg, notifier, err := client.RegisterChaincodeEvent(chaincodeID, eventID)
	if err != nil {
		fmt.Println("注册链码事件失败: %s", err)
	}
	return reg, notifier
}

func eventResult(notifier <-chan *fabAPI.CCEvent, eventID string) error {
	select {
	case ccEvent := <-notifier:
		fmt.Printf("接收到链码事件: %v\n", ccEvent)
	case <-time.After(time.Second * 20):
		return fmt.Errorf("不能根据指定的事件ID接收到相应的链码事件(%s)", eventID)
	}
	return nil
}
