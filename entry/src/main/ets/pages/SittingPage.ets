@Component
struct GraphicList{
  private  text?:string;
  private  imageList?:Array<[string, string]>;
  temp:number=0;
  @Builder tempAdd(){

  }

  build() {
    Column() {
      Blank()
        .color('#3CA0D0')
        .width('100%')
        .height('12%')
        .offset({ "x": "0.0px", "y": "0.0px" })
        .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
      if (this.text != undefined){
        Text(this.text+':')
          .offset({"x":'0.0px','y':'-10%'})
      }
      Row() {
        if (this.imageList != undefined) {
          ForEach(this.imageList, (item: [string, string]) => {
            Image($rawfile('gui/' + item[0]))
              .objectFit(ImageFit.None)
              .overlay(item[1], { align: Alignment.Bottom})
              .width('33%')
              .backgroundImageSize(ImageSize.Auto)
              .alignSelf(ItemAlign.Start)
              .align(Alignment.Start)
          })
        }
      }
      .offset({"x":'0.0px','y':'-6%'})
      .height('88%')
      .width('100%')
      .align(Alignment.TopStart)
      .alignItems(VerticalAlign.Top)
    }
    .align(Alignment.TopStart)
    .width('90%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct SittingPage {

  build() {
    Column() {
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

      Column() {
        GraphicList({text:'收入类别',imageList:[['fund_icon.png','工资'],['insurance_icon.png','奖金']]})
          .height('50%')
        GraphicList({text:'支出类别',imageList:[['fund_icon.png','工资'],['insurance_icon.png','奖金']]})
          .height('50%')
      }
      .offset({ 'x': '0.0px', 'y': '1%' })
      .height('80%')
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

