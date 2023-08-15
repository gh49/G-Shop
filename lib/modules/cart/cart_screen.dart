import 'package:ecommerce_app/modules/cart/cubit.dart';
import 'package:ecommerce_app/modules/cart/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  CartScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CartCubit();
      },
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if(state is CartCheckoutSuccessState) {
            showToast(context, "Items bought Successfully", ToastType.success);
          }
        },
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          cubit.init();

          return ListView(
            key: pageStorageKey,
            padding: EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
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

                      if(state is CartInitialState)...[
                        Center(child: CircularProgressIndicator(color: myOrange,),),
                      ]
                      else...[
                        ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.cart.length,
                        itemBuilder: (context, index) {
                          return BuildCartItem(
                            cID: cubit.cart[index]!["cID"],
                            price: cubit.cart[index]?["price"] ?? 0,
                            image: cubit.cart[index]?["image"] ?? defaultImage,
                            name: cubit.cart[index]?["name"] ?? "",
                            cubit: cubit,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                      ],
                      if(cubit.cart.isEmpty)
                        SizedBox(
                          height: 30.0,
                        ),
                      if(cubit.cart.isEmpty && state is! CartInitialState)
                        Center(
                          child: Text(
                            "No items in Cart",
                            style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 35.0
                            ),
                          ),
                        ),
                      if(state is! CartInitialState && state is! CartGetDataErrorState && cubit.cart.isNotEmpty)
                        Divider(),
                      SizedBox(height: 20.0,),
                      if(state is! CartInitialState && state is! CartGetDataErrorState && cubit.cart.isNotEmpty)
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
                                    text: cubit.getTotal().toStringAsFixed(2),
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
                      SizedBox(height: 30.0,),
                      if(state is! CartInitialState && state is! CartGetDataErrorState && state is! CartCheckoutLoadingState && cubit.cart.isNotEmpty)
                        MyButton(
                        text: "Check Out",
                        onPressed: () {
                          cubit.checkOut();
                        },
                      ),
                      if(state is CartCheckoutLoadingState)
                        Center(
                          child: CircularProgressIndicator(
                            color: myOrange,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget BuildCartItem({
    required String cID,
    String image = defaultImage,
    String name = "",
    double price = 0.0,
    required CartCubit cubit,
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
          Spacer(),
          IconButton(
            color: Colors.red,
            onPressed: () {
              cubit.removeFromCart(cID);
            },
            icon: Icon(Icons.remove_circle),
          ),
        ],
      ),
    );
  }
}
