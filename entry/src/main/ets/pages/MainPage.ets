import router from '@ohos.router'

@Entry
@Component
struct MainPage {

@State grayScale:number=0;

// onPageShow(){
//   if(router.getParams()['pageClear']==='Clear') {
//     router.clear()
//   }
// }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        Text("侧边栏区域")
          .width("100%")
          .height("100%")
          .fontSize(30)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height("100%")
      .backgroundColor(Color.White)

      //内容
      Column() {
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
      }
      .grayscale(this.grayScale)
      .width("100%")
      .height("100%")
      .backgroundColor(Color.White)
    }
    .showSideBar(false)
    //.showControlButton(false)
    .sideBarWidth('80%')
    .width('100%')
    .height('100%')
    .onChange((value)=>{
      if(value){
        animateTo({
          duration:350,
          curve:Curve.FastOutLinearIn,
          iterations:1,
          playMode:PlayMode.Normal
        },()=>{
          this.grayScale=0.3;
        })
      }
      else{
        animateTo({
          duration:300,
          curve:Curve.LinearOutSlowIn,
          iterations:1,
          playMode:PlayMode.Normal
        },()=>{
          this.grayScale=0;
        })
      }
    })
  }
}