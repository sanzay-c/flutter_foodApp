import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:intl/intl.dart';

class Resturant extends ChangeNotifier {
  final List<Food> _menu = [
    Food(
      name: "Class Cheeseburger",
      description:
          "A juicy and patty with melted chedder, lettuce, tomato and a hint of onion and pickle",
      imagePath: "lib/images/burgers/burger02.jpg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
      ],
    ),

    // salads
    Food(
      name: "vegetables salads",
      description: "A healthy salads with more and extra veges",
      imagePath: "lib/images/salads/salad01.jpg",
      price: 0.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra salads", price: 0.99),
      ],
    ),

    // sides
    Food(
      name: "A very good desserts",
      description: "a nice and good desserts",
      imagePath: "lib/images/desserts/desserts01.jpg",
      price: 2.00,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra chocose", price: 3.99),
      ],
    ),
    // desserts
    Food(
      name: "A very good desserts",
      description: "a nice and good desserts",
      imagePath: "lib/images/desserts/desserts02.jpg",
      price: 3.53,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra chocose", price: 3.99),
        Addon(name: "Extra toppings", price: 4.55),
      ],
    ),
    // drinks
    Food(
      name: "Drinks",
      description: "A chilled and cold drinks",
      imagePath: "lib/images/drinks/drinks02.jpg",
      price: 1.11,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra ices", price: 2.00),
      ],
    ),
  ];

  //getters
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  /* -- O P E R A T I O N S --*/
  //usercart
  final List<CartItem> _cart = [];

  //delivery address (which user can change/update)
  String deliveryAddress = '99 Hollywood Blv';


  //add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons;
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if the food items are the same
      bool isSameFood = item.food == food;

      //check if the selected items are the same
      bool isSameAddons = ListEquality().equals(
        item.selectedAddons,
        selectedAddons,
      );
      return isSameFood && isSameAddons;
    });
    // if item already exits, increase it's qunatity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      //add a new cart item to the cart
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  //get total price of cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  //get total numbers of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //update delivery address
  void updateDeliveryAddress(String newAddress){
    deliveryAddress = newAddress;
    notifyListeners();
  }

  /* -- H E L P E R S -- */
  //generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("------------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if(cartItem.selectedAddons.isNotEmpty){
        receipt.writeln("Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("--------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  //format double value into money
  String _formatPrice(double price) {
    return "\$ ${price.toStringAsFixed(2)}";
  }

  //format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(",");
  }
}
