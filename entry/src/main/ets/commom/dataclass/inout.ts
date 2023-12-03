export default  class inout{
  typeid:number//支出收入ID
  type:string//支出或收入
  id:number//id
  category:string//种类
  cateid:number//种类id
  money:number//金额
  remarks:string//备注
  time:string

  constructor(id:number,typeid:number=0|1,cateid:number,cate:string,money:number,remarks?:string,time?:string) {
    if(typeid===0){
      this.type='支出'
    }
    else{
      this.type='收入'
    }
    this.typeid=typeid
    this.id=id
    this.category=cate
    this.cateid=cateid
    this.money=money
    this.remarks=remarks?remarks:''
    let temp=new Date
    this.time=time?time:temp.getFullYear().toString()+'-'+temp.getMonth().toString()+'-'+temp.getDate().toString()+' '+temp.getHours().toString()+':'+temp.getMinutes()+':'+temp.getSeconds().toString()
  }
}