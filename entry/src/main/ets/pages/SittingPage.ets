@Component
struct GraphicList{
  text:string;
  imagelist:Array<string>
  build(){

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
          .offset({ 'x': '10%px', 'y': '-66%%' })
      }
      .height('12%')

      Column() {

      }
      .height('88%')
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

