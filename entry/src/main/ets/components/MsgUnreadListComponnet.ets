import { MsgItem } from '../net/bean/MsgBean'
import msgViewModel from '../viewmodel/MsgViewModel'
import { router } from '@kit.ArkUI'
import { cookieManager } from '../net/CookieManager'
import { isEmpty } from '../utils/Utils'
import MsgItemView from './MsgItemComponent'

@Preview
@Component
export struct MsgUnreadListComponent {
  @State msgUnreadList: MsgItem[] = []

  aboutToAppear(): void {
    msgViewModel.getMsgUnreadList().then(res => {
      if (!isEmpty(res)) {
        this.msgUnreadList = res.datas
      }

    })
  }

  build() {
    Column() {
      if (cookieManager.getCookieHeader().includes('login')) {
        //登录了
        if (this.msgUnreadList.length == 0) {
          this.MsgNoView()
        } else {
          List() {
            ForEach(this.msgUnreadList, (item: MsgItem, index) => {
              ListItem() {
                MsgItemView({ msgItem: item })
              }
            })
          }
        }
      } else {
        this.MsgNoLoginView()
      }

    }
  }

  @Builder
  MsgNoLoginView() {
    Text('登录后查看消息')
      .textAlign(TextAlign.Center)
      //.width('100%')
      //.height('100%')
      .onClick(() => {
        router.pushUrl({
          url: 'pages/LoginOrRegisterPage' // 目标url
        })
      })
  }

  @Builder
  MsgNoView() {
    Text('暂时没有数据哦')
      .textAlign(TextAlign.Center)
      .width('100%')
      .height('100%')
  }
}

