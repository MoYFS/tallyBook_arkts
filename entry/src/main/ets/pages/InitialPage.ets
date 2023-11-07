import router from '@ohos.router'


@Entry
@Component
struct InitialPage {
  @StorageLink('timeoutID') timeoutID:number=0;

  //转场参数
  @State scale1: number = 1;                     // 默认放缩比例
  @State opacity1: number = 1;

  onPageShow() {
    this.timeoutID = setTimeout(() => router.replaceUrl({ url: 'pages/LoginPage' }), 10000);//10s后自动跳转到登陆页面自动跳转
  }

  build() {
    Column(){
      Blank()
        .color('#3CA0D0')
        .width('100%')
        .height('5%')
        .offset({ "x": "0.0px", "y": "0.0px" })
      Image($rawfile('gui/splash_background.jpg'))
        .width('100%')
        .height('100%')
        .offset({ "x": "0.0px", "y": "0.0px" })
        // .overlay('不积硅步，无以至千里；不积细流，无意成江海。',{
        //   align:Alignment.Bottom,
        //   offset:{x:0,y:-175}
        // })
      Text('不积硅步，无以至千里；不积细流，无以成江海。')
        .width('100%')
        .height("100%")
        .fontSize('14fp')
        .offset({'x':'0.0px', "y": "-75%" })
        .textAlign(TextAlign.Center)
      Button('点击进入',{type:ButtonType.Normal,stateEffect:true})
        .borderRadius(10)
        .width('30%')
        .height("5%")
        .fontColor('#000000')
        .backgroundColor('#fff143')
        .offset({"x":"0.00px","y":"-115.00%"})
        .onClick((event:ClickEvent)=>{
          clearInterval(this.timeoutID)
          router.pushUrl({url:'pages/LoginPage'})
        })
    }
    .width('100%')
    .height('100%')
    .scale({
      x: this.scale1,                            // 设置当前页面X轴方向上的放缩比
    })
    .opacity(this.opacity1)
  }
  pageTransition() {                            // 添加全局pageTransition方法
    PageTransitionEnter({                       // 设置当前页面入场动画的配置信息
      duration: 200,                           // 动画执行时间
      curve: Curve.Linear                       // 设置动画曲线
    })
      .slide(SlideEffect.Bottom)
      .onEnter((type: RouteType, progress: number) => {
        this.scale1 = progress
        this.opacity1 = progress
      })

    PageTransitionExit({                        // 设置当前页面退场动画的配置信息
      type:RouteType.Push,
      duration: 200,                           // 设置动画的执行时间
      curve: Curve.Ease                         // 设置动画曲线
    })
      .slide(SlideEffect.Left)
      .onExit((type: RouteType, progress: number)=>{
        this.opacity1=1-progress
      })
  }
}