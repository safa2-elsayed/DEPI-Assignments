import 'package:flutter/material.dart';
import 'package:assignment7/models/food_model.dart';
import 'package:assignment7/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _updateCart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartMap = CartService().items;
    final subtotal = CartService().getTotalPrice();
    final delivery = subtotal > 0 ? 5.00 : 0.00;
    final taxes = subtotal > 0 ? 2.50 : 0.00;
    final total = subtotal + delivery + taxes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: cartMap.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cartMap.length,
                    itemBuilder: (context, index) {
                      String foodId = cartMap.keys.elementAt(index);
                      int quantity = cartMap.values.elementAt(index);
                      FoodModel food = FoodModel.dummyData.firstWhere(
                        (f) => f.id == foodId,
                      );

                      return _buildCartItem(food, quantity);
                    },
                  ),
                ),
                _buildSummarySection(subtotal, delivery, taxes, total),
              ],
            ),
    );
  }

  Widget _buildCartItem(FoodModel food, int quantity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(food.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  food.restaurant,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "\$${food.price}",
                  style: const TextStyle(
                    color: Color(0xFFD92D2D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _counterButton("-", () {
                CartService().removeFromCart(food.id);
                _updateCart();
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "$quantity",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _counterButton("+", () {
                CartService().addToCart(food.id);
                _updateCart();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _counterButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(text == "+" ? Icons.add : Icons.remove, size: 16),
      ),
    );
  }

  Widget _buildSummarySection(
    double sub,
    double del,
    double tax,
    double total,
  ) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          _summaryRow("Subtotal", sub),
          _summaryRow("Delivery Fee", del),
          _summaryRow("Taxes", tax),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD92D2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            "\$${val.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
