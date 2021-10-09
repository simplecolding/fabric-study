/*
 * @Description: 设置链码对应key的值
 * @Author: Yan Jiang
 * @Date: 2021-10-09 16:12:43
 * @Reference:
 */
package sdkInit

import (
	"github.com/hyperledger/fabric-sdk-go/pkg/client/channel"
)

func (t *Application) Set(args []string) (string, error) {
	var tempArgs [][]byte
	// 第一个是调用的function，所以从1开始
	for i := 1; i < len(args); i++ {
		tempArgs = append(tempArgs, []byte(args[i]))
	}

	request := channel.Request{ChaincodeID: t.SdkEnvInfo.ChaincodeID, Fcn: args[0], Args: [][]byte{[]byte(args[1]), []byte(args[2])}}
	response, err := t.SdkEnvInfo.Client.Execute(request)
	if err != nil {
		// 资产转移失败
		return "", err
	}

	//fmt.Println("============== response:",response)

	return string(response.TransactionID), nil
}
