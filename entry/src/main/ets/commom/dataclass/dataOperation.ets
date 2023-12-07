import inout from './inout';
import {PicChartElement} from '../dataclass/PicChartElement'
import  {BasicDataSource} from '../dataclass/LazyForEachData'
import hilog from '@ohos.hilog';

export default class dataOperation{
  public  IncomeList:Array<inout>;
  public  DisbList:Array<inout>;
  public  PieshowList:Array<PicChartElement>//Array<[number,string,number]>;//种类id,种类名称，金额
  public  remainingSum:number;
  public  grossexp:number;
  private pieColor:Color[]=[Color.Blue,Color.Brown,Color.Gray,Color.Green,Color.Orange,Color.Pink,Color.Red,Color.Yellow,0x009999,0x85004B]

  constructor() {
    this.IncomeList=[];
    this.DisbList=[];
    this.PieshowList=[];
    this.remainingSum=0;
    this.grossexp=0;
  }

  //计算饼状图显示数组
  Statexp(){
    this.PieshowList=[]
    this.grossexp=0
    let a = {}
      // 循环遍历原始数据
    this.DisbList.forEach((item) => {
      if (!a[item.cateid]) {
          //this.PieshowList.push([item.cateid,item.category,item.money])
        this.PieshowList.push(new PicChartElement(item.category,item.money,this.pieColor[item.cateid].toString()))
          // 将 对象塞进 a中
          a[item.cateid] = item
        } else {
          // a中存在 则对b 进行累加
          this.PieshowList.forEach((ss) => {
            if (ss.element === item.category) {
              ss.quantity +=item.money
            }
          })
        }
      this.grossexp+=item.money;
      })
  }
  //删除一项收入
  deleteIncome(ID:number){
    this.IncomeList.forEach((value,index)=>{
      if(value.id===ID){
        this.IncomeList.splice(index,1)
        this.strikingBalance()
      }
    })
  }

  //删除一项支出
  deleteDisb(ID:number){
    this.DisbList.forEach((value,index)=>{
      if(value.id==ID){
        this.DisbList.splice(index,1)
        this.strikingBalance()
        this.Statexp()
      }
    })
  }

  //计算账户余额
   strikingBalance():void{
     let incme:number=0;
     let disb:number=0;
     this.IncomeList.forEach((value)=>{
       incme+=value.money
     })
     this.DisbList.forEach((value)=>{
       disb+=value.money
     })
     this.remainingSum=incme-disb;
  }

}