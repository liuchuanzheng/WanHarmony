import { Article, ArticleList } from '../net/bean/ArticleBeans';
import { Banner } from '../net/bean/BannerBean';
import { UserData } from '../net/bean/UserInfoBean';
import { netService } from '../net/NetService';

class MeViewModel {

  getUserInfo(): Promise<UserData> {
    return netService.getUserInfo()
  }
}

let meViewModel = new MeViewModel()

export default meViewModel