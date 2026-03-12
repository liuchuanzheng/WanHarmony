import { netService } from '../net/NetService';
import { ProjectItem } from '../net/bean/ProjectBean';
import { ArticleList } from '../net/bean/ArticleBeans';

class ProjectViewModel {
  getProjectTree(): Promise<ProjectItem[]> {
    return netService.getProjectTree()
  }
  getProjectList(pageNum:number,cid:number): Promise<ArticleList> {
    return netService.getProjectList(pageNum,cid)
  }

}

let projectViewModel = new ProjectViewModel()

export default projectViewModel