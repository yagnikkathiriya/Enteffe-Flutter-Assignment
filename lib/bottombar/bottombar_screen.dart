// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:enteffe_interview_task/cart/screen/cart_screen.dart';
import 'package:enteffe_interview_task/helper/color_helper.dart';
import 'package:enteffe_interview_task/home/screen/home_screen.dart';
import 'package:enteffe_interview_task/managing_app_state/managing_app_state.dart';
import 'package:enteffe_interview_task/order_summary/screen/order_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottombarScreen extends ConsumerWidget {
  const BottombarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider); 

    final _pageOption = [
       HomeScreen(),
      const CartScreen(),
      const OrderSummaryScreen(),
    ];

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: ColorHelper.whiteColor,
            backgroundColor: ColorHelper.cyanColor.withOpacity(0.4),
            elevation: 0,
            selectedLabelStyle: const TextStyle(
                fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
            fixedColor: ColorHelper.blackColor,
            unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
            currentIndex: selectedIndex, // Bind selectedIndex from Riverpod state
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/home.png",
                      color: selectedIndex == 0
                          ? ColorHelper.blackColor
                          : ColorHelper.whiteColor,
                      height: MediaQuery.of(context).size.height / 38),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/cart.png",
                      color: selectedIndex == 1
                          ? ColorHelper.blackColor
                          : ColorHelper.whiteColor,
                      height: MediaQuery.of(context).size.height / 35),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/order-now.png",
                      color: selectedIndex == 2
                          ? ColorHelper.blackColor
                          : ColorHelper.whiteColor,
                      height: MediaQuery.of(context).size.height / 35),
                  label: 'Order'),
            ],
            onTap: (index) {
              ref.read(selectedIndexProvider.notifier).updateIndex(index);
              if(index ==1){

              }
            },
          ),
        ),
        body: _pageOption[selectedIndex],
      ),
    );
  }
}
