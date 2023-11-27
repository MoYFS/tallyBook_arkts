export default  class disbursement{
  type:string
  id:number
  category:string//种类
  cateid:number
  money:number//金额
  remarks:string//备注
  time:string

   constructor(id:number,cate:string,cateid:number,money:number,remarks?:string,time?:string) {
     this.type='支出'
     this.id=id
     this.category=cate
     this.cateid=cateid
     this.money=money
     this.remarks=remarks?remarks:''
     let temp=new Date
     this.time=time?time:temp.getFullYear().toString()+'-'+temp.getMonth().toString()+'-'+temp.getDate().toString()+' '+temp.getHours().toString()+':'+temp.getMinutes()+':'+temp.getSeconds().toString()
  }

}