import relationalStore from '@ohos.data.relationalStore'
import hilog from '@ohos.hilog';

export class RdbStoreUtil{
  creaftRdbStoreUtil(context){
    const Store_Config={
      name: "moneyData.db",
      securityLevel: relationalStore.SecurityLevel.S2
    };
    hilog.info(0x0000,'testTag','成功')
    globalThis.getRdbStoreUtil=(()=>{
      let RdbStore:Promise<relationalStore.RdbStore>=relationalStore.getRdbStore(context,Store_Config);
      return RdbStore;
    })
  }
  saveDefaultRdbStoreUtil(SQL_CREATE_TABLE:string){
    globalThis.getRdbStoreUtil().then(async(store)=>{
      store.executeSql(SQL_CREATE_TABLE);
      hilog.info(0x0000,"testTag",'创建表')
    })
  }
}
export default new RdbStoreUtil();