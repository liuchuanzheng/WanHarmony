import { Article } from '../net/bean/ArticleBeans'
import { isEmpty } from '../utils/Utils'

@Preview
@Component
export struct ArticleItemComponent {
  article: Article = new Article()

  aboutToAppear(): void {
    // this.mockData()

  }

  private mockData() {
    this.article.author = '张三'
    this.article.niceDate = '2021-05-01'
    this.article.title = '这是标题'
    this.article.isTop = true
    this.article.superChapterName = '一级分类'
    this.article.chapterName = '二级分类'
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_me_normal')).width(18).height(18)
          //2-author
          Text(isEmpty(this.article.author.toString()) ? this.article.shareUser.toString() :
            this.article.author.toString())
            .fontColor(Color.Gray)
        }

        Row() {
          Image($r('app.media.ic_clock')).width(18).height(18)
          //3-time
          Text(this.article.niceDate)
            .fontColor(Color.Gray)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)


      Row() {
        Text(this.article.title)
          .fontSize(16)
          .fontColor(Color.Black)
          .width('100%')
          .maxLines(2)
          .textAlign(TextAlign.Start)
      }
      .height(80)
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row() {
        if (this.article.isTop) {
          Text('置顶')
            .height(23)
            .fontSize(12)
            .borderRadius(3)
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .backgroundColor('#FF8C00')
            .padding({
              left: 10,
              right: 10,
              top: 5,
              bottom: 5
            })
            .margin({ right: 10 })
        }
        if (this.article.superChapterName) {
          Text(this.article.superChapterName)
            .height(23)
            .fontSize(12)
            .borderRadius(3)
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .backgroundColor('#808000')
            .padding({
              left: 10,
              right: 10,
              top: 5,
              bottom: 5
            })
            .margin({ right: 10 })
        }
        if (this.article.chapterName) {
          Text(this.article.chapterName)
            .height(23)
            .fontSize(12)
            .borderRadius(3)
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .backgroundColor('#008080')
            .padding({
              left: 10,
              right: 10,
              top: 5,
              bottom: 5
            })
            .margin({ right: 10 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ top: 10 })
      .alignItems(VerticalAlign.Center)

    }
    .width('100%')
    .padding(5)
    .borderWidth(0.5)
    .borderColor(Color.Gray)
    .backgroundColor('#FFF1F3F5')
  }
}