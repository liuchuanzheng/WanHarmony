import { prompt, router } from '@kit.ArkUI';
import loginOrRegisterViewModel from '../viewmodel/LoginOrRegisterViewModel';

@Entry
@Component
struct LoginOrRegisterPage {
  @State isRegister: boolean = false;
  @State inputUserName: string = '18501231486';
  @State inputPassword: string = '004876';
  @State inputRepassword: string = '';
  @State isShowProgress: boolean = false;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_arrow_left'))
          .size({ width: 30, height: 30 })
          .onClick(() => {
            router.back()
          })

      }.width('100%')

      Image($r('app.media.ic_logo'))
        .width(70)
        .height(70)
        .margin({ top: 100, bottom: 8 })
      Text(!this.isRegister ? '登录页面' : '注册页面')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      Text(!this.isRegister ? '登录账号使用更多服务' : '注册账号使用更多服务')
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ bottom: 30, top: 8 })
      TextInput({
        placeholder: '账号',
        text: this.inputUserName,
      })
        .onChange((value) => {
          this.inputUserName = value
        })
        .maxLength(16)
      TextInput({
        placeholder: '密码',
        text: this.inputPassword,
      })
        .onChange((value) => {
          this.inputPassword = value
        })
        .maxLength(16)
        .type(InputType.Password)
        .margin({ top: 10 })
      //注册时-显示确认密码
      if (this.isRegister) {
        TextInput({ placeholder: '确认密码', text: this.inputRepassword })
          .maxLength(16)
          .type(InputType.Password)
          .onChange((value) => {
            this.inputRepassword = value
          })
          .margin({ top: 10 })
      }
      Button(!this.isRegister ? '登录' : '注册', { type: ButtonType.Capsule })
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Color.Blue)
        .margin({ top: 87, bottom: 12 })
        .onClick(() => {
          this.buttonClick()
        })
      Text(!this.isRegister ? '没有账号，点击注册' : '已有账号，点击登录')
        .fontColor(Color.Blue)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.isRegister = !this.isRegister

        })
      if (this.isShowProgress) {
        LoadingProgress()
          .color(Color.Red)
          .width(50)
          .height(50)
          .margin({ top: 20 })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
    .padding(10)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  buttonClick() {
    if (this.isRegister) {
      this.register()
    } else {
      this.login()
    }
  }

  register() {
    //调试接口太麻烦，我写注册功能了。可以在玩安卓网站自己注册
    prompt.showToast({
      message: '暂无注册功能',
    })
  }

  login() {
    if (this.inputUserName == '' || this.inputPassword == "") {
      prompt.showToast({
        message: '请输入账号和密码',
      })
      return
    }
    this.isShowProgress = true
    loginOrRegisterViewModel.login(this.inputUserName, this.inputPassword).then((res) => {
      this.isShowProgress = false
      prompt.showToast({
        message: '登录成功',
      })
      setTimeout(() => {
        this.isShowProgress = false;
        router.replaceUrl({ url: 'pages/MainPage' })
      }, 1000);
    })
      .catch((err: Error) => {
        console.log('登录失败')
        this.isShowProgress = false
        prompt.showToast({
          message: err.message,
        })
      })
  }
}