import { Article, ArticleList } from "./bean/ArticleBeans";
import { Banner } from "./bean/BannerBean";
import BaseResponseBean from "./bean/BaseResponseBean";
import { MsgData } from "./bean/MsgBean";
import { ProjectItem } from "./bean/ProjectBean";
import { UserData, UserInfo } from "./bean/UserInfoBean";
import { NetConstant } from "./NetConstant";
import { netUtil } from "./NetUtil";

class NetService {
  async getArticleList(pageNum: number): Promise<ArticleList> {
    let url = `${NetConstant.BASE_URL}/article/list/${pageNum}/json`
    console.log('业务网络请求', `文章列表${pageNum}页`)
    console.log('业务网络请求', `${url}`)
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
    let url = `${NetConstant.BASE_URL}/article/top/json`
    console.log('业务网络请求', `置顶文章列表`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
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
    let url = `${NetConstant.BASE_URL}/banner/json`
    console.log('业务网络请求', `Banner列表`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as Banner[];
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async login(username: string, password: string): Promise<UserInfo> {

    let url = `${NetConstant.BASE_URL}/user/login`
    url = netUtil.buildUrl(url, Object({ username, password }))
    console.log('业务网络请求', `登录${username} ${password}`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.post(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as UserInfo;
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async getUserInfo(): Promise<UserData> {
    //不需要参数，因为在cookie中携带了用户凭证，是登录后返回的，
    let url = `${NetConstant.BASE_URL}/user/lg/userinfo/json`
    console.log('业务网络请求', `获取用户信息`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as UserData;
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async logout(): Promise<BaseResponseBean> {
    let url = `${NetConstant.BASE_URL}/user/logout/json`
    console.log('业务网络请求', `退出登录`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response;
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async getMsgReadList(pageNum: number): Promise<MsgData> {
    let url = `${NetConstant.BASE_URL}/message/lg/readed_list/${pageNum}/json`
    console.log('业务网络请求', `获取已读消息列表${pageNum}页`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      if (typeof response.data === 'number') { //没有数据时返回0，真是奇葩
        return new MsgData();
      } else {
        return response.data as MsgData;
      }
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async getMsgUnreadList(): Promise<MsgData> {
    let url = `${NetConstant.BASE_URL}/message/lg/count_unread/json`
    console.log('业务网络请求', `获取未读消息列表`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      if (typeof response.data === 'number') {
        return new MsgData();
      } else {
        return response.data as MsgData;
      }


    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async getProjectTree(): Promise<ProjectItem[]> {
    let url = `${NetConstant.BASE_URL}/project/tree/json`
    console.log('业务网络请求', `项目分类标签列表`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
    if (response.errorCode == NetConstant.BUSINESS_SUCCESS_CODE) {
      // 业务成功
      return response.data as ProjectItem[];
    } else {
      console.log(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
      // 非成功条件，抛出异常
      throw new Error(`业务失败：errorCode=${response.errorCode}, errorMsg=${response.errorMsg}`)
    }
  }

  async getProjectList(pageNum: number, cid: number): Promise<ArticleList> {
    let url = `${NetConstant.BASE_URL}/project/list/${pageNum}/json?cid=${cid}`
    console.log('业务网络请求', `项目标签下的具体列表`)
    console.log('业务网络请求', `${url}`)
    let response = await netUtil.get(url)
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