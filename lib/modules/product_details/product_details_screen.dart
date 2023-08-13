import 'package:ecommerce_app/modules/product_details/cubit.dart';
import 'package:ecommerce_app/modules/product_details/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  String pID;
  ProductDetailsScreen({super.key, required this.pID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProductDetailsCubit();
      },
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (BuildContext context, state) {

        },
        builder: (BuildContext context, state) {
          var cubit = ProductDetailsCubit.get(context);
          cubit.init(pID);
          print("state: ${state.toString()}");
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              actions: [

              ],
            ),
            body: ListView(
              padding: EdgeInsets.all(10.0),
              physics: BouncingScrollPhysics(),
              children: [
                if(state is ProductDetailsInitialState)
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.0,
                        ),
                        CircularProgressIndicator(
                          color: myOrange,
                        ),
                      ],
                    ),
                  ),
                if(state is! ProductDetailsInitialState && state is! ProductDetailsGetDataErrorState)
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        "${cubit.product?.name}",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Text(
                            "${cubit.product?.rating}",
                            style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          RatingBar.builder(
                            initialRating: cubit.product?.rating??0.0,
                            ignoreGestures: true,
                            minRating: 0,
                            maxRating: 5,
                            itemSize: 25.0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                            },
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            "(${cubit.product?.ratingCount})",
                            style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Image(
                        fit: BoxFit.scaleDown,
                        height: 300.0,
                        image: NetworkImage(cubit.product?.image ?? "https://wallpapers.com/images/featured/blank-white-7sn5o1woonmklx1h.jpg"),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "In stock: ${cubit.product?.quantity ?? 0}",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: "PRICE ",
                                style: TextStyle(
                                  fontFamily: "QuickSand",
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: cubit.product?.price?.toStringAsFixed(2) ?? "0.0",
                                style: TextStyle(
                                  fontFamily: "QuickSand",
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
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
                      SizedBox(height: 15.0,),
                      MyButton(
                        text: "Add to Cart",
                        onPressed: () {
                          cubit.addToCart(context, pID);
                        },
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                        cubit.product?.description ?? "",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
