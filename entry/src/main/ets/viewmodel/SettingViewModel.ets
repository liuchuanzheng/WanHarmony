import { Article, ArticleList } from '../net/bean/ArticleBeans';
import { Banner } from '../net/bean/BannerBean';
import { UserData } from '../net/bean/UserInfoBean';
import { cookieManager } from '../net/CookieManager';
import { netService } from '../net/NetService';
import { router } from '@kit.ArkUI';

class SettingViewModel {
  getUserInfo(): Promise<UserData> {
    return netService.getUserInfo()
  }

  logout() {
    netService.logout().then((res)=>{
      cookieManager.clearCookies()
      router.replaceUrl({ url: 'pages/MainPage' })
    })
  }
}

let settingViewModel = new SettingViewModel()

export default settingViewModel