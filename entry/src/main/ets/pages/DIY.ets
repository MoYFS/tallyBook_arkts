import display from '@ohos.display';
@Entry
@Component
struct DIY {
  // 屏幕宽度
  @State screenWidth:Number = 0
  // 侧边栏的x位置
  @State sideBarX: number = -2000
  // 侧边栏背景的透明度
  @State sideBarBgopacity: number = 0
  // 侧边栏背景显示值
  @State sideBarBgVisibility: Visibility = Visibility.Hidden

  aboutToAppear() {
    let data=display.getDefaultDisplaySync()
        this.screenWidth = data.width
        // 设置侧边栏偏移量：负屏幕宽度
        this.sideBarX = -this.screenWidth
  }

  // 打开侧边栏
  openSideMenu() {
    this.sideBarX = 0
    this.sideBarBgopacity = 1
    this.sideBarBgVisibility = Visibility.Visible
  }

  // 关闭侧边栏
  closeSideMenu() {
    this.sideBarX = -this.screenWidth
    this.sideBarBgopacity = 0
  }

  build() {
    Stack() {
      Column() {
        // 主页界面
        Blank()
          .color('#3CA0D0')
          .width('100%')
          .height('12%')
          .offset({ "x": "0.0px", "y": "0.0px" })
          .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
          .zIndex(2)
        Text("内容区域")
          .width("100%")
          .height("88%")
          .fontSize(30)
          .textAlign(TextAlign.Center)
        Button()
          .width('30%')
          .height('5%')
          .offset({'x':'0.0px','y':'-30%'})
          .onClick((event:ClickEvent)=>{
            this.openSideMenu()
          })
      }

      // 半透明背景
      Stack()
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .opacity(this.sideBarBgopacity)
        .animation({ // 属性动画，当透明度为0，隐藏背景
          duration: 300,
          onFinish:()=>{
            if(this.sideBarBgopacity == 0){
              this.sideBarBgVisibility = Visibility.Hidden
            }
          }
        })
        .visibility(this.sideBarBgVisibility)

      // 侧边栏
      Row() {
        Column() {

          Text("侧边栏区域")
            .width("100%")
            .height("100%")
            .fontSize(30)
            .textAlign(TextAlign.Center)
        }
        .width('70%')
        .height('100%')
        .backgroundColor(Color.White)

        Blank().onClick(() => {
          this.closeSideMenu()
        })
      }
      .width('100%')
      .height('100%')
      .position({ x: `${this.sideBarX}px`, y: 0 })// 动态改变位置
      .animation({ duration: 300 })// 属性动画
    }
    .width('100%')
    .height('100%')
  }
}