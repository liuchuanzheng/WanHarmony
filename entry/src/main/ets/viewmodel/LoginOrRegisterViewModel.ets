import BaseResponseBean from '../net/bean/BaseResponseBean';
import { UserInfo } from '../net/bean/UserInfoBean';
import { netService } from '../net/NetService';

class LoginOrRegisterViewModel {
  login(username: string, password: string): Promise<UserInfo> {

    return netService.login(username, password)
  }
}

let loginOrRegisterViewModel = new LoginOrRegisterViewModel()

export default loginOrRegisterViewModel