import { router } from '@kit.ArkUI';
import { cookieManager } from '../net/CookieManager';
import settingViewModel from '../viewmodel/SettingViewModel';

@Entry
@Component
struct SettingPage {
  @State message: string = 'Hello World';
  @State isLogin: boolean = false;

  aboutToAppear(): void {
    this.isLogin = cookieManager.getCookieHeader().includes('login')
  }

  build() {
    Column() {
      this.ToolBarBuilder()
      List() {
        ForEach(['设置项1', '设置项2', '设置项3'], (item: string, index) => {
          ListItem() {
            Text(item)
              .fontSize(16)
              .fontColor(Color.Black)
              .margin({ bottom: 10 })
              .padding({ left: 10, right: 10 })
              .width("100%")
              .height(40)
              .backgroundColor(Color.White)
          }
        })
      }

      if (this.isLogin) {
        Button('退出登录', { type: ButtonType.Capsule })
          .width('90%')
          .height(40)
          .fontSize(16)
          .fontColor(Color.Red)
          .fontWeight(FontWeight.Medium)
          .backgroundColor("#ffe9e7df")
          .margin({ bottom: 50 })
          .onClick(() => {
            settingViewModel.logout()
          })
      }

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ToolBarBuilder() {
    Row() {

      Image($r('app.media.ic_arrow_left'))
        .size({ width: 30, height: 30 })
        .margin({ right: 10 })
        .onClick(() => {
          router.back()
        })
      Text("设置")
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .maxLines(1)
        .fontSize(22)
      Text('')
        .width(30)
        .height(30)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#007DFF")

    // .expandSafeArea([SafeAreaType.SYSTEM],
    //   [SafeAreaEdge.BOTTOM, SafeAreaEdge.TOP])
  }
}