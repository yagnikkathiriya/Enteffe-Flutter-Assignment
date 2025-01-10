// ignore_for_file: deprecated_member_use

import 'package:enteffe_interview_task/helper/color_helper.dart';
import 'package:enteffe_interview_task/managing_app_state/managing_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSummaryScreen extends ConsumerWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final totalPrice =
        cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      backgroundColor: ColorHelper.whiteColor,
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final food = cart[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorHelper.cyanColor.withOpacity(0.3),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  margin: EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 55,
                            width: 80,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  food.image,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(food.name),
                              Text('\$${food.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              color: ColorHelper.cyanColor,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              ref.read(cartProvider.notifier).clearCart();
    
              ref.read(selectedIndexProvider.notifier).updateIndex(0);
            },
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }
}
