class FoodModel {
  final String id;
  final String name;
  final String restaurant;
  final String image;
  final double price;
  final double rating;
  final int reviews;
  final int timeMin;
  final int kcal;
  final String description;
  final List<String> ingredients;

  FoodModel({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.timeMin,
    required this.kcal,
    required this.description,
    required this.ingredients,
  });

  static List<FoodModel> get dummyData => [
    FoodModel(
      id: '1',
      name: 'Cheese Cake',
      restaurant: 'Cake Palace',
      image: 'assets/images/CheeseCake.jpg',
      price: 12.50,
      rating: 4.8,
      reviews: 128,
      timeMin: 20,
      kcal: 350,
      description: 'Cheese Cake with Strawbarry.',
      ingredients: ['Cream Cheese', 'Lemon Juice', 'Vanilla', 'Eggs', 'Sugar'],
    ),
    FoodModel(
      id: '2',
      name: 'Cheese Cake',
      restaurant: 'Cake Palace',
      image: 'assets/images/cheescake.jpg',
      price: 15.00,
      rating: 4.5,
      reviews: 200,
      timeMin: 30,
      kcal: 600,
      description: 'Cheese Cake with berry.',
      ingredients: ['berry', 'sugar', 'salt', 'Vanilla'],
    ),
    FoodModel(
      id: '3',
      name: 'Oreo Cake',
      restaurant: 'Cake Palace',
      image: 'assets/images/birthdayCake.jpg',
      price: 10.00,
      rating: 4.2,
      reviews: 80,
      timeMin: 15,
      kcal: 450,
      description: 'Birthday Cake with oreo.',
      ingredients: ['Oreo', 'sugar', 'Chocolate', 'Vanilla'],
    ),
    FoodModel(
      id: '4',
      name: 'Cup Cake',
      restaurant: 'Cake Palace',
      image: 'assets/images/cupCake.jpg',
      price: 10.00,
      rating: 4.2,
      reviews: 80,
      timeMin: 15,
      kcal: 450,
      description: 'Cup Cake with Chocolate.',
      ingredients: ['Eggs', 'sugar', 'Chocolate', 'Vanilla'],
    ),
    FoodModel(
      id: '5',
      name: 'Pancake',
      restaurant: 'Cake Palace',
      image: 'assets/images/Pancake.jpg',
      price: 10.00,
      rating: 4.2,
      reviews: 80,
      timeMin: 15,
      kcal: 450,
      description: 'Banana Pancake.',
      ingredients: ['Eggs', 'sugar', 'Banana', 'Vanilla'],
    ),
  ];
}
