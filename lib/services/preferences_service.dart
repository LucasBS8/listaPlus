import 'dart:convert';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Save/Create

Future<void> saveProduct(List<Product> product) async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String encodedData =
      json.encode(product.map((product) => product.toJson()).toList());
  await prefs.setString('product', encodedData);
}


Future<void> saveCategory(List<Category> category) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String encodedData =
      json.encode(category.map((category) => category.toJson()).toList());
  await prefs.setString('category', encodedData);
}

// Read

Future<List<Category>> getCategory() async {
  final prefs = await SharedPreferences.getInstance();
  final String? categoryString = prefs.getString('category');
  if (categoryString != null) {
    final List<dynamic> decodedData = json.decode(categoryString);
    return decodedData.map((json) => Category.fromJson(json)).toList();
  }
  return [];
}

Future<List<Product>> getProduct() async {
  final prefs = await SharedPreferences.getInstance();
  final String? productString = prefs.getString('product');
  if (productString != null) {
    final List<dynamic> decodedData = json.decode(productString);
    return decodedData.map((json) => Product.fromJson(json)).toList();
  }
  return [];
}


// delete

Future<void> deleteProduct() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('product');
}

Future<void> deleteCategory() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('category');
}