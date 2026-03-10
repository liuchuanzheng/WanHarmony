import { HomeComponent } from '../components/HomeComponent';
import { MeComponent } from '../components/MeComponnet';
import { MsgComponent } from '../components/MsgComponnet';
import { ProjectComponent } from '../components/ProjectComponnet';
import { TreeComponent } from '../components/TreeComponnet';
import { bottomTabs } from '../viewmodel/BottomTabViewModel';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World';
  @State currentTabIndex: number = 0;

  build() {
    Column() {

      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          HomeComponent()
        }
        .tabBar(this.MyTabBarBuilder(0))

        TabContent() {
          TreeComponent()
        }
        .tabBar(this.MyTabBarBuilder(1))

        TabContent() {
          ProjectComponent()
        }
        .tabBar(this.MyTabBarBuilder(2))

        TabContent() {
          MsgComponent()
        }
        .tabBar(this.MyTabBarBuilder(3))

        TabContent() {
          MeComponent()
        }
        .tabBar(this.MyTabBarBuilder(4))
      }
      .onChange((index)=>{
        this.currentTabIndex = index;
      })
      .vertical(false)
      .scrollable(false)
      .backgroundColor('#F1F3F5')
      .expandSafeArea([SafeAreaType.SYSTEM],
        [SafeAreaEdge.BOTTOM])//顶部底部安全区域也同色，避免底部导航栏和页面底部不同颜色
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MyTabBarBuilder(targetIndex: number) {
    Column() {
      Image(this.currentTabIndex == targetIndex ? bottomTabs[targetIndex].iconSelected : bottomTabs[targetIndex].icon)
        .width(24)
        .height(24)
      Text(bottomTabs[targetIndex].title)
        .fontSize(10)
        .opacity(0.8)
        .fontColor(this.currentTabIndex == targetIndex ?
          '#007DFF' : '#000000')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}