import router from "@ohos.router"
import hilog from '@ohos.hilog'
import promptAction from '@ohos.promptAction'


@Entry
@Component
struct LoginPage {
  @State password:string='';
  @State account:string='';
  @State passwordText:string='';
  @State accountText:string=''
  @State passwordPrompt:string=''

  //转场参数
  @State scale1: number = 1
  @State opacity1: number = 1

 onPageShow(){
   globalThis.getAccountPreferences().then((preferences)=>{
      preferences.get('my_account','error').then((value)=>{
        this.accountText=value;
        this.account=value;
        preferences.get(this.accountText,'error').then((value)=>{
          this.password=value;
        })
        preferences.get('Password_prompt','error').then((value)=>{
          this.passwordPrompt=value;
        })
    })
    })
  }

  build() {
      Column() {
        Column() {
          Blank()
            .color('#3CA0D0')
            .width('100%')
            .height('12%')
            .offset({ "x": "0.0px", "y": "0.0px" })
            .shadow({ radius: 4, color: "00001E", offsetX: 0, offsetY: 0 })
            .zIndex(2)
          Text('登录')
            .width('100%')
            .height('10%')
            .fontColor(Color.White)
            .fontSize('24fp')
            .offset({ 'x': '10%px', 'y': '-8%' })
            .zIndex(3)
          Blank()
            .color('#3CA0D0')
            .width('100%')
            .height('16%')
            .offset({ "x": "0.0px", "y": "-10%" })
            .zIndex(1)
          Image($rawfile('gui/default_user_logo.png'))
            .width('35.00%')
            .height('16.00%')
            .offset({ "x": "0.0px", "y": "-26%" })
            .zIndex(2)
            .backgroundImageSize({ "width": "20.00px", "height": "20.00%" })
            .backgroundImagePosition(Alignment.Center)
          TextInput({ placeholder: '请输入昵称', text: this.accountText })
            .width('80%')
            .offset({ 'x': '0.0px', 'y': '-20%' })
            .overlay('用户昵称：', { offset: { x: 5, y: -25 } })
            .onChange((value: string) => {
              //this.account = value;
              this.accountText = value
            })
          TextInput({ placeholder: '请输入密码', text: this.passwordText })
            .width('80%')
            .showPasswordIcon(true)
            .type(InputType.Password)
            .offset({ 'x': '0.0px', 'y': '-15%' })
            .overlay('密码：', { offset: { x: 5, y: -25 } })
            .onChange((value: string) => {
              this.passwordText = value
            })
          Button('登录', { type: ButtonType.Normal, stateEffect: true })
            .width("80%")
            .borderRadius(10)
            .fontColor('#000000')
            .backgroundColor('#fff143')
            .offset({ 'x': '0.0px', 'y': '-13%' })
            .onClick((event: ClickEvent) => {
              if (this.accountText == '') {
                promptAction.showToast({ message: '用户不能为空.', duration: 2000, bottom: '100' })
              }
              else if (this.passwordText == '') {
                promptAction.showToast({ message: '密码不能为空.', duration: 2000, bottom: '100' })
              }
              else {
                globalThis.getAccountPreferences().then((preferences)=>{
                  preferences.has(this.accountText).then((isExist) => {
                    if(!isExist) {
                      promptAction.showToast({ message: '无该用户.', duration: 2000, bottom: '100' })
                    }
                    else{
                      if (this.passwordText ==this.password) {
                        router.pushUrl({ url: 'pages/MainPage' ,params: {
                          pageClear:'Clear',
                          account:this.accountText
                        }});
                      }
                      else{
                        this.passwordText = ''
                        promptAction.showToast({ message: '密码错误.', duration: 2000, bottom: '100' })
                      }
                    }
                  })
                })
              }
            })
        }
        //Colum属性设置
        .width("100%")
        .justifyContent(FlexAlign.Center)

        //忘记密码 and 注册用户 Row
        Row() {
          //忘记密码Button
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('忘记密码')
              .fontColor(Color.Black)
              .decoration({ type: TextDecorationType.Underline, color: Color.Black })
          }
          .width('20%')
          .height('4%')
          .backgroundColor(Color.Transparent)
          .offset({ 'x': '-10%', 'y': '-10%' })
          .onClick((event: ClickEvent) => {
            promptAction.showDialog({
              title:'提示',
              message:"您设置的密码提示为\n"+this.passwordPrompt,
              buttons:[
                {
                  text : '确认',
                  color:'#000000',
                }
              ]
            },(err,data)=>{
              if(data.index==1) {
                hilog.info(0x0000,'testTag','按了按键'+data.index)
              }
            })
          })
          //注册用户Button
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('注册用户')
              .fontColor(Color.Black)
              .decoration({ type: TextDecorationType.Underline, color: Color.Black })
          }
          .width('20%')
          .height('4%')
          .backgroundColor(Color.Transparent)
          .offset({ 'x': '10%', 'y': '-10%' })
          .onClick((event:ClickEvent)=>{
            router.pushUrl({
              url:'pages/RegistrationPage',
              params:{
                account:this.account
              }
            })
          })
        }
        //Row属性设置
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .scale({
        x: this.scale1
      })
      .opacity(this.opacity1)
    }

  //转场动画
  pageTransition() {
    PageTransitionEnter({
      duration: globalThis.transitionTime,
      curve: Curve.Linear,
      type:RouteType.Push
    })
      .onEnter((type: RouteType, progress: number) => {
        this.scale1 = 1
        this.opacity1 = progress
      })

    PageTransitionEnter({
      duration: globalThis.transitionTime,
      curve: Curve.Linear,
      type:RouteType.Pop
    })
      .slide(SlideEffect.Left)

    PageTransitionExit({
      duration: globalThis.transitionTime,
      curve: Curve.Ease,
      type:RouteType.None
    })
      .slide(SlideEffect.Bottom)
      .onExit((type: RouteType, progress: number) => {
        this.scale1 = 1 - progress
        this.opacity1 = 1-progress
      })
    PageTransitionExit({
      duration:globalThis.transitionTime,
      type:RouteType.Push,
      curve: Curve.Linear,
    })
      .slide(SlideEffect.Left)
  }
}