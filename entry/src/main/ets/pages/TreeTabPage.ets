import { TreeItem } from "../net/bean/TreeBean";
import { router } from "@kit.ArkUI";
import { TreeTabListComponent } from "../components/TreeTabListComponent";

export class TreeTabPageRouterModel {
  public selectedTabIndex: number = 0;
  firstLevelTreeItem: TreeItem = new TreeItem();
}

@Entry
@Component
struct TreeTabPage {
  @State selectedTabIndex: number = 0;
  @Prop model: TreeTabPageRouterModel;

  aboutToAppear(): void {
    this.model = (this.getUIContext().getRouter().getParams()) as TreeTabPageRouterModel; // 获取传递过来的参数对象
  }

  build() {
    Column() {
      this.ToolBarBuilder(this.model.firstLevelTreeItem.name)
      //Tabs
      Tabs({ barPosition: BarPosition.Start, index: this.model.selectedTabIndex }) {
        ForEach(this.model.firstLevelTreeItem.children, (item: TreeItem, index?: number) => {
          TabContent() {
            TreeTabListComponent({cid:item.id})
          }.tabBar(item.name)
        }, (tabItem: TreeItem) => JSON.stringify(tabItem))
      }
      .barHeight(50)
      .height('100%')
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {

      })
      .vertical(false)
    }
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