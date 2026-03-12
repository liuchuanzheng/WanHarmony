import projectViewModel from '../viewmodel/ProjectViewModel'
import { ProjectItem } from '../net/bean/ProjectBean'
import { ProjectArticleListComponent } from './ProjectArticleListComponent'

/**
 * 项目页面组件
 * 顶部Tab切换不同项目分类，每个Tab对应独立的文章列表
 */
@Component
export struct ProjectComponent {
  @State projectTree: ProjectItem[] = []

  aboutToAppear(): void {
    // 获取项目分类树
    projectViewModel.getProjectTree().then(res => {
      this.projectTree = res
    })
  }

  build() {
    Column() {
      // 顶部Tab栏
      Tabs() {
        ForEach(this.projectTree, (item: ProjectItem) => {
          TabContent() {
            // 每个Tab对应独立的文章列表组件
            ProjectArticleListComponent({ cid: item.id })
          }
          .tabBar(item.name)
        })
      }
      .width('100%')
      .height('100%')
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        console.log('切换到项目分类:', this.projectTree[index].name)
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}