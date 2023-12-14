import router from '@ohos.router';

import dataOperation from '../commom/dataclass/dataOperation';

@Entry
@Component
struct ReportPage {

  @State selectRadio:number=0//0为收入，1为支出
  @State dataOperation:dataOperation=new dataOperation()
  @State WhetherPress:boolean=false
  @State startdate:string='2023-01-01'
  @State endDate:string=''

  aboutToAppear(){
    let temp=new Date
    this.endDate=temp.getFullYear().toString()+'-'+(temp.getMonth()+1).toString()+'-'+temp.getDate().toString()
  }

  onPageShow(){
    let temp=new Date
    this.endDate=temp.getFullYear().toString()+'-'+(temp.getMonth()+1).toString()+'-'+temp.getDate().toString()
    this.dataOperation=router.getParams()['dataOperation']
  }

  build() {
    Column(){
      Column() {
        Blank()
          .color('#3CA0D0')
          .width('100%')
          .height('100%')
          .offset({ "x": "0.0px", "y": "0.0px" })
          .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
        Text('记账本')
          .width('100%')
          .height('83%')
          .fontColor(Color.White)
          .fontSize('24fp')
          .offset({ 'x': '10%px', 'y': '-66%' })
      }
      .height('12%')
      Column(){
        Image($rawfile('gui/sum_histogram_icon.png'))
          .height(48)
          .aspectRatio(1)
        Row(){
          Column() {
            Text('起始日：')
              .alignSelf(ItemAlign.Start)
              .offset({'x':'3%','y':'-10%'})
            TextInput({ text: this.startdate })
              .width('30%')
              .borderRadius(0)
              .fontSize(14)
              .alignSelf(ItemAlign.Start)
              .style(TextInputStyle.Inline)
              .textAlign(TextAlign.Start)
              .maxLength(10)
          }
          .offset({'y':'20%'})
          Column() {
            Text('截止日：')
              .alignSelf(ItemAlign.Start)
              .offset({'x':'3%','y':'-10%'})
            TextInput({text:this.endDate})
              .width('30%')
              .fontSize(14)
              .borderRadius(0)
              .style(TextInputStyle.Inline)
              .textAlign(TextAlign.Start)
              .alignSelf(ItemAlign.Start)
              .maxLength(10)
          }
          .offset({'y':'20%'})
          Column(){
            Row() {
              Radio({ value: '收入', group: 'report' })
                .checked(true)
                .height(25)
                .aspectRatio(1)
                .onChange((isChecked:boolean)=>{
                  this.selectRadio=0
                  this.WhetherPress=false
                })
              Text('收入')
            }
            Row() {
              Radio({ value: '支出', group: 'report' })
                .checked(false)
                .height(25)
                .aspectRatio(1)
                .onChange((isChecked:boolean)=>{
                  this.selectRadio=1
                  this.WhetherPress=false
                })
              Text('支出')
            }
          }
          .offset({'x':'0%','y':'18%'})
          Button({type:ButtonType.Normal,stateEffect:true}){
            Image($rawfile('gui/ic_search_grey600_24dp.png'))
              .height('100%')
              .aspectRatio(1)
          }
          .offset({'x':'1%','y':'16%'})
          .backgroundColor('#9F9F9F')
          .height('50%')
          .width('20%')
          .borderRadius(8)
          .onClick((event:ClickEvent)=>{
              this.WhetherPress=true
            })
        }
        .height("100%")
        .width('100%')
        .offset({'x':'0.0px','y':'-40%'})
      }
        .backgroundColor('#3CA0D0')
        .width('100%')
        .height('15%')
        .offset({ "x": "0.0px", "y": "0.0px" })
        .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
      if(this.WhetherPress) {
        if (this.selectRadio == 0) {
          List() {
            ForEach(this.dataOperation.IncomeList, (item, index) => {
              ListItem() {
                Row() {
                  Stack() {
                    Text(item.category)
                      .height('100%')
                      .offset({ 'x': '-10%' })
                    Text(item.money.toString())
                      .fontSize(30)
                      .fontColor(Color.Red)
                      .offset({ 'x': '20%' })
                      .padding({ bottom: '12%' })
                    Text(item.time)
                      .offset({ 'x': '25%', 'y': '30%' })
                  }
                }
                .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
                .width('100%')
                .height('10%')
                .align(Alignment.Center)
                .backgroundColor(Color.White)
                .borderRadius(5)
              }
            })
          }
          .height('73%')
          .width('100%')
        }
        else {
          List() {
            ForEach(this.dataOperation.DisbList, (item, index) => {
              ListItem() {
                Row() {
                  Stack() {
                    Text(item.category)
                      .height('100%')
                      .offset({ 'x': '-10%' })
                    Text(item.money.toString())
                      .fontSize(30)
                      .fontColor(Color.Red)
                      .offset({ 'x': '20%' })
                      .padding({ bottom: '12%' })
                    Text(item.time)
                      .offset({ 'x': '25%', 'y': '30%' })
                  }
                }
                .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
                .width('100%')
                .height('10%')
                .align(Alignment.Center)
                .backgroundColor(Color.White)
                .borderRadius(5)
              }
            })
          }
          .height('73%')
          .width('100%')
        }
      }
    }
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