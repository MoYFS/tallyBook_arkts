import router from '@ohos.router';
import  inout from '../commom/dataclass/inout';
import { PieChart} from '../view/PieChart';
import {PicChartElement} from  '../commom/dataclass/PicChartElement';
import dataOperation from '../commom/dataclass/dataOperation';
import { CommonConstats}  from '../commom/constant/CommonConstand';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import AccountTable from '../commom/database/AccountTable';

@Entry
@Component
struct MainPage {

  @State grayScale:number=0;
  @State showSide:boolean=true;
  @State showButton:boolean=false;
  @State scale1:number=1;
  //@State account:string='Dear';
  @State account:string=router.getParams()['account'];
  private controller: TabsController = new TabsController()
  @State @Watch('change') dataOperation:dataOperation=new dataOperation()
  @StorageLink('PieElement') PieElement:PicChartElement[]=[]
  @StorageLink('PieSum') PieSum:number=0;

  @State remarksValue:string=''
  @State moneyValue:number=100
  @State typeID:number=0
  @State cateid:number=0
  @State ID:number=6

  context = getContext(this) as common.BaseContext;
  private AccountTable = new AccountTable(this.context,() => {});

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      remarksValue:$remarksValue,
      moneyValue:$moneyValue,
      typeid: $typeID,
      cateid: $cateid,
      cancel: this.onCancel,
      confirm: this.onAccept.bind(this)

    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Default,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  aboutToAppear(){
    globalThis.getAccountPreferences().then((preferences)=>{
      preferences.get('moneyID','error').then((value)=>{
        this.ID=value
      })
    })
    //插入从数据库中加载数据到this.dataOperation的函数
    this.AccountTable.getRdbStore(this.context,async () => {
      this.AccountTable.query(0,(result: inout[]) => {
        this.dataOperation.IncomeList=result
        this.dataOperation.strikingBalance()
        this.dataOperation.Statexp()
      }, false);
      this.AccountTable.query(1, (result: inout[]) => {
        this.dataOperation.DisbList=result
        this.dataOperation.strikingBalance()
        this.dataOperation.Statexp()
      }, false);
    });
  }

  aboutToDisappear() {
    delete this.dialogController,
    this.dialogController = undefined
  }

  onPageShow(){
    router.clear()
    this.showButton=false;
  }

  onCancel() {
    this.cateid=0
    this.remarksValue=''
    this.moneyValue=100
    this.typeID=0
  }

  onAccept() {
    if(this.typeID==0){
      this.dataOperation.IncomeList.push(new inout(this.ID,this.typeID,this.cateid,CommonConstats.imageList[this.cateid][1],this.moneyValue,this.remarksValue))
      this.AccountTable.insertData(this.dataOperation.IncomeList[this.dataOperation.IncomeList.length-1],()=>{})
    }
    else{
      this.dataOperation.DisbList.push(new inout(this.ID,this.typeID,this.cateid,CommonConstats.imageList[this.cateid][1],this.moneyValue,this.remarksValue))
      this.dataOperation.Statexp()
      this.AccountTable.insertData(this.dataOperation.DisbList[this.dataOperation.DisbList.length-1],()=>{})
    }
      //数据插入
    this.ID+=1
    globalThis.getAccountPreferences().then((preferences)=>{
      preferences.put('moneyID',this.ID)
      preferences.flush();
    })
    this.cateid=0
    this.remarksValue=''
    this.moneyValue=100
    this.typeID=0
    this.dataOperation.strikingBalance()
  }
  existApp() {
    this.cateid=0
    this.remarksValue=''
    this.moneyValue=100
    this.typeID=0
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
          }
          else {
            this.dataOperation.deleteIncome(item.id)
          }
          this.AccountTable.deleteData(item.id,()=>{})
            //数据删除函数
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
                    if (this.dialogController != undefined) {
                      this.cateid=0
                      this.typeID=0
                      this.dialogController.open()
                    }
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
                    if (this.dialogController != undefined) {
                      this.cateid=2
                      this.typeID=1
                      this.dialogController.open()
                    }
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
                },(item: inout) => JSON.stringify(item))
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

@CustomDialog
struct CustomDialogExample {
  @Link remarksValue: string
  @Link moneyValue:number
  @Link typeid:number
  @Link  cateid:number
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text('类别:'+CommonConstats.imageList[this.cateid][1])
        .fontSize(20)
        .margin({ top: 10, bottom: 10})
        .fontColor(Color.Gray)
      List({ space: 5, initialIndex: 0 }){
        if(this.typeid==0){
          ForEach(CommonConstats.incomeList,(item,index)=>{
            ListItem(){
              Button({type:ButtonType.Normal,stateEffect:true}){
                Image($rawfile('gui/' + CommonConstats.imageList[item][0]))
                  .objectFit(ImageFit.None)
                  .overlay(CommonConstats.imageList[item][1], { align: Alignment.Bottom })
                  .backgroundImageSize(ImageSize.Auto)
                  .alignSelf(ItemAlign.Start)
                  .align(Alignment.Start)
              }
              .onClick((event:ClickEvent)=>{
                this.cateid=item
              })
              .backgroundColor(Color.Transparent)
              .height(75)
              .width(75)
            }
          })
        }
        else{
          ForEach(CommonConstats.disbursementList,(item,index)=>{
            ListItem(){
              Button({type:ButtonType.Normal,stateEffect:true}){
                Image($rawfile('gui/' + CommonConstats.imageList[item][0]))
                  .objectFit(ImageFit.None)
                  .overlay(CommonConstats.imageList[item][1], { align: Alignment.Bottom })
                  .backgroundImageSize(ImageSize.Auto)
                  .alignSelf(ItemAlign.Start)
                  .align(Alignment.Start)
              }
              .onClick((event:ClickEvent)=>{
                this.cateid=item
              })
              .backgroundColor(Color.Transparent)
              .height(75)
              .width(75)
            }
          })
        }
      }
      .listDirection(Axis.Vertical)
      .lanes({minLength:75,maxLength:225})
      .height(150)//.width('70%')
      TextInput({ placeholder: '', text: this.remarksValue })
        .height(40)
        .width('90%')
        .margin({top:30,bottom:10})
        .overlay('备注',{offset:{x:10,y:-20}})
        .onChange((value: string) => {
          this.remarksValue = value
        })
      TextInput({ placeholder: '', text: this.moneyValue.toString() })
        .height(40)
        .width('90%')
        .margin({top:30,bottom:10})
        .overlay('金额',{offset:{x:10,y:-20}})
        .onChange((value: string) => {
          this.moneyValue = Number(value)
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('放弃')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            this.controller.close()
            this.confirm()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}