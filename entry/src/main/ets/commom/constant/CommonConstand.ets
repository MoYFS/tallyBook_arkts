export enum cateIdDefine{'gongzi'=0,'jiangji','tushu','dianying','fangzu','yundong','yiliao','jianzhi'}
export class CommonConstats {
  static readonly  imageList : [string ,string,number][]=[
    ['fund_icon.png','工资',0],
    ['insurance_icon.png','奖金',1],
    ['book_icon.png','图书',2],
    ['film_icon.png','电影',3],
    ['housing_loan_icon.png','房租',4],
    ['sport_icon.png','运动',5],
    ['medical_icon.png','医疗',6],
    ['baby_icon.png','兼职收入',7],];
 // static readonly  imageList : Array<[string ,string]>
  static readonly incomeList:Array<number>=[0,1,7];
  static readonly disbursementList:Array<number>=[0,1,2,3,4,5];
}