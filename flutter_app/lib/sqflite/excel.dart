import 'package:flutter_app/constant.dart';
import 'package:flutter_app/sqflite/column.dart';
import 'package:sqflite/sqflite.dart';

class Excel {
  static const DbName = "demo.db";
  static const DbVersion = 1;
  Database database;
  Column columnTools = new Column();

  Future<Database> getDb() async {
    if (database == null) {
      String path = await getDatabasesPath().then((m) => m + "/" + DbName);
      database = await openDatabase(path, version: DbVersion);
    }
    return database;
  }

  static test() async {
    //另外注意这点，用了 await 才能保证这块能顺序执行，用then，或者直接不加await都会继续直接执行后续的逻辑，这里涉及到数据库操作会有时序问题
    await new Excel()._createTable("Test", ["x", "sd"]);
    await new Excel()._createTable("我们", ["x", "sd"]);
    await new Excel()._createTable("卧们", ["x", "sd"]);
    await new Excel()._createTable("卧们", ["xxx"]);
  }

  insertData(
      String tableEnName, List<String> columnNames, List<List<String>> data,
      {bool needToEN = false}) async {
    Database database = await getDb();
    if (needToEN) {
      for (int i = 0; i < columnNames.length; i++) {
        columnNames[i] = await new Column().getEnColumn(columnNames[i]);
      }
      tableEnName = await new Column().getEnColumn(tableEnName);
    }
    await _createTable(tableEnName, columnNames);

    List<String> valueList = new List();
    for (List<String> tmp in data) {
      String line = CommonUtils.listToString(tmp, coverL: "'", coverR: "'");
      line = line.hashCode.toString() + "," + line;
      valueList.add(line);
    }
    String value =
        CommonUtils.listToString(valueList, coverL: "(", coverR: ")");
    String clm = CommonUtils.listToString(columnNames);
    String dbstring = 'INSERT INTO $tableEnName ( HASH ,  $clm ) VALUES $value';
    CommonUtils.log2(["insertData dbstring::", dbstring]);

    int ans = await database.rawInsert(dbstring);
    CommonUtils.log2(["insertData ans", ans.toString()]);

    ///根据hash值来去重
    String delete = "delete from $tableEnName where HASH  in" +
        " (select  HASH  from $tableEnName   group  by  HASH   having  count(HASH) > 1)  " +
        "and rowid not in (select min(rowid) from  $tableEnName   group by HASH  having count(HASH)>1)";
    await database.execute(delete);
  }

  ///根据名称与列名来创建表格，
  ///1判断是否已存在名称相同的表， yes 检查是否已包含全部的列，如果有新增就添加.   NO  直接添加新表
  _createTable(String enTableName, List<String> enColumn) async {
    CommonUtils.log2(["createTable  ----", enTableName, enColumn]);
    Database database = await getDb();
    bool hadTable = await database
        .rawQuery("select name from sqlite_master where name='$enTableName'")
        .then((m) {
      CommonUtils.log2(["select name from sqlite_master where name  ----", m]);
      return m != null && m.length > 0;
    });
    CommonUtils.log2(["hadTable", enTableName, hadTable]);

    if (!hadTable) {
      String columns = CommonUtils.listToString(enColumn, coverR: " TEXT");
      await database
          .execute('CREATE TABLE  $enTableName ( HASH INTEGER, create_time TIMESTAMP NOT NULL DEFAULT current_timestamp,$columns ) ');
      return;
    }
    List<String> addColumn = await _checkIsSameTable(enTableName, enColumn);
    CommonUtils.log2(["addColumn", enTableName, addColumn]);

    if (addColumn == null) {
      return;
    }
    for (String tmp in addColumn) {
      await database.execute("alter table $enTableName add  $tmp TEXT");
    }
  }

  /// 获得表需要新加入的字段名称
  Future<List<String>> _checkIsSameTable(
      String theEnTableName, List<String> columnName) async {
    List<String> theColumns = await new Column()
        .getEnColumn(theEnTableName)
        .then((m) => getColumn(m));
    CommonUtils.log2(["theColumns  ", theColumns]);

    if (theColumns == null) {
      return columnName;
    }
    List<String> rt = new List();
    for (String tmp in columnName) {
      if (theColumns.contains(tmp)) {
        continue;
      }
      rt.add(tmp);
    }
    return rt;
  }

  ///获取表名中的字段名称
  Future<List<String>> getColumn(String tableName) async => getDb()
          .then((m) => m.rawQuery('PRAGMA table_info($tableName) '))
          .then((m) {
        if (m == null) return null;
        List<String> column = new List();
        for (Map<String, dynamic> a in m) {
          column.add(a["name"]);
        }
        return column;
      }).catchError((error) => null);

  close() => database?.close();
}
