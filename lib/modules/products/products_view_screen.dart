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
                      ),
                      SizedBox(height: 10.0,),
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
