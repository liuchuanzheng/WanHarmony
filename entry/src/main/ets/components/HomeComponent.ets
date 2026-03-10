import homeViewModel from "../viewmodel/HomeViewModel"
import { hilog } from "@kit.PerformanceAnalysisKit";
import { Article } from "../net/bean/ArticleBeans";
import { ArticleItemComponent } from "./ArticleItemComponnet";

/**
 * 首页
 */
@Component
export struct HomeComponent {
  @State
  private articleList: Article[] = []
  @State pageNum: number = 0; //分页page
  aboutToAppear(): void {
    homeViewModel.getArticleList(0).then(res => {
      this.articleList = res.datas
    })
  }

  build() {
    Column() {
      List({space: 50}) {
        ForEach(this.articleList, (item: Article, index) => {
          ListItem() {
            ArticleItemComponent({article:item})
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Red)
    .justifyContent(FlexAlign.Center)

  }
}