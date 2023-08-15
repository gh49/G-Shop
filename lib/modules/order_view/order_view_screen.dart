import 'package:ecommerce_app/modules/order_view/cubit.dart';
import 'package:ecommerce_app/modules/order_view/states.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderViewScreen extends StatelessWidget {
  Map<String, dynamic> orderDetails;

  OrderViewScreen({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderViewCubit(),
      child: BlocConsumer<OrderViewCubit, OrderViewStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = OrderViewCubit.get(context);
          cubit.init(orderDetails);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              title: Text(
                "Order",
                style: TextStyle(
                    fontFamily: "QuickSand"
                ),
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: ${orderDetails["orderID"]}",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "Order Date: ${orderDetails["dateTime"].toString().split(' ')[0]}",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "Order Time: ${orderDetails["dateTime"].toString().split(' ')[1]}",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(state is! OrderViewInitialState)
                  Container(
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  // decoration: BoxDecoration(
                  //   color: Colors.grey.shade200,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Product",
                              style: TextStyle(
                                fontFamily: "QuickSand",
                                fontSize: 20.0,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Price",
                              style: TextStyle(
                                fontFamily: "QuickSand",
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(width: 66.0,),
                          ],
                        ),
                        Divider(),
                        if(state is OrderViewInitialState)...[
                          Center(child: CircularProgressIndicator(color: myOrange,),),
                        ]
                        else...[
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.products.length,
                            itemBuilder: (context, index) {
                              return BuildOrderItem(
                                price: cubit.products[index]["price"] ?? 0,
                                image: cubit.products[index]["image"] ?? defaultImage,
                                name: cubit.products[index]["name"] ?? "",
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ],

                        SizedBox(
                          height: 30.0,
                        ),
                        if(state is! OrderViewInitialState && state is! OrderViewGetOrderViewErrorState)
                          Divider(),
                        SizedBox(height: 20.0,),
                        if(state is! OrderViewInitialState && state is! OrderViewGetOrderViewErrorState)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Grand Total: ",
                                        style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 23.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: orderDetails["total"].toStringAsFixed(2),
                                        style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 25.0,
                                          color: myOrange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " JD",
                                        style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if(state is OrderViewInitialState)
                  Center(
                    child: CircularProgressIndicator(
                      color: myOrange,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget BuildOrderItem({
    String image = defaultImage,
    String name = "",
    double price = 0.0,
  }) {
    String priceString = price.toStringAsFixed(2);
    return IntrinsicHeight(
      child: Row(
        children: [
          Image(
            image: NetworkImage(image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.scaleDown,
          ),
          Container(
            width: 130.0,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: "QuickSand",
              ),
            ),
          ),
          VerticalDivider(),
          Text(
            priceString,
            style: TextStyle(
              fontFamily: "QuickSand",
            ),
          ),
        ],
      ),
    );
  }
}
