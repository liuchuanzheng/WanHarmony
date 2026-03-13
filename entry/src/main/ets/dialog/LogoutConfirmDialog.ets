// 自定义退出登录确认弹窗组件
@CustomDialog
export struct LogoutConfirmDialog {
  controller: CustomDialogController;
  onConfirm: () => void = () => {
  };
  onCancel: () => void = () => {
  };

  build() {
    Column({ space: 20 }) {
      Text('确认退出登录')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)

      Text('确定要退出当前账号吗？')
        .fontSize(14)
        .fontColor(Color.Gray)
        .textAlign(TextAlign.Center)

      Row({ space: 20 }) {
        Button('取消', { type: ButtonType.Capsule })
          .width('40%')
          .height(40)
          .fontSize(16)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .onClick(() => {
            this.onCancel();
          })

        Button('确定', { type: ButtonType.Capsule })
          .width('40%')
          .height(40)
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .onClick(() => {
            this.onConfirm();
          })
      }
    }
    .width('100%')
    .padding({
      top: 30,
      bottom: 30,
      left: 20,
      right: 20
    })
    .backgroundColor(Color.White)
    .borderRadius(10)
    .shadow({
      radius: 10,
      color: Color.Gray,
      offsetX: 0,
      offsetY: 0
    })
  }
}