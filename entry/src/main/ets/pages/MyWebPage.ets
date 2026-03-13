import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct MyWebPage {
  @State params: object = router.getParams();
  @State title: string = this.params['title'] as string;
  controller: webview.WebviewController = new webview.WebviewController();
  @State progress: number = 0;
  aboutToAppear(): void {

  }

  build() {
    Column() {
      this.ToolBarBuilder(this.title)
      // 顶部进度条
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(2)
        .backgroundColor(Color.Gray)
        .color('#ff4cff00')
        .visibility(this.progress < 100 ? Visibility.Visible : Visibility.None)
      Web({ src: this.params['url'] as string, controller: this.controller })
        .onProgressChange((event) => {
          this.progress = event.newProgress;
        })
        .onPageEnd(() => {
          // 页面加载完成后隐藏进度条
          setTimeout(() => {
            this.progress = 100;
          }, 500);
        })
    }
    .width('100%')
    .height('100%')
  }
  @Builder
  ToolBarBuilder(title: string) {
    Row() {

      Image($r('app.media.ic_arrow_left'))
        .size({ width: 30, height: 30 })
        .margin({ right: 10 })
        .onClick(() => {
          router.back()
        })
      Text(title)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .maxLines(2)
        .fontSize(18)
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