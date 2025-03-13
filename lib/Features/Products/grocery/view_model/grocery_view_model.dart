import 'package:fastbag_vendor_flutter/Features/Products/Model/category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/Model/sub_category_model.dart';
import 'package:fastbag_vendor_flutter/Features/Products/grocery/repository/grocery_category_repository.dart';
import 'package:flutter/material.dart';

class GroceryViewModel extends ChangeNotifier {
  final GroceryRepository _groceryRepository = GroceryRepository();

  List<CategoryModel> _categories = [
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__'),
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__'),
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__'),
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__'),
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__'),
    // CategoryModel(
    //     id: 1,
    //     name: 'Food',
    //     category_image:
    //     'https://s3-alpha-sig.figma.com/img/2588/330c/6bf21a221ccfaeea11019539e5aec251?Expires=1742169600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pbiLyII~WOCA-2r5IngmuE~J3ZBKYd8LWTlqZ~QXTgo4CJXC4ZdQ8HmR8HdBC4gwVc3pMS78HRWooENmO084JWO4YiUpcNrY~ckLmgeWQEXpu3HgiYQk4JtpHNlbpKSo84RWfc5-EX49RumNXDQ0WT0JkVWcPjikm63QV2LA0jH4YThKiYqqIN8mP5FNXiqlSnIJFbvowNnAmioFRSqqRFtpESopBCplghk6iLZEnB-K8QOSJ07XN-XxZ2-K~BAFeX4LLN7315em-6eG8DfGWP5e4sy1VRf9jjq4C5hIRKgqAmiNhT69jQE2t9~gQV15aQCfmSbwvp6p-BjDqY0TZw__')
  ];
  List<CategoryModel> get categories => _categories;

  List<SubCategoryModel> _subCategories = [
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1),
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1),
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1),
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1),
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1),
    // SubCategoryModel(
    //     id: 1,
    //     categoryId: 1,
    //     is_enabled: true,
    //     name: "Biriyani",
    //     sub_category_image:
    //     "https://farm5.staticflickr.com/4206/34630446624_ec6133ed16_o_d.jpg",
    //     vendor: 1)
  ];
  List<SubCategoryModel> get subCategories => _subCategories;

  Future<List<CategoryModel>> getGroceryCategory(
      {required BuildContext context}) async {
    var res = await _groceryRepository.groceryCategories(context);
    if (res != null) {
      _categories = res
          .map<CategoryModel>((data) => CategoryModel.fromMap(data))
          .toList();
      print(_categories);
      notifyListeners();
    }
    return _categories;
  }

  Future<List<SubCategoryModel>> getGrocerySubCategory(
      {required BuildContext context}) async {
    var res = await _groceryRepository.grocerySubCategory(context);
    if (res != null) {
      _subCategories = res
          .map<SubCategoryModel>((data) => SubCategoryModel.fromMap(data))
          .toList();
      print(_subCategories);
      notifyListeners();
    }
    print("returning subcategories $_subCategories");
    return _subCategories;
  }

  Future<void> addGrocerySubCategory(
      {required BuildContext context,
        required SubCategoryModel subCategories}) async {
    await _groceryRepository.addGrocerySubCategory(context, subCategories);
  }

  Future<void> editGrocerySubCategory(
      {required BuildContext context,
        required SubCategoryModel subCategories}) async {
    await _groceryRepository.editGrocerySubCategory(context, subCategories);
  }
}
