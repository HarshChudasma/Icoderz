import 'package:icoderz/models/category_model.dart';

abstract class CategoryListRepository {

  Future<List<CategorylistModel>?> caegoryListApiCall({required int isCredit});

}