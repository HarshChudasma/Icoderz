import 'package:icoderz/database/db_helper.dart';
import 'package:icoderz/models/usermodel.dart';
import 'package:sqflite/sqflite.dart';

class UserTable{
  static const String TABLE_NAME_USER_TALBE = "userList";
  static const String clm_user_id = "id";
  static const String clm_user_img = "imageUrl";
  static const String clm_user_name = "username";
  static const String clm_user_email = "email";

  static const CREATE_TABLE_COMPANY_LIST =
  """CREATE TABLE $TABLE_NAME_USER_TALBE(
      $clm_user_id text,
      $clm_user_img text,
      $clm_user_name text,
      $clm_user_email text
      )""";

  static Future<int> addNewUser({
    required UserModel userModel,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.insert(
      TABLE_NAME_USER_TALBE,
      userModel.toMapForUser(),
    );
  }

  static Future<UserModel?> getUserById({
    required String userId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    final List<Map<String, dynamic>> listOfMaps = await db!.rawQuery(
        'SELECT * FROM $TABLE_NAME_USER_TALBE WHERE $clm_user_id = ?',
        [userId]);
    if (listOfMaps.isNotEmpty) {
      return listOfMaps
          .map((e) => UserModel.fromJson(e))
          .toList()
          .first;
    }
    return null;
  }


}