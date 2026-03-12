import { Article, ArticleList } from '../net/bean/ArticleBeans';
import { Banner } from '../net/bean/BannerBean';
import { netService } from '../net/NetService';

class HomeViewModel {
  getArticleList(pageNum: number): Promise<ArticleList> {
    return netService.getArticleList(pageNum)
  }

  getTopArticleList(): Promise<Article[]> {
    return netService.getTopArticleList()
  }

  getBannerList(): Promise<Banner[]> {
    return netService.getBannerList()
  }
}

let homeViewModel = new HomeViewModel()

export default homeViewModel