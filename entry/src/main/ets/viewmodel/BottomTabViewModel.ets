export interface BottomTabsItem {
  icon: Resource;
  iconSelected: Resource;
  title: Resource;
}
export const bottomTabs: Array<BottomTabsItem> = [
  {
    icon: $r('app.media.ic_home_normal'),
    iconSelected: $r('app.media.ic_home_selected'),
    title: $r('app.string.bottom_text_home')
  },
  {
    icon: $r('app.media.ic_nav_normal'),
    iconSelected: $r('app.media.ic_nav_selected'),
    title: $r('app.string.bottom_text_nav')
  },
  {
    icon: $r('app.media.ic_project_normal'),
    iconSelected: $r('app.media.ic_project_selected'),
    title: $r('app.string.bottom_text_project')
  },
  {
    icon: $r('app.media.ic_msg_normal'),
    iconSelected: $r('app.media.ic_msg_selected'),
    title: $r('app.string.bottom_text_msg')
  },
  {
    icon: $r('app.media.ic_me_normal'),
    iconSelected: $r('app.media.ic_me_selected'),
    title: $r('app.string.bottom_text_me')
  }
]