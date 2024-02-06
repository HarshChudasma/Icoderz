import 'dart:io';
import 'package:icoderz/database/itemlist_tbl.dart';
import 'package:icoderz/database/user_tbl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static Database? db = null;
  static const String DB_NAME = "icoderz.db";
  static const int DB_VERSION = 1;

  static Future<Database?> getDataBaseInstance() async{
    if(db != null && db!.isOpen){
      db ??= await init();
    } else {
      db = await init();
    }
    return db;
  }

  static Future<Database?> init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentDirectory.path, DB_NAME);
    db = await openDatabase(
      dbPath,
      version: DB_VERSION,
      onCreate: (Database newDb, int version) {
        newDb.execute(ItemListTable.CREATE_TABLE_COMPANY_LIST);
        newDb.execute(UserTable.CREATE_TABLE_COMPANY_LIST);
      },
    );
    return db;
  }

  static Future<void> deleteDatabase() async {
    Database? db = await getDataBaseInstance();
    await db!.close();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentDirectory.path, DB_NAME);
    await File(dbPath).delete();
    db = null;
  }

}