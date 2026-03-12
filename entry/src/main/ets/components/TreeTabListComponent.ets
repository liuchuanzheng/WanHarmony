import { Article } from '../net/bean/ArticleBeans'
import { PullToRefresh, PullToRefreshType } from '@ohos/pulltorefresh/index'
import { ProjectArticleItemComponent } from './ProjectArticleItemComponnet'
import treeViewModel from '../viewmodel/TreeViewModel'
import { prompt } from '@kit.ArkUI'


@Component
export struct TreeTabListComponent {
  @Prop cid: number // 分类ID
  @State articleList: Article[] = []
  @State pageNum: number = 0
  @State refreshing: boolean = false

  aboutToAppear(): void {
    // 初始加载第一页数据
    this.loadData()
  }

  /**
   * 加载数据
   */
  private loadData(): void {
    treeViewModel.getTreeCidList(this.pageNum, this.cid).then(res => {
      if (this.pageNum === 0) {
        // 第一页数据直接替换
        this.articleList = res.datas
      } else {
        // 非第一页数据追加
        this.articleList = this.articleList.concat(res.datas)
      }
    })
  }

  /**
   * 列表构建器
   */
  @Builder
  private listViewBuilder() {
    List({ space: 0 }) {
      ForEach(this.articleList, (item: Article) => {
        ListItem() {
          ProjectArticleItemComponent({ article: item })
        }
      })
    }
  }

  build() {
    PullToRefresh({
      pullToRefreshType: PullToRefreshType.LIST,
      refreshing: this.refreshing,
      data: this.articleList,

      customList: () => {
        this.listViewBuilder()
      },

      // 下拉刷新回调
      onRefresh: () => {
        return new Promise<string>((resolve, reject) => {
          this.refreshing = true
          this.pageNum = 0

          setTimeout(() => {
            treeViewModel.getTreeCidList(this.pageNum, this.cid).then(res => {
              this.articleList = res.datas
              this.refreshing = false
              resolve('刷新成功')
            })
          }, 1000)
        })
      },

      // 上拉加载更多回调
      onLoadMore: () => {
        return new Promise<string>((resolve, reject) => {

          setTimeout(() => {
            this.pageNum++
            treeViewModel.getTreeCidList(this.pageNum, this.cid).then(res => {

              if(res.datas.length === 0) {
                this.pageNum--
                prompt.showToast({
                  message: '没有更多数据了'
                })
              }else {
                this.articleList = this.articleList.concat(res.datas)
              }
              resolve('加载成功')
            })
          }, 1000)
        })
      }
    })
  }
}