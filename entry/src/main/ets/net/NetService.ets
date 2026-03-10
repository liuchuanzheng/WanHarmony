import { ArticleList } from "./bean/ArticleBeans";
import { NetConstant } from "./NetConstant";
import { netUtil } from "./NetUtil";

class NetService {
  async getArticleList(pageNum: number): Promise<ArticleList> {
    let response = await netUtil.get(`https://www.wanandroid.com/article/list/${pageNum}/json`)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as ArticleList;
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }
}

let netService = new NetService();

export { netService };