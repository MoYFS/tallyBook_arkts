@CustomDialog
struct InputPopup {
  @Link textValue: string
  @Link inputValue: string
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Stack() {
      Column() {
        Text('输入类别')
          .fontSize(20)
          .margin({ top: 20, bottom: 10 })
        TextInput({ placeholder: '', text: this.textValue })
          .height(50)
          .width('90%')
          .borderRadius(4)
          .margin({ top: 20, bottom: 10 })
          .onChange((value: string) => {
            this.textValue = value
          })
        Flex({ justifyContent: FlexAlign.SpaceAround }) {
          Button('放弃')
            .margin({ top: 20, bottom: 5 })
            .onClick(() => {
              this.controller.close()
              //this.cancel()
            })
            .backgroundColor(0xffffff)
            .fontColor(Color.Red)
          Button('确认')
            .margin({ top: 20, bottom: 5 })
            .onClick(() => {
              this.inputValue = this.textValue
              this.controller.close()
              //this.confirm()
            })
            .backgroundColor(0xffffff)
            .fontColor(Color.Red)
        }.margin({ bottom: 10 })
      }
    }
    .height('25%')
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(20)
  }
}

@Component
export default struct GraphicList{
  private  text?:string;
  private  imageList?:Array<[string, string,number]>;

  @State textValue: string = ''
  @State inputValue: string = ''
  dialogController: CustomDialogController = new CustomDialogController({
    builder: InputPopup({
      textValue: $textValue,
      inputValue:$inputValue
    }),
    autoCancel: false,
    alignment: DialogAlignment.Default,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: true
  })

  aboutToDisappear() {
    delete this.dialogController,
    this.dialogController = undefined
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
      Button({stateEffect:true})
        .backgroundColor(Color.Orange)
        .overlay('+',{align:Alignment.Center})
        .height('12%')
        .width('12%')
        .offset({ "x": '88%', 'y': '-18%' })
        .onClick((event:ClickEvent)=>{
          if (this.dialogController != undefined) {
            this.dialogController.open()
          }
        })
      Row() {
        if (this.imageList != undefined) {
          ForEach(this.imageList, (item: [string, string],index:number) => {
            if(index<3 ) {
              Button({type:ButtonType.Normal,stateEffect:true}){
                Image($rawfile('gui/' + item[0]))
                  .objectFit(ImageFit.None)
                  .overlay(item[1], { align: Alignment.Bottom })
                  .backgroundImageSize(ImageSize.Auto)
                  .alignSelf(ItemAlign.Start)
                  .align(Alignment.Start)
              }
              .width('33.3%')
              .height('25%')
              .backgroundColor(Color.Transparent)
            }
            else{
              Button({type:ButtonType.Normal,stateEffect:true}){
                Image($rawfile('gui/' + item[0]))
                  .objectFit(ImageFit.None)
                  .overlay(item[1], { align: Alignment.Bottom })
                  .backgroundImageSize(ImageSize.Auto)
                  .alignSelf(ItemAlign.Start)
                  .align(Alignment.Start)
              }
              .width('33.3%')
              .height('25%')
              .offset({'x':'-99.9%','y':'25%'})
              .backgroundColor(Color.Transparent)
            }
          })
        }
      }
      .offset({"x":'0.0px','y':'-18%'})
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