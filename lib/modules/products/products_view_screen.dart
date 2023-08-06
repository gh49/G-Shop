import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
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
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  //color: Colors.pink.withOpacity(0.6),
                  elevation: 10.0,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Football_%28soccer_ball%29.svg/1200px-Football_%28soccer_ball%29.svg.png",
                              ),
                              width: 130.0,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Football",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: "QuickSand",
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          //Rating value
                                          Text(
                                            "4.5",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: "QuickSand",
                                            ),
                                          ),
                                          SizedBox(width: 3.0,),
                                          RatingBar.builder(
                                            initialRating: 4.5,
                                            ignoreGestures: true,
                                            minRating: 0,
                                            maxRating: 5,
                                            itemSize: 15.0,
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
                                          SizedBox(width: 3.0,),
                                          //Rating number
                                          Text(
                                            "(19)",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: "QuickSand",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "10.00",
                                              style: TextStyle(
                                                fontFamily: "QuickSand",
                                                fontSize: 30.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "JD",
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ProductItem(
                  image: "https://upload.wikimedia.org/wikipedia/commons/7/7a/Basketball.png",
                  name: "Basketball",
                  rating: 4.7,
                  ratersNumber: 21,
                  price: 19,
                ),
              ],
            ),
          ),
        ],
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
