import 'package:dio/dio.dart';
import 'package:fastbag_vendor_flutter/Commons/base_url.dart';
import 'package:fastbag_vendor_flutter/Extentions/store_manager.dart';

class GroceryRepository {
  final dio = Dio();
  Future fetchGroceryCategories() async {
    try {
      String? storeType = await StoreManager().getStoreType();
      print("----------------------->$storeType");

      Response response = await dio.get(
        "${baseUrl}vendors/categories/filter/?store_type_name=Grocery",
      );

      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        // Server returned a response (status code other than 2xx)
        throw e.response?.data ??
            'Failed to fetch categories. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }
  Future fetchGrocerySubCategory() async {
    try {
      String? storeType = await StoreManager().getStoreType();
      print("----------------------->$storeType");

      Response response = await dio.get(
        "${baseUrl}vendors/categories/filter/?store_type_name=$storeType",
      );

      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        // Server returned a response (status code other than 2xx)
        throw e.response?.data ??
            'Failed to fetch categories. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }


  Future fetchGrocerySubCategoryList() async {
    try {
      // String? token = await StoreManager().getAccessToken();
      // // Set headers
      // Options options = Options(
      //   headers: {
      //     "Authorization": "Bearer $token", // Add token to header
      //   },
      // );
      Response response =
          await dio.get("${baseUrl}grocery/gro-Subcategories/list/");
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw e.response?.data ??
            'Failed to fetch Sub categories. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

// Fetch Product List of subCtegory

  fetchProductsbySubcategory(subCategoryId) async {
    try {
      final vendorId = await StoreManager().getVendorId();
      // final vendorId = 18;
      final token = await StoreManager().getAccessToken();
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      Response response = await dio.get(
          '${baseUrl}grocery/products/$vendorId/$subCategoryId/',
          options: options);
      return response.data;
    } on DioException catch (e) {
      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw e.response?.data ?? 'Failed to fetch Products. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  // Add Sub Category
  addSubCategory(data) async {
    try {
      final vendorId = await StoreManager().getVendorId();

      final formData = FormData.fromMap({
        "vendor_id": vendorId,
        ...data,
      });

      // get token
      final token = await StoreManager().getAccessToken();

      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      );
      Response response = await dio.post('${baseUrl}grocery/gro-Subcategories/',
          data: formData, options: options);
      print('Status code ----> ${response.statusCode}');
      print("response ------>${response.data}");

      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);

      if (e.response != null) {
        final responseData = e.response!.data;

        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          for (var value in responseData.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString(); // Show only the first error
            }
          }
        }
      }

      throw "Network error: ${e.message}";
    } catch (e) {
      print(e.toString());
      throw "Unexpected error occurred. Please try again.";
    }
  }

  // Edit Sub Category
  editSubCategory(int subCategoryId, data) async {
    try {
      // final token = await StoreManager().getAccessToken();
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMzE0MDk3LCJpYXQiOjE3NDE3NzgwOTcsImp0aSI6IjZiYjk0ZWVmMDRmYjQzMDk5NTM0OTJkZDY0OWMwNjc0IiwidXNlcl9pZCI6MX0.-czSNSuQNR4U4-awexhFHRGU3UuR25tDsst-NslRs2o';
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final fromData = FormData.fromMap(data);

      Response response = await dio.patch(
          '${baseUrl}grocery/gro-Subcategories/$subCategoryId/',
          data: fromData,
          options: options);

      return response.data;
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode}");

      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw 'Failed to Update. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  // Delete Sub Category
  deleteSubCategory(int subCategoryId) async {
    try {
      // final token = await StoreManager().getAccessToken();
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMzE0MDk3LCJpYXQiOjE3NDE3NzgwOTcsImp0aSI6IjZiYjk0ZWVmMDRmYjQzMDk5NTM0OTJkZDY0OWMwNjc0IiwidXNlcl9pZCI6MX0.-czSNSuQNR4U4-awexhFHRGU3UuR25tDsst-NslRs2o';
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      Response response = await dio.delete(
          '${baseUrl}grocery/gro-Subcategories/$subCategoryId/',
          options: options);

      return response;
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode}");

      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw 'Failed to Delete. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  // Add Product
  addProduct(data) async {
    try {
      final vendorId = await StoreManager().getVendorId();

      final formData = FormData.fromMap({
        "vendor": vendorId,
        ...data,
      });

      // get token
      final token = await StoreManager().getAccessToken();

      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token", // Add token to header
          "Content-Type": "multipart/form-data",
        },
      );
      Response response = await dio.post('${baseUrl}grocery/products/',
          data: formData, options: options);
      print('Status code ----> ${response.statusCode}');
      print("response ------>${response.data}");

      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);

      if (e.response != null) {
        final responseData = e.response!.data;

        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          for (var value in responseData.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString(); // Show only the first error
            }
          }
        }
      }

      throw "Network error: ${e.message}";
    } catch (e) {
      print(e.toString());
      throw "Unexpected error occurred. Please try again.";
    }
  }

  // Edit Product
  editProduct(productId, data) async {
    try {
      // final token = await StoreManager().getAccessToken();
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMzE0MDk3LCJpYXQiOjE3NDE3NzgwOTcsImp0aSI6IjZiYjk0ZWVmMDRmYjQzMDk5NTM0OTJkZDY0OWMwNjc0IiwidXNlcl9pZCI6MX0.-czSNSuQNR4U4-awexhFHRGU3UuR25tDsst-NslRs2o';
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      print('data--------------------->  $data');
      final fromData = FormData.fromMap(data);

      Response response = await dio.patch(
          '${baseUrl}grocery/products/$productId/',
          data: fromData,
          options: options);

      return response.data;
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode}");

      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw 'Failed to Update. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  // Enable Disable Product
  enableDisableProduct(productId, bool isProductEnabled) async {
    try {
      // final token = await StoreManager().getAccessToken();
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMzE0MDk3LCJpYXQiOjE3NDE3NzgwOTcsImp0aSI6IjZiYjk0ZWVmMDRmYjQzMDk5NTM0OTJkZDY0OWMwNjc0IiwidXNlcl9pZCI6MX0.-czSNSuQNR4U4-awexhFHRGU3UuR25tDsst-NslRs2o';
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final fromData = FormData.fromMap({"Available": isProductEnabled});

      Response response = await dio.patch(
          '${baseUrl}grocery/products/$productId/',
          data: fromData,
          options: options);
      return response.data;
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode}");

      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw 'Failed to Update. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }

  // Delete Sub Category
  deleteProduct(int productId) async {
    try {
      final token = await StoreManager().getAccessToken();
      if (token ==
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMzE0MDk3LCJpYXQiOjE3NDE3NzgwOTcsImp0aSI6IjZiYjk0ZWVmMDRmYjQzMDk5NTM0OTJkZDY0OWMwNjc0IiwidXNlcl9pZCI6MX0.-czSNSuQNR4U4-awexhFHRGU3UuR25tDsst-NslRs2o') {
        print('=--------------->Tocken Matches');
      } else {
        print('=--------------->Tocken Nooooooot      Matches');
      }
      // Set headers
      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      Response response = await dio
          .delete('${baseUrl}grocery/products/$productId/', options: options);

      return response;
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode}");

      // Print the full Dio error for debugging
      print("DioError: ${e.response?.data}");

      // Handle different Dio error types
      if (e.response != null) {
        throw 'Failed to Delete. Please try again.';
      }
    } catch (e) {
      print("Error: $e");
      throw 'Unexpected error occurred. Please try again.';
    }
  }
}
