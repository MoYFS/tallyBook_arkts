@Entry
@Component
struct AboutPage {

  @State versions:string='1.0.1'
  @State email:string='233@gmail.com'
  @State telephone:string='88888888'
  @State QQ:string='666666'

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
        .scale({x:1,y:0.9})
        .offset({ 'x': '0.0px', 'y': '-12%' })
      Image($r('app.media.site_logo'))
        .width('35%')
        .border({width:1,color:Color.White,radius:20})
        .shadow({ radius: 4, color: "00001E", offsetX: 4, offsetY: 4 })
        .offset({ 'x': '0.0px', 'y': '-10%' })
      Column() {
        Text('版本：' + this.versions)
          .fontSize(24)
        Text('联系我们：')
          .fontSize(24)
        Text('电话：' + this.telephone)
          .fontSize(24)
        Text('邮箱：' + this.email)
          .fontSize(24)
        Text('QQ：' + this.QQ)
          .fontSize(24)
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('关闭')
            .fontSize(28)
            .fontColor(Color.Black)
            .offset({ 'x': '0.0px', 'y': '0.0px' })
        }
        .width('30%')
        .height('6.4%')
        .borderRadius(6)
        .backgroundColor('#e3f9fd')
        .offset({ 'x': '0.0px', 'y': '2%' })
      }
      .width('100%')
      .offset({ 'x': '0.0px', 'y': '-8%' })
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