export class disbursement{
  type:string
  category:string//种类
  money:number//金额
  remarks:string//备注
  time:string

   constructor(cate:string,money:number,remarks?:string) {
    this.type='支出'
    this.category=cate
    this.money=money
    this.remarks=remarks?remarks:''
     let temp=new Date
     this.time=temp.getFullYear().toString()+'-'+temp.getMonth().toString()+'-'+temp.getDate().toString()+' '+temp.getHours().toString()+':'+temp.getMinutes()+':'+temp.getSeconds().toString()
  }
}