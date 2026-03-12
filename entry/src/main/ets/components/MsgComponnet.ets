import { MsgReadListComponent } from "./MsgReadListComponnet"
import { MsgUnreadListComponent } from "./MsgUnreadListComponnet"

@Preview
@Component
export struct MsgComponent {
  build() {
    Tabs() {
      TabContent() {
        MsgReadListComponent()
      }.tabBar("已读消息")

      TabContent() {
        MsgUnreadListComponent()
      }.tabBar("未读消息")
    }.onChange((index) => {

    })

  }
}