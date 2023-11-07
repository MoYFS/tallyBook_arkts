@Entry
@Component
struct AboutPage {
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
        .offset({ 'x': '10%', 'y': '-8%' })
        .zIndex(3)
      Image($rawfile('gui/material_design_3.png'))
        .width('100%')
        .height('25%')
        .offset({ 'x': '0.0px', 'y': '-10%' })
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