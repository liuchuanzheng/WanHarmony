@Component
export struct MeComponent {
  build() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Pink)
      .justifyContent(FlexAlign.Center)

  }
}