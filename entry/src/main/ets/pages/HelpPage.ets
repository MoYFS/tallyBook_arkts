@Entry
@Component
struct HelpPage {
  build() {
    Column() {
      Blank()
        .color('#3CA0D0')
        .width('100%')
        .height('12%')
        .offset({ "x": "0.0px", "y": "0.0px" })
        .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
        .zIndex(2)
      Text('记账本')
        .width('100%')
        .height('10%')
        .fontColor(Color.White)
        .fontSize('24fp')
        .offset({ 'x': '10%px', 'y': '-8%' })
        .zIndex(3)
      Image($rawfile('gui/tips.png'))
        .width('100%')
        .offset({ "x": "0.0px", "y": "-10%" })
      Text('帮助信息')
        .width('100%')
        .height('6%')
        .fontSize(40)
        .fontColor(Color.Blue)
        .align(Alignment.Center)
        .offset({"x":"0.00px","y":"-10.00%"})
        .alignSelf(ItemAlign.Center)
        .textAlign(TextAlign.Center)
      Row(){
        Text('第一章:')
          .fontSize(30)
        Text('快速入门')
          .decoration({type:TextDecorationType.Underline,color:Color.Blue})
          .fontSize(30)
          .offset({"x":"5%","y":"0.0px"})
          .fontColor(Color.Blue)
        Text('>')
          .fontSize(30)
          .offset({"x":"5%","y":"0.0px"})
          .fontColor(Color.Blue)
      }
      .width('100%')
      .offset({"x":"0.00px","y":"-10.00%"})
      .align(Alignment.Start)
      Row(){
        Text('第二章:')
          .fontSize(30)
        Text('使用指南')
          .decoration({type:TextDecorationType.Underline,color:Color.Blue})
          .fontSize(30)
          .offset({"x":"5%","y":"0.0px"})
          .fontColor(Color.Blue)
        Text('>')
          .fontSize(30)
          .offset({"x":"5%","y":"0.0px"})
          .fontColor(Color.Blue)
      }
      .width('100%')
      .offset({"x":"0.00px","y":"-10.00%"})
      .align(Alignment.Start)
      Row(){
        Text('第三章:')
          .fontSize(30)
        Text('参考资料')
          .decoration({type:TextDecorationType.Underline,color:Color.Blue})
          .fontSize(30)
          .fontColor(Color.Blue)
          .offset({"x":"5%","y":"0.0px"})
        Text('>')
          .fontSize(30)
          .offset({"x":"5%","y":"0.0px"})
          .fontColor(Color.Blue)
      }
      .width('100%')
      .offset({"x":"0.00px","y":"-10.00%"})
      .align(Alignment.Start)
    }
    .width('100%')
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