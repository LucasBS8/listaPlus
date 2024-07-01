import 'dart:convert';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _categoryKey = 'categorys';
  static const String _productKey = 'products';
  static const String _categoryIdKey = 'categoryId';
  static const String _productIdKey = 'productId';

  Future<void> setCategoria(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(categories.map((category) => category.toJson()).toList());
    await prefs.setString(_categoryKey, encodedData);
  }

  Future<List<Category>> getCategoria() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoryString = prefs.getString(_categoryKey);
    if (categoryString != null) {
      List<dynamic> decodedData = json.decode(categoryString);
      return decodedData.map((json) => Category.fromJson(json)).toList();
    }
    return [];
  }

  Future<int> getNextCategoryId() async {
    final prefs = await SharedPreferences.getInstance();
    final int currentId = prefs.getInt(_categoryIdKey) ?? 0;
    final int nextId = currentId + 1;
    await prefs.setInt(_categoryIdKey, nextId);
    return nextId;
  }

  Future<void> deleteCategoria(int categoryId) async {
    final List<Category> categories = await getCategoria();
    categories.removeWhere((category) => category.id == categoryId);
    await setCategoria(categories);

    final List<Product> products = await getProduto();
    products.removeWhere((product) => product.idCategoria == categoryId);
    await setProduto(products);
  }

  Future<void> setProduto(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString(_productKey, encodedData);
  }

  Future<List<Product>> getProduto() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productString = prefs.getString(_productKey);
    if (productString != null) {
      List<dynamic> decodedData = json.decode(productString);
      return decodedData.map((json) => Product.fromJson(json)).toList();
    }
    return [];
  }

  Future<int> getNextProductId() async {
    final prefs = await SharedPreferences.getInstance();
    final int currentId = prefs.getInt(_productIdKey) ?? 0;
    final int nextId = currentId + 1;
    await prefs.setInt(_productIdKey, nextId);
    return nextId;
  }

  Future<void> deleteProduto(int id) async {
    final List<Product> products = await getProduto();
    products.removeWhere((product) => product.id == id);
    await setProduto(products);
  }
}
