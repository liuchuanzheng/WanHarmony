interface FuncInterface {
  'name': string;
  'backgroundColor': Color;
}

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
  gridData: FuncInterface[] = [
    {
      name: "工具",
      backgroundColor: Color.Red
    },
    {
      name: "问答",
      backgroundColor: Color.Orange
    },
    {
      name: "消息",
      backgroundColor: Color.Yellow
    },
    {
      name: "课程",
      backgroundColor: Color.Green
    },
    {
      name: "待办清单",
      backgroundColor: Color.Pink
    },
    {
      name: "分享文章",
      backgroundColor: Color.Grey
    },
  ]
  layoutOptions: GridLayoutOptions = {
    irregularIndexes: [1, 2, 3], //哪些键特殊
    onGetRectByIndex: (index: number) => {
      // ···
      if (index == 1) {
        return [0, 1, 1, 2]; //[rowStart,columnStart,rowSpan,columnSpan]
      } else if (index == 2) {
        return [1, 0, 1, 2];
      } else if (index == 3) {
        return [1, 2, 2, 1];
      }
      return [0, 0, 0, 0];
    },
    regularSize: [1, 1],
  }

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
        .onClick(() => {
          //点击头像区域
        })

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          this.InfoItem('排名', '——', (): void => {
          })
          this.InfoItem('收藏', '——', (): void => {
          })
          this.InfoItem('等级', '——', (): void => {
          })
          this.InfoItem('积分', '——', (): void => {
          })
        }.margin({ top: 20 })

        Column() {
          Text('常用功能')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })

          Grid(undefined, this.layoutOptions) {
            ForEach(this.gridData, (item: FuncInterface) => {
              GridItem() {
                Text(item.name)
              }.backgroundColor(item.backgroundColor)
            }, (item: FuncInterface): string => item.name)
          }
          .width('100%')
          .rowsGap(20)
          .columnsGap(10)
          .columnsTemplate(('1fr 1fr 1fr') as string)
          .rowsTemplate(('1fr 1fr 1fr 1fr') as string)

        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ left: 20, right: 20 })

      }
      .width('100%')
      // .height('100%')
      .backgroundColor('#F1F3F5')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)


    }
    .scrollBar(BarState.Off)
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)

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