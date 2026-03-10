import { http } from "@kit.NetworkKit";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { Article, ArticleList } from "../net/bean/ArticleBeans";
import BaseResponseBean from "../net/bean/BaseResponseBean";
import { netService } from "../net/NetService";
import { netUtil } from "../net/NetUtil";

class HomeViewModel {
  getArticleList(pageNum: number): Promise<ArticleList> {
    return netService.getArticleList(pageNum)
  }
}

let homeViewModel = new HomeViewModel()

export default homeViewModel