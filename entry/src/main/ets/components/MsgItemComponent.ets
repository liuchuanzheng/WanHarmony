import { MsgItem } from "../net/bean/MsgBean"
import { router } from "@kit.ArkUI"

@Preview
@Component
export default struct MsgItemView {
  msgItem: MsgItem = new MsgItem()

  build() {
    Column() {
      //第一行
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Row() {
          Image($r('app.media.ic_me_normal')).width(18).height(18)
          Text(this.msgItem.fromUser).margin({ left: 5 }) //2-author
        }.margin({ left: 5, right: 5 })

        Text(this.msgItem.tag)
          .height(23)
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .borderRadius(3)
          .fontColor(Color.White)
          .backgroundColor('#B22222')
          .padding({
            left: 10,
            right: 10,
          })

        Row() {
          Image($r('app.media.ic_clock')).width(18).height(18)
          Text(this.msgItem.niceDate).margin({ left: 5 }) //2-author
        }.margin({ left: 5, right: 5 })
      }

      //第2行呢容
      Text(this.msgItem.title)
        // .height(30)
        .fontSize(12)
        .textAlign(TextAlign.Start)
        .borderRadius(3)
        .fontColor(Color.White)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .borderRadius(6)
        .backgroundColor('#4169E1')
        .margin({ top: 10 })
        .padding({
          left: 10,
          right: 10,
          top: 2,
          bottom: 2
        })
      //第3行呢容
      Text(this.msgItem.message)
        .textAlign(TextAlign.Start)
        .width('100%')
        .maxLines(3)
        .margin({ top: 10 })
    }
    .padding(10)
    .backgroundColor("#F5F5F5")
    .borderWidth(5)
    .borderColor("#D3D3D3")
    .onClick(() => {
      router.push({
        url: 'pages/MyWebPage',
        params: {
          url: this.msgItem.link,
          title: this.msgItem.title
        }
      })
    })
  }
}