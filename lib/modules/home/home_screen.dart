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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    const Image(
                      image: AssetImage("assets/shop_card2.png"),
                      fit: BoxFit.fitWidth,
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
              GridView.builder(
                key: pageStorageKey,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
                itemCount: categoryItems.length,
                itemBuilder: (BuildContext context, index) {
                  return categoryItems[index];
                }),
            ],
          ),
        ),
      ),
    );
  }
}
