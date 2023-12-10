import relationalStore from '@ohos.data.relationalStore';
import {RdbStoreUtil} from '../database/dataStorage';
import inout from '../dataclass/inout'
import common from '@ohos.app.ability.common';
import { CommonConstats}  from '../constant/CommonConstand';

export default class AccountTable {
  private accountTable = new RdbStoreUtil();

  constructor(context,callback: Function = () => {
  }) {
    this.accountTable.getRdbStore(context,callback);
  }

  getRdbStore(context:common.BaseContext,callback: Function = () => {
  }) {
    this.accountTable.getRdbStore(context,callback);
  }

  insertData(account: inout, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    this.accountTable.insertData(valueBucket, callback);
  }

  deleteData(ID:number, callback: Function) {
    let predicates = new relationalStore.RdbPredicates('INOUTLIST');
    predicates.equalTo('ID', ID);
    this.accountTable.deleteData(predicates, callback);
  }

  updateData(account: inout, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    let predicates = new relationalStore.RdbPredicates('INOUTLIST');
    predicates.equalTo('ID', account.id);
    this.accountTable.updateData(predicates, valueBucket, callback);
  }

  query(typeid: number, callback: Function, isAll: boolean = true) {
    let predicates = new relationalStore.RdbPredicates('INOUTLIST');
    if (!isAll) {
      predicates.equalTo('TYPEID', typeid);
    }
    this.accountTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result: inout[] = [];
        for (let i = 0; i < count; i++) {
          result.push(new inout(
            resultSet.getLong(resultSet.getColumnIndex('ID')),
            typeid,
            resultSet.getLong(resultSet.getColumnIndex('CATEID')),
            resultSet.getString(resultSet.getColumnIndex('CATE')),
            resultSet.getDouble(resultSet.getColumnIndex('MONEY')),
            resultSet.getString(resultSet.getColumnIndex('REMARKS')),
            resultSet.getString(resultSet.getColumnIndex('TIME'))
          ))
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(account: inout): relationalStore.ValuesBucket {
  let  valueBucket={
    "ID": account.id,
    "TYPEID":account.typeid,
    "CATEID":account.cateid,
    "CATE":CommonConstats.imageList[account.cateid][1],
    "MONEY":account.money,
    "REMARKS":account.remarks,
    "TIME":account.time
  }
  return valueBucket;
}