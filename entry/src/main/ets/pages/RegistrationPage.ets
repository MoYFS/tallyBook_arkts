import router from "@ohos.router"
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct RegistrationPage {

  @State account:string='';
  //@State account:string='Dear'
  @State accountText:string='Dear';
  @State firstPassword:string='';
  @State secondPassword:string='';
  @State passwordPrompt:string='';

  //转场参数
  @State scale1: number = 1
  @State opacity1: number = 1
onPageShow(){
  this.account=router.getParams()['account']
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
        Text('记账本')
          .width('100%')
          .height('10%')
          .fontColor(Color.White)
          .fontSize('24fp')
          .offset({ 'x': '10%px', 'y': '-8%' })
          .zIndex(3)
        Image($rawfile('gui/user_reg.png'))
          .width('45%')
          .height('20%')
          .offset({ "x": "0.0px", "y": "-10%" })
        TextInput({ placeholder: '请输入昵称', text: this.accountText })
          .width('80%')
          .offset({ 'x': '0.0px', 'y': '-5%' })
          .overlay('用户昵称：', { offset: { x: 5, y: -25 } })
          .onChange((value: string) => {
            this.accountText = value
          })
        TextInput({ placeholder: '请输入密码', text: this.firstPassword })
          .width('80%')
          .showPasswordIcon(true)
          .type(InputType.Password)
          .offset({ 'x': '0.0px', 'y': '0.0px' })
          .overlay('密码：', { offset: { x: 5, y: -25 } })
          .onChange((value: string) => {
            this.firstPassword = value
          })
        TextInput({ placeholder: '请再输入密码', text: this.secondPassword })
          .width('80%')
          .showPasswordIcon(true)
          .type(InputType.Password)
          .offset({ 'x': '0.0px', 'y': '5%' })
          .overlay('确认密码：', { offset: { x: 5, y: -25 } })
          .onChange((value: string) => {
            this.secondPassword = value
          })
        TextInput({ placeholder: '密码提示', text: this.passwordPrompt })
          .width('80%')
          .offset({ 'x': '0.0px', 'y': '10%' })
          .overlay('密码提示：', { offset: { x: 5, y: -25 } })
          .onChange((value: string) => {
            this.passwordPrompt = value
          })
        Button('注册',{type:ButtonType.Normal,stateEffect:true})
          .borderRadius(10)
          .width('60%')
          .height("5%")
          .fontColor('#000000')
          .backgroundColor('#fff143')
          .offset({"x":"0.0px","y":"15%"})
          .onClick((event:ClickEvent)=>{
            if (this.accountText == '') {
              promptAction.showToast({ message: '用户不能为空.', duration: 2000, bottom: '100' })
            }
            else if (this.firstPassword == '' || this.secondPassword == '') {
              promptAction.showToast({ message: '密码不能为空.', duration: 2000, bottom: '100' })
            }
            else if (this.passwordPrompt == '') {
              promptAction.showToast({ message: '密码提示不能为空.', duration: 2000, bottom: '100' })
            }
            else if (this.firstPassword === this.secondPassword) {
                globalThis.getAccountPreferences().then((preferences) => {
                  preferences.put('my_account', this.accountText)
                  preferences.delete(this.account)
                  preferences.put(this.accountText, this.firstPassword)
                  preferences.put('Password_prompt', this.passwordPrompt)
                  preferences.flush();
                })
                router.back()
              }
              else {
                promptAction.showToast({ message: '两次密码不相等.', duration: 2000, bottom: '100' })
              }
          })
      }
      //Colum属性设置
      .width("100%")
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
      duration:globalThis.transitionTime,
      type:RouteType.Push,
      curve: Curve.Linear,
    })
      .slide(SlideEffect.Right)

    PageTransitionExit({
      duration: globalThis.transitionTime,
      curve: Curve.Linear,
      type:RouteType.Pop
    })
      .slide(SlideEffect.Right)
  }
}