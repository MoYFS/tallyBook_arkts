import router from '@ohos.router'
import hilog from '@ohos.hilog';
import  inout from '../commom/dataclass/inout'
import display from '@ohos.display';
import { PieChart , PicChartElement} from '../view/PieChart'
import dataOperation from '../commom/dataclass/dataOperation';
import CommonConstants from '../commom/constant/CommonConstand'

@Entry
@Component
struct MainPage {

  @State grayScale:number=0;
  @State showSide:boolean=true;
  @State showButton:boolean=false;
  @State scale1:number=1;
  @State account:string='Dear';
  //@State account:string=router.getParams()['account'];
  private controller: TabsController = new TabsController()
  private pieColor:Color[]=[Color.Blue,Color.Brown,Color.Gray,Color.Green,Color.Orange,Color.Pink,Color.Red,Color.Yellow]
  @State balance:number=0;
  @State dataOperation:dataOperation=new dataOperation()

  aboutToAppear(){
    this.dataOperation.IncomeList=[new inout(0,1,0,'工资',1000)]
    this.dataOperation.DisbList=[new inout(1,2,3,'电影',100),new inout(1,3,4,'房租',300)]
    this.dataOperation.strikingBalance()
    this.balance=this.dataOperation.remainingSum
  }

  onPageShow(){
    this.dataOperation.IncomeList=[new inout(0,1,0,'工资',1000)]
    this.dataOperation.DisbList=[new inout(1,2,3,'电影',100),new inout(1,3,4,'房租',300)]
    this.dataOperation.strikingBalance()
    this.balance=this.dataOperation.remainingSum
  // if(router.getParams()['pageClear']==='Clear') {
    router.clear()
  // }
    this.showButton=false;
  }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        Image($rawfile('gui/material_design_2.png'))
          .width('100%')
          .zIndex(1)
        Image($rawfile('gui/default_user_logo.png'))
          .width('35%')
          .offset({ 'x': '0.0px', 'y': '-18%' })
          .zIndex(2)
        Text(this.account)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .offset({ 'x': '0.0px', 'y': '-16.5%' })
          .zIndex(2)
        Button({ type: ButtonType.Normal, stateEffect: true }){
          Row() {
            Image($rawfile('gui/ic_sitting.png'))
              .width('25%')
              .height('120%')
              .scale({ x: 0.4, y: 0.4 })
            Text('设置')
              .fontSize(24)
          }
        }
        .align(Alignment.Start)
        .width('100%')
        .height('8%')
        .offset({ 'x': '0.0px', 'y': '-16%' })
        .backgroundColor(Color.Transparent)
        .onClick((event:ClickEvent)=>{
          router.pushUrl({url:'pages/SittingPage'})
        })

        Button({type:ButtonType.Normal,stateEffect:true}) {
          Row() {
            Image($rawfile('gui/ic_share.png'))
              .width('25%')
              .height('120%')
              .scale({ x: 0.4, y: 0.4 })
            Text('分享')
              .fontSize(24)
          }
        }
        .align(Alignment.Start)
        .width('100%')
        .height('8%')
        .offset({ 'x': '0.0px', 'y': '-16%' })
        .backgroundColor(Color.Transparent)

        Button({type:ButtonType.Normal,stateEffect:true}) {
          Row() {
            Image($rawfile('gui/ic_assessment_grey600_24dp.png'))
              .width('25%')
              .height('120%')
              .scale({ x: 0.4, y: 0.4 })
            Text('报告')
              .fontSize(24)
          }
        }
        .align(Alignment.Start)
        .width('100%')
        .height('8%')
        .offset({ 'x': '0.0px', 'y': '-16%' })
        .backgroundColor(Color.Transparent)
        Divider()//分割线
          .vertical(false)
          .strokeWidth(2)
          .offset({'x':'0.0px','y':'-16%'})
        Button({type:ButtonType.Normal,stateEffect:true}) {
          Row() {
            Image($rawfile('gui/ic_help_grey600_24dp.png'))
              .width('25%')
              .height('120%')
              .scale({ x: 0.4, y: 0.4 })
            Text('帮助')
              .fontSize(24)
          }
        }
        .align(Alignment.Start)
        .width('100%')
        .height('8%')
        .offset({ 'x': '0.0px', 'y': '-10%' })
        .backgroundColor(Color.Transparent)
        .onClick((event: ClickEvent)=>{
          router.pushUrl({url:'pages/HelpPage'})
        })

        Button({type:ButtonType.Normal,stateEffect:true}) {
          Row() {
            Image($rawfile('gui/ic_assessment_grey600_24dp.png'))
              .width('25%')
              .height('120%')
              .scale({ x: 0.4, y: 0.4 })
            Text('关于')
              .fontSize(24)
          }
        }
        .align(Alignment.Start)
        .width('100%')
        .height('8%')
        .offset({ 'x': '0.0px', 'y': '-10%' })
        .backgroundColor(Color.Transparent)
        .onClick((event: ClickEvent)=>{
          router.pushUrl({url:'pages/AboutPage'})
        })
      }
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
          Button('···', { type: ButtonType.Normal, stateEffect: false })
            .rotate({ angle: 90 })
            .fontSize(24)
            .backgroundColor(Color.Transparent)
            .fontWeight(FontWeight.Bolder)
            .offset({ "x": "40%", "y": "20%" })
            .onClick((event: ClickEvent) => {
              animateTo({ duration: 200 }, () => {
                this.showButton = true
              })
            })
          if(this.showButton){
            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text('用户信息')
                .fontSize(24)
                .fontColor(Color.Black)
                .offset({ 'x': '-20%', 'y': '0.0px' })
            }
            .borderRadius(3)
            .width('60%')
            .height('50%')
            .fontSize(24)
            .backgroundColor(Color.White)
            .fontWeight(FontWeight.Bolder)
            .offset({ "x": "19%", "y": "20%" })
            .shadow({ radius: 6, color: "00001E", offsetX: 0, offsetY: 0 })
            .onClick((event: ClickEvent) => {
              router.pushUrl({ url: 'pages/RegistrationPage', params: {
                account: this.account
              }
              })
            })
            .transition({type:TransitionType.Insert,opacity:0,scale:{x:0,y:1,centerX:'100%'}})
            .transition({type:TransitionType.Delete,opacity:0,scale:{x:0,y:1,centerX:'100%'}})
          }
        }
        .height('12%')
        .backgroundColor('#3CA0D0')
        .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })

        Tabs({barPosition:BarPosition.End,index:0,controller:this.controller}){
          TabContent() {
            Column({space:10}) {//概要页面开始
              Text('账户余额')
                .fontSize(24)
                .offset({'x':'0px','y':'2%'})
              Text(this.balance.toString())
                .fontSize(24)
                .offset({'x':'0px','y':'2%'})
              PieChart({picChartElements:this.dataOperation.DisbList.map((value)=>{
                return new PicChartElement(value.category,value.money,this.pieColor[value.cateid].toString())
                })
              })
                .height('100%')
                .offset({'x':'0px','y':'10%'})
                .scale({x:1.2,y:1.2})
                      //概要页面结束
            }.width('100%')
            .height('100%')
          }.tabBar({icon:$rawfile('gui/tab_icon1.png'),text:'概要'})

          TabContent() {
            Column() {//收入页面开始
              Text('黄达')


                      //收入页面结束
            }.width('100%')
          }
          .tabBar({icon:$rawfile('gui/tab_icon2.png'),text:'收入'})

          TabContent() {
            Column() {//支出页面开始
              Text('陈尹')


                      //支出页面结束
            }.width('100%')
          }
          .tabBar({icon:$rawfile('gui/tab_icon3.png'),text:'支出'})

        }
          .height('88%')
          .width('100%')
          .offset({ "x": "0.0px", "y": "0.0px" })
          .animationDuration(200)//tabBar切换时间
          .onTouch((event:TouchEvent)=>{
              animateTo({ duration: 200 }, () => {
                this.showButton = false
              })
          })
      }
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
        animateTo({ duration: 200 }, () => {
          this.showButton = false
        })
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
      duration: 200,
      curve: Curve.Linear,
      type:RouteType.Pop
    })
      .slide(SlideEffect.Left)

    PageTransitionExit({
      duration:200,
      type:RouteType.Push,
      curve: Curve.Linear,
    })
      .slide(SlideEffect.Left)
  }

}