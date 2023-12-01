import hilog from '@ohos.hilog';

//@Entry
@Component
export struct PieChart {
  // 饼图数据
  @State picChartElements: PicChartElement[]=[
    new PicChartElement('蛋白质', 14.9, '#ff9421'),
    new PicChartElement('脂肪', 39.8, '#ffd100'),
    new PicChartElement('碳水', 19.1, '#4cd041'),
    new PicChartElement('甜点', 9.1, '#4cd0ee'),
    new PicChartElement('海鲜', 11.1, '#999999')
    ]
  // 圆半径
  @State circle_radius:number = 80*1.5
  @State sum:number=0;
  // 单位
  @State unit: string = "%"
  // 获取上下文
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    let total = 0
    // 统计总数量
    this.picChartElements.forEach((value) => {
      total += value.quantity
    })

    // 初始化 弧线的终止弧度
    let lastEndAngle = -0.5 * Math.PI
    // 封装饼图数据
    this.picChartElements.forEach((value) => {
      // 占用百分比
      let percent = value.quantity / total
      // 四舍五入，获取整数
      value.percent = Math.round(percent * 100)
      // 初始化终止弧度为 弧线的起始弧度
      value.beginAngle = lastEndAngle
      // 计算弧线的终止弧度
      value.endAngle = (percent * 2 * Math.PI) + lastEndAngle
      // 赋值终止弧度为变量，作为下次的起始弧度
      lastEndAngle = value.endAngle
      // 初始化元素块半径
      value.circle_radius=this.circle_radius
      // 返回封装好的对象
      return value
    })
  }

  draw(){
    this.context.translate(160, 160)
    this.picChartElements.forEach((item) => {
      // 创建一个新的控制路径
      this.context.beginPath()
      // 路径从当前点移动到指定点
      this.context.moveTo(0, 0)
      // 绘制弧线路径(弧线圆心的x坐标值,弧线圆心的y坐标值,弧线的圆半径,弧线的起始弧度,弧线的终止弧度)
      this.context.arc(0, 0, item.circle_radius, item.beginAngle, item.endAngle)
      // 指定绘制的填充色
      this.context.fillStyle = item.color
      // 对封闭路径进行填充
      this.context.fill()
      this.context.closePath()

      this.context.save()
      this.context.beginPath()
      // 路径从当前点移动到指定点
      this.context.moveTo(0, 0)
      // 绘制弧线路径(弧线圆心的x坐标值,弧线圆心的y坐标值,弧线的圆半径,弧线的起始弧度,弧线的终止弧度)
      this.context.arc(0, 0, this.circle_radius*0.6, item.beginAngle, item.endAngle)
      // 指定绘制的填充色
      this.context.fillStyle = Color.White.toString()
      // 对封闭路径进行填充
      this.context.fill()
      this.context.closePath()
      this.context.restore()

      this.context.save()
      this.context.beginPath()
      // 路径从当前点移动到指定点
      this.context.moveTo(0, 0)
      // 绘制弧线路径(弧线圆心的x坐标值,弧线圆心的y坐标值,弧线的圆半径,弧线的起始弧度,弧线的终止弧度)
      this.context.arc(0, 0, this.circle_radius*0.6, item.beginAngle, item.endAngle)
      // 指定绘制的填充色
      this.context.fillStyle = item.color
      this.context.globalAlpha=0.4
      // 对封闭路径进行填充
      this.context.fill()
      this.context.closePath()
      this.context.restore()

      this.context.save()
      this.context.beginPath()
      // 路径从当前点移动到指定点
      this.context.moveTo(0, 0)
      // 绘制弧线路径(弧线圆心的x坐标值,弧线圆心的y坐标值,弧线的圆半径,弧线的起始弧度,弧线的终止弧度)
      this.context.arc(0, 0, this.circle_radius*0.5, item.beginAngle, item.endAngle)
      // 指定绘制的填充色
      this.context.fillStyle = Color.White.toString()
      // 对封闭路径进行填充
      this.context.fill()
      this.context.closePath()
      this.context.restore()

      this.context.save()
      this.context.fillStyle = Color.Black.toString()
      this.context.font = '40px'
      this.context.rotate((item.endAngle+item.beginAngle)/2)
      this.context.fillText(item.element.toString()+item.percent+this.unit,this.circle_radius*0.62,0)
      this.context.restore()
    })
    this.context.moveTo(0,0)
    this.context.font = '60px'
    this.context.fillText('￥'+this.sum,-this.context.measureText('￥'+this.sum).width/2,this.context.measureText('￥'+this.sum).height/4)
  }

  getTouch(x:number,y:number){
    if(Math.sqrt(x**2+y**2)>this.circle_radius || Math.sqrt(x**2+y**2)<this.circle_radius*0.5){
      this.picChartElements.forEach((value)=>{
        value.circle_radius=this.circle_radius
      })
    }
    else{
      this.picChartElements.forEach((value)=>{
        if(x<0) {
          if (Math.atan(y / x)+Math.PI>= value.beginAngle && Math.atan(y / x)+Math.PI <= value.endAngle) {
            value.circle_radius = 140
          }
          else {
            value.circle_radius = 120
          }
        }
        else {
          if (Math.atan(y / x)>= value.beginAngle && Math.atan(y / x) <= value.endAngle) {
            value.circle_radius = 140
          }
          else {
            value.circle_radius = 120
          }
        }
      })
    }
  }

  build() {
    Row() {
      Canvas(this.context)
        // 高度为半径2倍
        .height(80*4)
          // 纵横比，宽度和高度一样
        .aspectRatio(1)
          // 画布组件的事件回调，可以在此时进行绘制
        .onReady(() => {
          this.draw()
        })
        .onClick((event:ClickEvent)=>{
          //this.picChartElements[0].circle_radius=140
          this.getTouch(event.x-160,event.y-160)
          this.context.translate(-160, -160)
          this.context.clearRect(0,0,80*4,80*4)
          this.draw()
        })
    }
    .width(80*4)
    .height(80*4)
  }

}

export class PicChartElement {
  element: Resource | string  // 显示文本
  quantity: number            // 数量
  percent: number             // 百分比
  beginAngle: number          // 弧线的起始弧度
  endAngle: number            // 弧线的终止弧度
  color: string               // 颜色
  circle_radius:number        // 元素块半径


  constructor(element: Resource | string, quantity: number, color: string) {
    this.element = element
    this.quantity = quantity
    this.color = color
  }
}
