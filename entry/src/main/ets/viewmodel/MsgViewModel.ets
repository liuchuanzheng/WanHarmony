import { UserData } from '../net/bean/UserInfoBean';
import { cookieManager } from '../net/CookieManager';
import { netService } from '../net/NetService';
import { router } from '@kit.ArkUI';
import { MsgData } from '../net/bean/MsgBean';

class MsgViewModel {
  getMsgReadList(pageNum: number): Promise<MsgData> {
    return netService.getMsgReadList(pageNum)
  }
  getMsgUnreadList(): Promise<MsgData> {
    return netService.getMsgUnreadList()
  }

}

let msgViewModel = new MsgViewModel()

export default msgViewModel