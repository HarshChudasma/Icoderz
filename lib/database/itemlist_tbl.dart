import 'package:icoderz/database/db_helper.dart';
import 'package:icoderz/models/item_list_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemListTable{
  static const String TABLE_NAME_ITEM_LIST = "itemList";
  static const String clm_item_id = "id";
  static const String clm_item_category = "category";
  static const String clm_item_name = "title";
  static const String clm_item_date = "created_date";
  static const String clm_item_reference = "refrence_no";
  static const String clm_item_amount = "amount";
  static const String clm_item_categoryID = "category_id";
  static const String clm_item_type = "type";

  static const CREATE_TABLE_COMPANY_LIST =
  """CREATE TABLE $TABLE_NAME_ITEM_LIST(
      $clm_item_id integer primary key autoincrement,
      $clm_item_name text,
      $clm_item_category text,
      $clm_item_reference integer,
      $clm_item_date text,
      $clm_item_amount real,
      $clm_item_type integer,
      $clm_item_categoryID integer
      )""";

  static Future<int> addNewItem({
    required ItemListModel itemModel,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.insert(
      TABLE_NAME_ITEM_LIST,
      itemModel.toMapForItem(),
    );
  }

  static Future<ItemListModel?> getItemById({
    required int productId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();

    final List<Map<String, dynamic>> listOfMaps = await db!.rawQuery(
        'SELECT * FROM $TABLE_NAME_ITEM_LIST WHERE $clm_item_id = ?',
        [productId]);

    if (listOfMaps.isNotEmpty) {
      return listOfMaps
          .map((e) => ItemListModel.fromJson(e))
          .toList()
          .first;
    }
    return null;
  }

  static Future<List<ItemListModel>> getAllItemsFromDb() async {
    Database? db = await DbHelper.getDataBaseInstance();
    final List<Map<String, dynamic>> listOfMaps =
    await db!.rawQuery('SELECT * FROM $TABLE_NAME_ITEM_LIST');
    if (listOfMaps.isNotEmpty) {
      return listOfMaps.map((e) => ItemListModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<int> deleteItemByProductId({
    required int itemId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    getAllItemsFromDb();
    return db!.delete(TABLE_NAME_ITEM_LIST,
        where: "$clm_item_id = ?", whereArgs: [itemId]);
  }

  static Future<int> updateItemNew({
    required ItemListModel itemModel,
    required int itemid,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.update(TABLE_NAME_ITEM_LIST,
        itemModel.toMapForItem(),
        where: "$clm_item_id = ?", whereArgs: [itemid]);
  }

}