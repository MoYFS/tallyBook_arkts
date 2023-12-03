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
