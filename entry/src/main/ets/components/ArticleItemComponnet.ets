import { Article } from '../net/bean/ArticleBeans'
import { isEmpty } from '../utils/Utils'

@Preview
@Component
export struct ArticleItemComponent {
  article: Article = new Article()

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_me_normal')).width(18).height(18)
          Text(isEmpty(this.article.author.toString()) ? this.article.shareUser.toString() :
            this.article.author.toString()) //2-author
        }

        Row() {
          Image($r('app.media.ic_clock')).width(18).height(18)
          Text(this.article.niceDate) //3-time
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
  }
}