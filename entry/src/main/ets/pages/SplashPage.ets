import { router } from '@kit.ArkUI'

@Entry
@Component
struct SplashPage {
  @State seconds: number = 3
  timerId: number = -1

  build() {
    Column() {
      Stack() {
        Image($r('app.media.splash_bg'))
          .width("100%")
          .height('100%')
          // 设置顶部绘制延伸到状态栏
          .expandSafeArea([SafeAreaType.SYSTEM],
            [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) //这个可以放到任何组件，只要它与状态栏/导航栏贴边，就会自动延伸

        Image($r('app.media.ic_logo'))
          .width(200)
          .height(200)
        Text($r('app.string.EntryAbility_label'))
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
          .offset({ x: 0, y: 200 })
        Text(this.seconds + 's')
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .width(80)
          .fontColor(Color.White)
          .position({ x: '100%', y: 0 })
          .translate({ x: -100, y: 20 })
          .border({ width: 2, radius: 100, color: Color.Black })
          .padding({
            left: 10,
            right: 10,
            top: 5,
            bottom: 5
          })
          .onClick(() => {
            this.clearTiming()
            this.jumpToMainPage()
          })
      }
      .backgroundColor(Color.Green)

      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])

    }
  }

  aboutToAppear(): void {
    console.log('SplashPage aboutToAppear')
  }
  onPageShow(): void {
    console.log('SplashPage onPageShow')
    this.startTiming()
  }

  aboutToDisappear(): void {
    console.log('SplashPage aboutToDisappear')
  }
  onPageHide(): void {
    console.log('SplashPage onPageHide')
    this.clearTiming()
  }

  startTiming(): void {
    this.timerId = setInterval(() => {
      this.seconds--
      if (this.seconds <= 0) {
        this.clearTiming()
        this.jumpToMainPage()
      }
    }, 1000)
  }

  clearTiming(): void {
    if (this.timerId != -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }

  }

  jumpToMainPage() {
    router.replaceUrl({ url: 'pages/MainPage' })
  }
}


