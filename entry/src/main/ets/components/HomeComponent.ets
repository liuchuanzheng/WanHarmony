import homeViewModel from "../viewmodel/HomeViewModel"
import { Article } from "../net/bean/ArticleBeans";
import { ArticleItemComponent } from "./ArticleItemComponnet";
import { PullToRefresh, PullToRefreshType } from '@ohos/pulltorefresh/index';

/**
 * 首页
 */
@Component
export struct HomeComponent {
  @State
  private articleList: Article[] = []
  @State
  pageNum: number = 0; //分页page
  private scroller: Scroller = new Scroller(); // 需绑定列表或宫格组件
  @State
  refreshing: boolean = false;

  aboutToAppear(): void {
    Promise.all([homeViewModel.getArticleList(0), homeViewModel.getTopArticleList(), homeViewModel.getBannerList()])
      .then(result => {
        let articleList = result[0].datas
        let topArticleList = result[1]
        let bannerList = result[2]
        topArticleList.forEach((item) => {
          item.isTop = true
        })
        this.articleList = topArticleList.concat(articleList)
      })
    // homeViewModel.getArticleList(0).then(res => {
    //   this.articleList = this.articleList.concat(res.datas)
    // })
    // homeViewModel.getTopArticleList().then(res => {
    //   if (!this.hasGotTop) {
    //     res.forEach((item) => {
    //       item.isTop = true
    //     })
    //     this.articleList = res.concat(this.articleList)
    //     this.hasGotTop = true
    //   }
    // })
    // homeViewModel.getBannerList().then(res => {
    //   console.log('banner', res)
    // })
  }

  @Builder
  listViewBuilder() {
    List({ space: 0 }) {
      ForEach(this.articleList, (item: Article, index) => {
        ListItem() {
          ArticleItemComponent({ article: item })
        }
      })
    }
  }

  build() {
    Column() {
      PullToRefresh({
        //必传项，容器主体布局类型
        pullToRefreshType: PullToRefreshType.LIST,
        //必传项，控制是否进行下拉刷新
        refreshing: this.refreshing,
        data: this.articleList,


        customList: () => {
          this.listViewBuilder()
        },
        onRefresh: () => {

          return new Promise<string>((resolve, reject) => {
            this.pageNum = 0

            this.refreshing = true
            setTimeout(() => {
              Promise.all([homeViewModel.getArticleList(0), homeViewModel.getTopArticleList(),
                homeViewModel.getBannerList()]).then(result => {
                let articleList = result[0].datas
                let topArticleList = result[1]
                let bannerList = result[2]
                topArticleList.forEach((item) => {
                  item.isTop = true
                })
                this.articleList = topArticleList.concat(articleList)
                resolve('刷新成功')
              })

            }, 2000) //为了看刷新动画

          });
        },
        onLoadMore: () => {
          return new Promise<string>((resolve, reject) => {
            this.pageNum++
            homeViewModel.getArticleList(this.pageNum).then(res => {
              this.articleList = this.articleList.concat(res.datas)
              resolve('加载成功')
            })

          });
        },
        customLoad: null,
        customRefresh: null,
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Red)
    .justifyContent(FlexAlign.Center)

  }
}