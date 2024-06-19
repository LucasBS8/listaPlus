import 'dart:convert';
import 'package:listaplus/model/objetos/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {

  static const String _categoryKey = 'category';
  
  Future<void> setCategoria(List<Category> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_categoryKey, encodedData);
  }

  Future<List<Category>> getCategoria() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_categoryKey);
    if (tasksString != null) {
      final List<dynamic> decodedData = json.decode(tasksString);
      return decodedData.map((json) => Category.fromJson(json)).toList();
    }
    return [];
  }
  
}
// Save/Create

//   static Future<void> saveProduct(Product product) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String encodedData =
//         json.encode(product.toJson());
//     await prefs.setString('product', encodedData);
//   }

// static Future<void> saveCategory(List<Category> categories) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String categoryString =
//         json.encode(categories.map((category) => category.toJson()).toList());
//     await prefs.setString('category', categoryString);
//   }

//   // Method to add a single category
//   static Future<void> addCategory(Category category) async {
//     List<Category> categories = await getCategory();
//     categories.add(category);
//     await saveCategory(categories);
//   }

// // Read
// static Future<List<Category>> getCategory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? categoryString = prefs.getString('category');
//     if (categoryString != null) {
//       final dynamic decodedData = json.decode(categoryString);
//       if (decodedData is List<dynamic>) {
//         return decodedData.map((json) => Category.fromJson(json)).toList();
//       } else {
//         throw Exception(
//             'Expected a value of type List<dynamic>, but got one of type ${decodedData.runtimeType}');
//       }
//     }
//     return [];
//   }




//   static Future<List> getProduct() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? productString = prefs.getString('product');
//     if (productString != null) {
//       final List<dynamic> decodedData = json.decode(productString);
//       print(decodedData.toList());
//       return decodedData.toList();
//     }
//     return [];
//   }

// // delete

//   static Future<void> deleteProduct() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('product');
//   }

//   static Future<void> deleteCategory() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('category');
//   }
// }
