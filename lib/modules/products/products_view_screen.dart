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

  RangeValues priceCurrentRangeValues = RangeValues(0, 3500);
  RangeValues ratingCurrentRangeValues = RangeValues(0, 5);

  TextEditingController searchController = TextEditingController();
  CompareBy sortBy = CompareBy.name;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool bottomSheetOpened = false;
  Icon floatingActionButtonIcon = Icon(Icons.filter_alt);

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
            key: scaffoldKey,
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
              backgroundColor: myOrange,
              onPressed: () {
                if(!bottomSheetOpened) {
                  bottomSheetOpened = true;
                  floatingActionButtonIcon = Icon(Icons.check);
                  cubit.emit(ProductsViewUpdateFloatingButtonState());
                  scaffoldKey.currentState?.showBottomSheet((context) {
                    return StatefulBuilder(builder: (context,
                        StateSetter setState) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 420.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Sort By",
                                        style: TextStyle(
                                            fontFamily: "QuickSand",
                                            fontSize: 25.0
                                        ),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Alphabetical",
                                                  style: TextStyle(
                                                      fontFamily: "QuickSand",
                                                      fontSize: 20.0
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.name,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy = CompareBy.name;
                                                        setState(() {});
                                                      },
                                                    ),
                                                    Text(
                                                      "A-Z",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.nameD,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy = CompareBy.nameD;
                                                        setState(() {

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "Z-A",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Price",
                                                  style: TextStyle(
                                                      fontFamily: "QuickSand",
                                                      fontSize: 20.0
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.price,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy = CompareBy.price;
                                                        setState(() {

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "Low to High",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.priceD,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy = CompareBy.priceD;
                                                        setState(() {

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "High to Low",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Rating",
                                                  style: TextStyle(
                                                      fontFamily: "QuickSand",
                                                      fontSize: 20.0
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.ratingD,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy =
                                                            CompareBy.ratingD;
                                                        setState(() {

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "High to Low",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: CompareBy.rating,
                                                      groupValue: sortBy,
                                                      activeColor: myOrange,
                                                      onChanged: (value) {
                                                        sortBy = CompareBy.rating;
                                                        setState(() {

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "Low to High",
                                                      style: TextStyle(
                                                          fontFamily: "QuickSand",
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Filters",
                                        style: TextStyle(
                                            fontFamily: "QuickSand",
                                            fontSize: 30.0
                                        ),
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        children: [
                                          Text(
                                            "Price",
                                            style: TextStyle(
                                                fontFamily: "QuickSand",
                                                fontSize: 20.0
                                            ),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                            width: 300.0,
                                            child: RangeSlider(
                                              activeColor: myOrange,
                                              divisions: 3500,
                                              min: 0,
                                              max: 3500,
                                              values: priceCurrentRangeValues,
                                              labels: RangeLabels(
                                                priceCurrentRangeValues.start.round().toString(),
                                                priceCurrentRangeValues.end.round().toString(),
                                              ),
                                              onChanged: (values) {
                                                setState(() {
                                                  priceCurrentRangeValues = values;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Rating",
                                            style: TextStyle(
                                                fontFamily: "QuickSand",
                                                fontSize: 20.0
                                            ),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                            width: 300.0,
                                            child: RangeSlider(
                                              activeColor: myOrange,
                                              divisions: 50,
                                              min: 0,
                                              max: 5,
                                              values: ratingCurrentRangeValues,
                                              labels: RangeLabels(
                                                ratingCurrentRangeValues.start.round().toString(),
                                                ratingCurrentRangeValues.end.round().toString(),
                                              ),
                                              onChanged: (values) {
                                                setState(() {
                                                  ratingCurrentRangeValues = values;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                MyButton(
                                  text: "Reset",
                                  onPressed: (){
                                    setState(() {
                                      sortBy = CompareBy.name;
                                      priceCurrentRangeValues = RangeValues(0, 3500);
                                      ratingCurrentRangeValues = RangeValues(0, 5);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }).closed.then((value) {
                    bottomSheetOpened = false;
                    floatingActionButtonIcon = Icon(Icons.filter_alt);
                    cubit.emit(ProductsViewUpdateFloatingButtonState());
                  });
                }
                else {
                  floatingActionButtonIcon = Icon(Icons.filter_alt);
                  Navigator.pop(context);
                  cubit.emit(ProductsViewUpdateFloatingButtonState());
                  cubit.search(searchController.text, sortBy, priceCurrentRangeValues, ratingCurrentRangeValues);
                  print("Price range from ${priceCurrentRangeValues.start} to ${priceCurrentRangeValues.end}");
                  print("Rating range from ${ratingCurrentRangeValues.start} to ${ratingCurrentRangeValues.end}");
                }
              },
              child: floatingActionButtonIcon,
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
                          cubit.search(value, sortBy, priceCurrentRangeValues, ratingCurrentRangeValues);
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
                                    "Prices from ${priceCurrentRangeValues.start.toStringAsFixed(0)}JD to ${priceCurrentRangeValues.end.toStringAsFixed(0)}JD",
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
                                    "Rating from ${ratingCurrentRangeValues.start.toStringAsFixed(1)} to ${ratingCurrentRangeValues.end.toStringAsFixed(1)}",
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
                      if(cubit.queryResult.length == 0 && !cubit.fetchingData)
                        Center(
                          child: Text(
                            "No products found",
                            style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 30.0
                            ),
                          ),
                        ),
                      if(cubit.queryResult.length == 0 && cubit.fetchingData)
                        Center(
                          child: CircularProgressIndicator(color: myOrange),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.queryResult.length,
                        itemBuilder: (context, index) {
                          ProductData productData = cubit.queryResult[index];
                          print(productData);
                          return ProductItem(
                            context: context,
                            pID: productData.pID??"",
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

  void settingModalBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Sort By",
                            style: TextStyle(
                                fontFamily: "QuickSand",
                                fontSize: 25.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Alphabetical",
                                      style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 20.0
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.name,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.name;
                                            setState(() {
                                            });
                                          },
                                        ),
                                        Text(
                                          "A-Z",
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.nameD,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.nameD;
                                            setState(() {

                                            });
                                          },
                                        ),
                                        Text(
                                          "Z-A",
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 20.0
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.price,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.price;
                                            setState(() {

                                            });
                                          },
                                        ),
                                        Text(
                                          "Low to High",
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.priceD,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.priceD;
                                            setState(() {

                                            });
                                          },
                                        ),
                                        Text(
                                          "High to Low",
                                          style: TextStyle(
                                            fontFamily: "QuickSand",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontFamily: "QuickSand",
                                          fontSize: 20.0
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.ratingD,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.ratingD;
                                            setState(() {

                                            });
                                          },
                                        ),
                                        Text(
                                          "High to Low",
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: CompareBy.rating,
                                          groupValue: sortBy,
                                          activeColor: myOrange,
                                          onChanged: (value) {
                                            sortBy = CompareBy.rating;
                                            setState(() {

                                            });
                                          },
                                        ),
                                        Text(
                                          "Low to High",
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Filters",
                            style: TextStyle(
                                fontFamily: "QuickSand",
                                fontSize: 30.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }
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