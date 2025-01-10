import 'package:enteffe_interview_task/food_service/food_service.dart';
import 'package:enteffe_interview_task/model/food_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodListProvider = Provider<List<FoodItem>>(
  (ref) {
    return [
      FoodItem(
        id: '1',
        name: 'Pizza',
        image:
            'https://t3.ftcdn.net/jpg/00/27/57/96/360_F_27579652_tM7V4fZBBw8RLmZo0Bi8WhtO2EosTRFD.jpg',
        price: 9.99,
      ),
      FoodItem(
        id: '2',
        name: 'Burger',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF0hozi1S8LaAzHga583oA64FaZbWRCj7x3w&s',
        price: 5.49,
      ),
      FoodItem(
        id: '3',
        name: 'Pasta',
        image:
            'https://images.immediate.co.uk/production/volatile/sites/30/2021/04/Pasta-alla-vodka-f1d2e1c.jpg',
        price: 7.99,
      ),
      FoodItem(
        id: '4',
        name: 'Sandwich',
        image:
            'https://wiproappliances.com/cdn/shop/articles/Veg_grilled_cheese_sandwich.jpg?v=1714126819',
        price: 6.99,
      ),
      FoodItem(
        id: '5',
        name: 'Pav bhaji',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYX9ESFzZjzvo3Io4G0mJPlKY6CPOBe8TZxA&s',
        price: 10.23,
      ),
      FoodItem(
        id: '6',
        name: 'Dosa',
        image:
            'https://vanitascorner.com/wp-content/uploads/2018/10/Ulli-Karam-Dosa.jpg',
        price: 12.42,
      ),
      FoodItem(
        id: '7',
        name: 'Biryani',
        image:
            'https://www.madhuseverydayindian.com/wp-content/uploads/2022/11/easy-vegetable-biryani.jpg',
        price: 6.0,
      ),
      FoodItem(
        id: '8',
        name: 'Aloo paratha',
        image:
            'https://images.mrcook.app/recipe-image/01919dff-457b-7593-beaa-b2d6d04b1a04',
        price: 4.0,
      ),
      FoodItem(
        id: '9',
        name: 'Idli sambar',
        image:
            'https://media.istockphoto.com/id/1306083224/photo/idly-or-idli.jpg?s=612x612&w=0&k=20&c=cVpLEs4L3je0_zEFQ38BeZRjBLYQ1YGr9oTIdjhAbTY=',
        price: 7.31,
      ),
      FoodItem(
        id: '10',
        name: 'Full Dish',
        image:
            'https://static.toiimg.com/photo/msid-82059086,width-96,height-65.cms',
        price: 15.42,
      ),
    ];
  },
);

final cartProvider = StateNotifierProvider<CartNotifier, List<FoodItem>>(
  (ref) {
    return CartNotifier();
  },
);

class CartNotifier extends StateNotifier<List<FoodItem>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final cartItems = await StorageService.loadCart();
    state = cartItems;
  }

  Future<void> addToCart(FoodItem foodItem) async {
    final index = state.indexWhere((item) => item.id == foodItem.id);
    if (index != -1) {
      state = [
        for (final item in state)
          if (item.id == foodItem.id)
            item.copyWith(quantity: item.quantity + 1)
          else
            item,
      ];
    } else {
      state = [...state, foodItem.copyWith(quantity: 1)];
    }
    await StorageService.saveCart(state); 
  }

  Future<void> removeFromCart(String foodId) async {
    final index = state.indexWhere((item) => item.id == foodId);
    if (index != -1) {
      final foodItem = state[index];
      if (foodItem.quantity > 1) {
        state = [
          for (final item in state)
            if (item.id == foodId)
              item.copyWith(quantity: item.quantity - 1)
            else
              item,
        ];
      } else {
        state = state.where((item) => item.id != foodId).toList();
      }
      await StorageService.saveCart(state); 
    }
  }

  Future<void> clearCart() async {
    state = [];
    await StorageService.saveCart(state);
  }
}


class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void updateIndex(int index) {
    state = index; 
  }
}

final selectedIndexProvider = StateNotifierProvider<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier();
});

final foodItemsProvider = FutureProvider<List<FoodItem>>((ref) async {
  return await FoodItemService.getFoodItems();
});


