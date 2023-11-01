import router from '@ohos.router'
import hilog from '@ohos.hilog';
import FaultLogger from '@ohos.faultLogger';

@Entry
@Component
struct MainPage {

  @State grayScale:number=0;
  @State showSide:boolean=true;
  @State showButton:Visibility=Visibility.None;
  @State account:string='Dear';
  //@State account:string=router.getParams()['account'];
  private controller: TabsController = new TabsController()


onPageShow(){
  // if(router.getParams()['pageClear']==='Clear') {
  //   router.clear()
  // }
}

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        Image($rawfile('gui/material_design_2.png'))
          .width('100%')
          .zIndex(1)
        Image($rawfile('gui/default_user_logo.png'))
          .width('35%')
          .offset({'x':'0.0px','y':'-18%'})
          .zIndex(2)
          Text(this.account)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .offset({'x':'0.0px','y':'-16.5%'})
            .zIndex(2)
      }
      .onTouch((event:TouchEvent)=>{
        this.showButton=Visibility.None
      })
      .width('100%')
      .height("100%")
      .backgroundColor(Color.White)

      //内容
      Column() {
        Stack() {
          Text("记账本")
            .width("100%")
            .height("100%")
            .fontColor(Color.White)
            .fontSize(24)
            .offset({ "x": "15%", "y": "20%" })
            .textAlign(TextAlign.Start)
          Button('···',{type:ButtonType.Normal,stateEffect:false})
            .rotate({angle:90})
            .fontSize(24)
            .backgroundColor(Color.Transparent)
            .fontWeight(FontWeight.Bolder)
            .offset({ "x": "40%", "y": "20%" })
            .onClick((event: ClickEvent)=>{
              hilog.info(0x0000,'test','test')
              this.showButton=Visibility.Visible
            })
          Button({type:ButtonType.Normal,stateEffect:true}){
            Text('用户信息')
              .fontSize(24)
              .fontColor(Color.Black)
              .offset({'x':'-20%','y':'0.0px'})
          }
          .borderRadius(3)
          .width('60%')
          .height('50%')
          .fontSize(24)
          .backgroundColor(Color.White)
          .fontWeight(FontWeight.Bolder)
          .visibility(this.showButton)
          .offset({ "x": "20%", "y": "20%" })
          .onClick((event: ClickEvent)=>{
            router.pushUrl({url:'pages/RegistrationPage',params:{
              account:this.account
            }})
          })
        }
        .onTouch((event:TouchEvent)=>{
          this.showButton=Visibility.None
        })
        .height('12%')
        .backgroundColor('#3CA0D0')
        .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })

        Tabs({barPosition:BarPosition.End,index:0,controller:this.controller}){
          TabContent() {
            Column() {
              Text('Tab1')

            }.width('100%')
          }.tabBar({icon:$rawfile('gui/tab_icon1.png'),text:'概要'})

          TabContent() {
            Column() {
              Text('Tab2')
            }.width('100%')
          }
          .tabBar({icon:$rawfile('gui/tab_icon2.png'),text:'收入'})

          TabContent() {
            Column() {
              Text('Tab2')
            }.width('100%')
          }
          .tabBar({icon:$rawfile('gui/tab_icon3.png'),text:'支出'})

        }
          .height('88%')
          .width('100%')
          .offset({ "x": "0.0px", "y": "0.0px" })
          .animationDuration(300)//tabBar切换时间
      }
      .onTouch((event:TouchEvent)=>{
        this.showButton=Visibility.None
      })
      .grayscale(this.grayScale)
      .width("100%")
      .height("100%")
      .backgroundColor(Color.White)
    }
    .showSideBar(false)
    .showControlButton(true)
    .sideBarWidth('80%')
    .width('100%')
    .height('100%')
    .minSideBarWidth('80%')
    .maxSideBarWidth('80%')
    .autoHide(true)
    .onChange((value)=>{
      if(value){
        this.showButton=Visibility.None
        animateTo({
          duration:350,
          curve:Curve.FastOutLinearIn,
          iterations:1,
          playMode:PlayMode.Normal
        },()=>{
          this.grayScale=0.3;
        })
        this.showSide=!this.showSide
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
        this.showSide=!this.showSide
      }
    })
  }

  pageTransition() {
    PageTransitionEnter({
      duration: globalThis.transitionTime,
      curve: Curve.Linear,
      type:RouteType.Pop
    })
      .slide(SlideEffect.Left)

    PageTransitionExit({
      duration:globalThis.transitionTime,
      type:RouteType.Push,
      curve: Curve.Linear,
    })
      .slide(SlideEffect.Left)
  }

}