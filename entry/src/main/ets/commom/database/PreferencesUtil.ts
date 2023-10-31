import dataPreferences from '@ohos.data.preferences'

const PREFERENCES_NAME='Account Preferences'
const myaccount='my_account'

export  class PreferenceUtil{
  //创建储存实体
creaftPreferences(context){
  globalThis.getAccountPreferences=(()=>{
    let preferences:Promise<dataPreferences.Preferences>=dataPreferences.getPreferences(context,PREFERENCES_NAME);
    return preferences;
  });
  }

  saveDefaultAccount(account:string,password:string){
    globalThis.getAccountPreferences().then((preferences)=>{
      // preferences.has(account).then(async(isExist)=>{
      //   if (!isExist) {
      //     // 保存数据
      //     await preferences.put(account, password);
      //     preferences.flush();
      //   }
      // })
      preferences.getAll().then((value)=>{
        if(Object.keys(value).length==0){
          preferences.put(myaccount, account);
          preferences.flush();
          preferences.put(account,password);
          preferences.flush();
          preferences.put('Password_prompt',password)
          preferences.flush();
        }
      })
    })
  }


}
export default new PreferenceUtil();

//文件读写
// if(!fs.accessSync(this.context.filesDir+'/account.txt')){
//     let str=fs.createStreamSync(this.context.filesDir+'/account.txt','w');
//       str.writeSync('Dear 11111111')
//       str.closeSync()
//       //hilog.info(0x0000, 'testTag', 'creaft sc'+num);
//     }
// let account:string=fs.readTextSync(this.context.filesDir+'/account.txt').split(' ')[0]
// let password:string=fs.readTextSync(this.context.filesDir+'/account.txt').split(' ')[1]

