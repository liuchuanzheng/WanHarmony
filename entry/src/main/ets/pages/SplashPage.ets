@Entry
@Component
struct SplashPage {
  build() {
    Column(){
      Stack(){
        Image($r('app.media.splash_bg'))
          .width("100%")
          .height('100%')
          // 设置顶部绘制延伸到状态栏
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])//这个扩展全屏竟然得放到里层组件，不可思意

        Image($r('app.media.ic_logo'))
          .width(200)
          .height(200)
        Text($r('app.string.EntryAbility_label'))
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
          .offset({ x: 0, y: 200})
      }


    }
  }
}