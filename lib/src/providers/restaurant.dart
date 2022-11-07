import 'package:flutter/cupertino.dart';
import 'package:foodorderingappfinal/src/helpers/restaurant.dart';
import 'package:foodorderingappfinal/src/model/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  static List<RestaurantModel> restaurants = [];
  RestaurantModel? restaurant;
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantProvider.initialize() {
    _loadCategories();
  }

  _loadCategories() async {
    restaurants = await _restaurantServices.getCategories();
    notifyListeners();
  }

  loadSingleRestaurant({String? restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(restaurantId);
    notifyListeners();
  }

  Future search({String? name}) async {
    searchedRestaurants =
        await _restaurantServices.searchRestaurant(restaurantName: name);
    print("RESTOS ARE: ${searchedRestaurants.length}");
    notifyListeners();
  }
}
