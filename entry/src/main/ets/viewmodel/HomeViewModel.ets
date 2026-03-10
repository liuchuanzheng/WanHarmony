import { Article, ArticleList } from '../net/bean/ArticleBeans';
import { Banner } from '../net/bean/BannerBean';
import { netService } from '../net/NetService';

class HomeViewModel {
  getArticleList(pageNum: number): Promise<ArticleList> {
    console.log('业务网络请求', `文章列表第${pageNum}页`)
    return netService.getArticleList(pageNum)
  }

  getTopArticleList(): Promise<Article[]> {
    console.log('业务网络请求', '置顶文章列表')
    return netService.getTopArticleList()
  }

  getBannerList(): Promise<Banner[]> {
    console.log('业务网络请求', 'Banner列表')
    return netService.getBannerList()
  }
}

let homeViewModel = new HomeViewModel()

export default homeViewModel