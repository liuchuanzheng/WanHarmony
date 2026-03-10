import { Article, ArticleList } from "./bean/ArticleBeans";
import { Banner } from "./bean/BannerBean";
import { NetConstant } from "./NetConstant";
import { netUtil } from "./NetUtil";

class NetService {
  async getArticleList(pageNum: number): Promise<ArticleList> {
    let response = await netUtil.get(`${NetConstant.BASE_URL}/article/list/${pageNum}/json`)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as ArticleList;
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  // 获取置顶文章列表
  async getTopArticleList(): Promise<Article[]> {
    let response = await netUtil.get(`${NetConstant.BASE_URL}/article/top/json`)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as Article[];
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  // 获取首页banner
  async getBannerList(): Promise<Banner[]> {
    let response = await netUtil.get(`${NetConstant.BASE_URL}/banner/json`)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as Banner[];
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }
}

let netService = new NetService();

export { netService };