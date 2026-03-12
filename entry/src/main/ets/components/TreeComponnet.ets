import { TreeItem } from "../net/bean/TreeBean"
import treeViewModel from "../viewmodel/TreeViewModel"
import { router } from "@kit.ArkUI"
import { TreeTabPageRouterModel } from "../pages/TreeTabPage"

@Component
export struct TreeComponent {
  @State treeList: TreeItem[] = []

  aboutToAppear(): void {
    treeViewModel.getTree().then(res => {
      this.treeList = res //两层体系数据
    })
  }

  build() {
    Column() {
      List() {
        ForEach(this.treeList, (item: TreeItem) => {
          ListItemGroup({ header: this.itemHead(item.name) }) {
            ListItem() {
              Flex({ direction: FlexDirection.Row,wrap: FlexWrap.Wrap, alignContent: FlexAlign.SpaceEvenly  }) {
                ForEach(item.children,(child: TreeItem,index: number)=>{
                  Text(child.name)
                    .textAlign(TextAlign.Center)
                    .height(30)
                    .border({ width: 1 })
                    .borderColor(Color.Black)
                    .borderRadius(2)
                    .padding({
                      top: 2,
                      bottom: 2,
                      left: 5,
                      right: 5
                    })
                    .margin(5)
                    .onClick(()=>{
                      let routerParams:TreeTabPageRouterModel = {
                        selectedTabIndex: index,
                        firstLevelTreeItem: item
                      }
                        router.push({ url: 'pages/TreeTabPage', params: routerParams })
                    })
                })

              }
              .width('100%')
            }
          }
        })
      }
      .sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)

  }

  @Builder
  itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text)
      .fontSize(20)
      .backgroundColor('#ffc3c7cb')
      .width('100%')
      .padding(5)
  }
}