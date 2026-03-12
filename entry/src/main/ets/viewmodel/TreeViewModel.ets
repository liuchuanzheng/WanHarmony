import { netService } from '../net/NetService';
import { ProjectItem } from '../net/bean/ProjectBean';
import { ArticleList } from '../net/bean/ArticleBeans';
import { TreeArticle, TreeItem } from '../net/bean/TreeBean';

class TreeViewModel {
  getTree(): Promise<TreeItem[]> {
    return netService.getTree()
  }

  getTreeCidList(pageNum: number, cid: number): Promise<TreeArticle> {
    return netService.getTreeCidList(pageNum, cid)
  }
}

let treeViewModel = new TreeViewModel()

export default treeViewModel