import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService   {
  final String auth_token = "auth_token";

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(auth_token);
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(auth_token, token);
  }

  // add category to the list of categories
  Future<void> addCategory(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categories = prefs.getStringList('categories') ?? [];
    categories.add(category);
    prefs.setStringList('categories', categories);
  }

  // remove category from the list of categories
  Future<void> removeCategory(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categories = prefs.getStringList('categories') ?? [];
    categories.remove(category);
    prefs.setStringList('categories', categories);
  }

  // get the list of categories
  Future<List<String>> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categories = prefs.getStringList('categories') ?? [];
    return categories;
  }

  // clear the list of categories
  Future<void> clearCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('categories');
  }

}