import { http } from "@kit.NetworkKit";
import { hilog } from "@kit.PerformanceAnalysisKit";
import BaseResponseBean from "./bean/BaseResponseBean";
import { NetConstant } from "./NetConstant";

/**
 * 网络请求工具类,封装get和post请求.尽量和业务无关
 */
class NetUtil {
  async get(url: string) {
    return await this.realNet(url, http.RequestMethod.GET)
  }

  async post(url: string, params?: object) {
    return await this.realNet(url, http.RequestMethod.POST, params)
  }

  private async realNet(url: string, method: http.RequestMethod, params?: object): Promise<BaseResponseBean> {
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息。
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。
    httpRequest.on('headersReceive', (header) => {
      hilog.info(0x0000, 'NetUtil', `header: ${JSON.stringify(header)}`);
    });
    try {
      let data = await httpRequest.request(url, {
        extraData: params,
        header: { "Content-Type": "application/json" },
        readTimeout: 1000 * 10,
        connectTimeout: 1000 * 10,
      })
      // data.result为HTTP响应内容，可根据业务需要进行解析。
      hilog.info(0x0000, 'testTag', `网络原始Result: ${JSON.stringify(data.result)}`);
      hilog.info(0x0000, 'testTag', `code: ${JSON.stringify(data.responseCode)}`);
      // data.header为HTTP响应头，可根据业务需要进行解析。
      hilog.info(0x0000, 'testTag', `header: ${JSON.stringify(data.header)}`);
      hilog.info(0x0000, 'testTag', `cookies: ${JSON.stringify(data.cookies)}`);
      if (data.responseCode == NetConstant.NET_SUCCESS_CODE) {
        let responseBean:BaseResponseBean = JSON.parse(data.result as string);
        return responseBean;
      } else {
        let responseBean = new BaseResponseBean();
        responseBean.errorCode = data.responseCode;
        responseBean.errorMsg = "请求失败";
        return responseBean;
      }
    } catch (err) {
      hilog.error(0x0000, 'testTag', `error: ${JSON.stringify(err)}`);
      let responseBean = new BaseResponseBean();
      responseBean.errorCode = NetConstant.NET_ERROR_CODE;
      responseBean.errorMsg = "网络异常";
      return responseBean;
    } finally {
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，调用destroy方法主动销毁。
      httpRequest.destroy();
    }

  }
}

export const netUtil = new NetUtil();