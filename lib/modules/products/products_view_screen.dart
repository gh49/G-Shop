import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/products/cubit.dart';
import 'package:ecommerce_app/modules/products/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductsViewScreen extends StatelessWidget {
  CategoryType categoryType;

  ProductsViewScreen({
    super.key,
    required this.categoryType
  });

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String categoryTitle = getCategoryTitle(categoryType);
    return BlocProvider(
      create: (context) {
        return ProductsViewCubit();
      },
      child: BlocConsumer<ProductsViewCubit, ProductsViewStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ProductsViewCubit.get(context);
          cubit.init(categoryType);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              title: Text(
                categoryTitle,
                style: const TextStyle(
                    fontFamily: "QuickSand"
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {

              },
              child: Icon(
                Icons.filter_alt
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      MyTFF(
                        controller: searchController,
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        onChanged: (value) {
                          cubit.search(value);
                        }
                      ),
                      SizedBox(height: 10.0,),
                      SizedBox(
                        height: 35.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Search for: ${searchController.text}",
                                    style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Prices from 100JD to 200JD",
                                    style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Rating from 1.2 to 3.5",
                                    style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      if(cubit.queryResult.length == 0)
                        Center(
                          child: Text(
                            "No products found",
                            style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 30.0
                            ),
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.queryResult.length,
                        itemBuilder: (context, index) {
                          ProductData productData = cubit.queryResult[index];
                          return ProductItem(
                            image: productData.image??"",
                            name: productData.name??"",
                            rating: productData.rating??0,
                            ratersNumber: productData.ratingCount??0,
                            price: productData.price??0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String getCategoryTitle(CategoryType categoryType) {
  switch(categoryType) {
    case CategoryType.sportEquipment:
      return "Sports Equipment";
    case CategoryType.allProducts:
      return "All Products";
    case CategoryType.healthAndPersonalCare:
      return "Health & Personal Care";
    case CategoryType.homeAppliances:
      return "Home Appliances";
    case CategoryType.books:
      return "Books";
    case CategoryType.electronics:
      return "Electronics";
    default:
      return "";
  }
}
