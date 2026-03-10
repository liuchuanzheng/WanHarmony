@Entry
@Component
struct Me {
  build() {
    Column() {
      MeComponent()
    }
  }
}

@Component
export struct MeComponent {
  build() {
    Scroll() {
      Column() {
        this.ToolBarBuilder()
        Row() {
          Image($r('app.media.ic_user'))
            .margin({ left: 20 })
            .size({ width: 60, height: 60 })

          Text(`欢迎登陆`)
            .textAlign(TextAlign.Start)
            .maxLines(1)
            .fontSize(18)
            .margin({ left: 10, right: 10 })
            .layoutWeight(1)

          Image($r('app.media.ic_arrow_right'))
            .size({ width: 30, height: 30 })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(80)

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          this.InfoItem('排名', '——', (): void => {
          })
          this.InfoItem('收藏', '——', (): void => {
          })
          this.InfoItem('等级', '——', (): void => {
          })
          this.InfoItem('积分', '——', (): void => {
          })
        }.margin({ top:20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }.scrollable(ScrollDirection.Vertical)

  }

  @Builder
  InfoItem(title: string, content?: string, click?: () => void) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      Text(content)
        .margin({ top: 3 })
    }.flexGrow(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(click)
  }

  @Builder
  ToolBarBuilder() {
    Row() {
      Text("")
        .width(30)
      Text("我的")
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .maxLines(1)
        .fontSize(22)
      Image($r('app.media.ic_setting'))
        .width(30)
        .height(30)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.Blue)

    // .expandSafeArea([SafeAreaType.SYSTEM],
    //   [SafeAreaEdge.BOTTOM, SafeAreaEdge.TOP])
  }
}