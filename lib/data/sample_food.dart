import 'package:mark_x/models/food_item.dart';

List<FoodItem> demoFoods = [
  FoodItem(name: "Pizza", calories: 285, protein: 12, quantity: 36),
  FoodItem(name: "Burger", calories: 354, protein: 0, quantity: 29),
  FoodItem(name: "Pasta", calories: 200, protein: 7, quantity: 42),
  FoodItem(name: "Salad", calories: 150, protein: 3,quantity: 18),
  FoodItem(name: "Sushi", calories: 200, protein: 1,quantity: 27),
  FoodItem(name: "Tacos", calories: 250, protein: 1,quantity: 30),
  FoodItem(name: "Steak", calories: 500, protein: 50,quantity: 0),
  FoodItem(name: "Pancakes", calories: 350, protein: 5, quantity: 50),
  FoodItem(name: "Ice Cream", calories: 210, protein: 4, quantity: 28),
  FoodItem(name: "Smoothie", calories: 180, protein: 5, quantity: 40),
];

// Print demo foods with nutritional information
void priintdata() {
  print("Demo Foods with Nutritional Information:");
  for (var food in demoFoods) {
    print(
      "${food.name}: ${food.calories} kcal, ${food.protein}g protein, ${food.quantity}g quantity",
    );
  }
}
