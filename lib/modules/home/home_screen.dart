import 'package:ecommerce_app/layouts/cubit.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  HomeScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: pageStorageKey,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.none,
              elevation: 10.0,
              margin: EdgeInsets.zero,

              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  const Image(
                    image: AssetImage("assets/shop_card2.png"),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Text(
                          "Browse our different categories",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 37.0,
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                key: pageStorageKey,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
                children: [
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.allProducts, context);
                    },
                    iconData: Icons.search,
                    text: "All Products",
                    color: Colors.yellow.shade800,
                  ),
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.electronics, context);
                    },
                    iconData: Icons.phone_iphone,
                    text: "Electronics",
                    color: Colors.blue,
                  ),
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.books, context);
                    },
                    iconData: Icons.menu_book,
                    text: "Books",
                    color: Colors.brown,
                  ),
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.homeAppliances, context);
                    },
                    iconData: Icons.local_laundry_service,
                    text: "Home Appliances",
                    color: Colors.grey,
                  ),
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.healthAndPersonalCare, context);
                    },
                    iconData: Icons.health_and_safety,
                    text: "Health & Personal Care",
                    color: Colors.red,
                  ),
                  CategoryItem(
                    onPressed: () {
                      categoryItemOnPressed(CategoryType.sportEquipment, context);
                    },
                    iconData: Icons.sports_football,
                    text: "Sport Equipment",
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
