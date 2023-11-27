import inout from './inout';
//import disbursement  from '../dataclass/disbursement'
export default class dataOperation{
   public  IncomeList:Array<inout>;
   public  DisbList:Array<inout>;
   public  remainingSum:number;
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