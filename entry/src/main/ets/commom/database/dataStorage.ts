import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common';

export class RdbStoreUtil{
  private rdbStore: relationalStore.RdbStore | null = null;
  private tableName: string;
  private sqlCreateTable: string;
  private columns: Array<string>;

  constructor() {
    this.tableName = 'INOUTLIST';
    this.sqlCreateTable = 'CREATE TABLE IF NOT EXISTS INOUTLIST (ID INTEGER PRIMARY KEY , TYPEID INTEGER,CATEID INTEGER,CATE TEXT,MONEY REAL,REMARKS TEXT,TIME TEXT)';
    this.columns = ["ID","TYPEID","CATEID","CATE","MONEY","REMARKS","TIME"];
  }

  getRdbStore(context:common.BaseContext,callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      return;
    }
    if (this.rdbStore !== null) {
      callback();
      return
    }
    const Store_Config={
      name: "moneyData.db",
      securityLevel: relationalStore.SecurityLevel.S2
    };
    relationalStore.getRdbStore(context, Store_Config, (err, rdb) => {
      if (err) {
        return;
      }
      this.rdbStore = rdb;
      this.rdbStore.executeSql(this.sqlCreateTable);
      callback();
    });
  }

  insertData(data: relationalStore.ValuesBucket, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      return;
    }
    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;
    if (this.rdbStore) {
      this.rdbStore.insert(this.tableName, valueBucket, (err, ret) => {
        if (err) {
          callback(resFlag);
          return;
        }
        callback(ret);
      });
    }
  }

  deleteData(predicates: relationalStore.RdbPredicates, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      return;
    }
    let resFlag: boolean = false;
    if (this.rdbStore) {
      this.rdbStore.delete(predicates, (err, ret) => {
        if (err) {
          callback(resFlag);
          return;
        }
        callback(!resFlag);
      });
    }
  }

  updateData(predicates: relationalStore.RdbPredicates, data: relationalStore.ValuesBucket, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      return;
    }
    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;
    if (this.rdbStore) {
      this.rdbStore.update(valueBucket, predicates, (err, ret) => {
        if (err) {
          callback(resFlag);
          return;
        }
        callback(!resFlag);
      });
    }
  }

  query(predicates: relationalStore.RdbPredicates, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      return;
    }
    if (this.rdbStore) {
      this.rdbStore.query(predicates, this.columns, (err, resultSet) => {
        if (err) {
          return;
        }
        callback(resultSet);
        resultSet.close();
      });
    }
  }
}
