import 'package:ecommerce_app/modules/edit_profile/cubit.dart';
import 'package:ecommerce_app/modules/edit_profile/states.dart';
import 'package:ecommerce_app/modules/order_view/order_view_screen.dart';
import 'package:ecommerce_app/modules/previous_orders/cubit.dart';
import 'package:ecommerce_app/modules/previous_orders/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(),
      child: BlocConsumer<OrdersCubit, OrdersStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = OrdersCubit.get(context);
          cubit.init();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              title: Text(
                "Previous Orders",
                style: TextStyle(
                    fontFamily: "QuickSand"
                ),
              ),
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: cubit.ordersIDList.length,
              separatorBuilder: (context, index) {
                return Divider(height: 0.0,);
              },
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: () {
                    navigateTo(context, OrderViewScreen(orderDetails: cubit.orders[index]));
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Order #${cubit.ordersIDList[index]}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "QuickSand",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
