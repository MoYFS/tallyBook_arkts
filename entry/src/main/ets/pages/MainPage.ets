import router from '@ohos.router';
import  inout from '../commom/dataclass/inout';
import { PieChart} from '../view/PieChart';
import {PicChartElement} from  '../commom/dataclass/PicChartElement';
import dataOperation from '../commom/dataclass/dataOperation';
import { CommonConstats,cateIdDefine}  from '../commom/constant/CommonConstand';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';

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
  @State @Watch('change') dataOperation:dataOperation=new dataOperation()
  @StorageLink('PieElement') PieElement:PicChartElement[]=[]
  @StorageLink('PieSum') PieSum:number=0;

  aboutToAppear(){
    this.dataOperation.IncomeList.push(new inout(0,0,cateIdDefine.gongzi,'工资',100000))
    this.dataOperation.DisbList.push(new inout(3,1,cateIdDefine.dianying,'电影',100),new inout(4,1,cateIdDefine.fangzu,'房租',300),new inout(2,1,cateIdDefine.tushu,'图书',1000),new inout(5,1,cateIdDefine.tushu,'图书',100))
    this.dataOperation.strikingBalance()
    this.dataOperation.Statexp()
  }

  onPageShow(){
    router.clear()
    this.showButton=false;
  }

  change(){
    this.PieElement=this.dataOperation.PieshowList;
    this.PieSum=this.dataOperation.grossexp;
  }

  @Builder itemEnd(item:inout) {
    Row () {
      Button("删除",{type:ButtonType.Normal})
        .borderRadius(2)
        .backgroundColor(Color.Red)
        .onClick((event:ClickEvent)=>{
          if(item.typeid===1){
            this.dataOperation.deleteDisb(item.id)
            //插入数据库删除操作
          }
          else {
            this.dataOperation.deleteIncome(item.id)
            //插入数据库删除操作
          }
        })
    }
    .margin({left:"16vp"})
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  startAbilityTest() {
    let context = getContext(this) as common.UIAbilityContext;
    let str=fs.createStreamSync(context.filesDir+'/inout.txt','w');
    str.writeSync('收入：'+this.dataOperation.grossexp+this.dataOperation.remainingSum+'\n')
    str.writeSync('支出：'+this.dataOperation.grossexp)
    str.closeSync()
    let want  = {
      uri:'',//fileuri.getUriFromPath(context.filesDir+'/inout.txt'),
      type: "text/plain",
      action: 'ohos.want.action.sendData',
    }
    context.startAbility(want)
    //hilog.info(0x0000,'testTag',fs.readTextSync(context.filesDir+'/account.txt'))
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
        .onClick((event:ClickEvent)=>{
          this.startAbilityTest()
        })
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
        .onClick((event:ClickEvent)=>{
          router.pushUrl({url:'pages/ReportPage',params:{
            dataOperation:this.dataOperation
            }
          },router.RouterMode.Single)
        })
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
              router.pushUrl({ url: 'pages/RegistrationPage',
                params: {
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
              Text(this.dataOperation.remainingSum.toString())
                .fontSize(24)
                .offset({'x':'0px','y':'2%'})
              PieChart()
                .height('100%')
                .offset({ 'x': '0px', 'y': '10%' })
                .scale({ x: 1.2, y: 1.2 })
                      //概要页面结束
            }
            .width('100%')
            .height('100%')
          }.tabBar({icon:$rawfile('gui/tab_icon1.png'),text:'概要'})

          TabContent() {
            Column() {//收入页面开始
              Stack() {
                Text('  收入汇总：')
                  .fontSize(24)
                  .offset({ 'x': '0px', 'y': '2%' })
                Text((this.dataOperation.remainingSum + this.dataOperation.grossexp).toString())
                  .fontSize(22)
                  .fontColor(Color.Gray)
                  .offset({ 'x': '0px', 'y': '50%' })
                Button({stateEffect:true})
                  .shadow({ radius: 8, color: "00001E", offsetX: 0, offsetY: 0 })
                  .backgroundColor(Color.Orange)
                  .overlay('+',{align:Alignment.Center})
                  .height('100%')
                  .aspectRatio(1)
                  .offset({ "x": '35%', 'y': '10%' })
                  .onClick((event:ClickEvent)=>{

                  })
              }
              .height('9%')
              Divider()
                .offset({'x':'0px','y':'2%'})
              List({ space: 5, initialIndex: 0 }){
                ForEach(this.dataOperation.IncomeList,(item:inout,index:number)=>{
                  ListItem(){
                    Row(){
                      Stack() {
                        Column() {
                          Text(item.category)
                          Image($rawfile('gui/' + CommonConstats.imageList[item.cateid][0]))
                            .height('60%')
                            .aspectRatio(1)
                        }
                        .height('100%')
                        .offset({'x':'-15%'})
                        Text(item.money.toString())
                          .fontSize(30)
                          .fontColor(Color.Red)
                          .offset({'x':'15%'})
                          .padding({bottom:'12%'})
                        Column() {
                          Text(item.remarks)
                          Text(item.time)
                            .offset({ 'y': '25%' })
                        }
                        .offset({'x':'50%'})
                        .height('100%')
                        .width('50%')
                      }
                    }
                    .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
                    .width('96%')
                    .height('10%')
                    .offset({'x':'2%','y':'0%'})
                    .backgroundColor(Color.White)
                    .borderRadius(5)
                  }
                  .swipeAction({end:this.itemEnd(item)})
                })
              }
              .width('100%')
              .height('89%')
              .offset({'x':'0px','y':'2%'})
                      //收入页面结束
            }
            .width('100%')
            .height('100%')
          }
          .tabBar({icon:$rawfile('gui/tab_icon2.png'),text:'收入'})

          TabContent() {
            Column() {//支出页面开始
              Stack() {
                Text('  支出汇总:')
                  .fontSize(24)
                  .offset({ 'x': '0px', 'y': '2%' })
                Text(this.dataOperation.grossexp.toString())
                  .fontSize(22)
                  .fontColor(Color.Gray)
                  .offset({ 'x': '0px', 'y': '50%' })
                Button({stateEffect:true})
                  .shadow({ radius: 8, color: "00001E", offsetX: 0, offsetY: 0 })
                  .backgroundColor(Color.Orange)
                  .overlay('+',{align:Alignment.Center})
                  .height('100%')
                  .aspectRatio(1)
                  .offset({ "x": '35%', 'y': '10%' })
                  .onClick((event:ClickEvent)=>{

                  })
              }
              .height('9%')
              Divider()
                .offset({'x':'0px','y':'2%'})
              List({ space: 5, initialIndex: 0 }){
                ForEach(this.dataOperation.DisbList,(item:inout,index:number)=>{
                  ListItem(){
                    Row(){
                      Stack() {
                        Column() {
                          Text(item.category)
                          Image($rawfile('gui/' + CommonConstats.imageList[item.cateid][0]))
                            .height('60%')
                            .aspectRatio(1)
                        }
                        .height('100%')
                        .offset({'x':'-15%'})
                        //.margin({ le })
                        Text(item.money.toString())
                          .fontSize(30)
                          .fontColor(Color.Red)
                          .offset({'x':'15%'})
                          .padding({bottom:'12%'})
                        Column() {
                          Text(item.remarks)
                          Text(item.time)
                            .offset({ 'y': '25%' })
                        }
                        .offset({'x':'50%'})
                        .height('100%')
                        .width('50%')
                      }
                    }
                    .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
                    .width('96%')
                    .height('10%')
                    .offset({'x':'2%','y':'0%'})
                    .align(Alignment.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(5)
                  }
                  .swipeAction({end:this.itemEnd(item)})
                })
              }
              .width('100%')
              .height('89%')
              .offset({'x':'0px','y':'2%'})
              //支出页面结束
            }
            .width('100%')
            .height('100%')
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