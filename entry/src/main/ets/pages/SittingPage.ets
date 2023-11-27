import CommonConstand from '../commom/constant/CommonConstand'
import GraphicList from '../view/GraphicList'
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
        GraphicList({text:'收入类别',imageList:CommonConstand.incomeList.map((value)=>{return CommonConstand.imageList[value]})})
          .height('50%')
        GraphicList({text:'支出类别',imageList:CommonConstand.disbursementList.map((value)=>{return CommonConstand.imageList[value]})})
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

