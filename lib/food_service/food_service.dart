import 'dart:convert';
import 'package:enteffe_interview_task/model/food_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodItemService {
  static const String _foodListKey = 'food_list';

  static Future<void> saveFoodItems(FoodItem foodItems) async {
    List<FoodItem> list =await getFoodItems();
    list.add(foodItems);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> localList =
        list.map((e) => e.toJson()).toList();
    List<String> jsonList = localList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_foodListKey, jsonList);
  }

  static Future<List<FoodItem>> getFoodItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_foodListKey);
    if (jsonList != null) {
      return jsonList.map((item) => FoodItem.fromJson(jsonDecode(item))).toList();
    }
    return [];
  }
}


class StorageService {
  static Future<void> saveCart(List<FoodItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedItems = cartItems
        .map((foodItem) => json.encode(foodItem.toJson())) 
        .toList();
    await prefs.setStringList('cart', encodedItems);
  }

  static Future<List<FoodItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedItems = prefs.getStringList('cart');
    if (encodedItems != null) {
      return encodedItems
          .map((item) => FoodItem.fromJson(json.decode(item)))
          .toList();
    }
    return [];
  }
}