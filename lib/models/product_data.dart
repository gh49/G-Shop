import 'package:ecommerce_app/shared/constants.dart';

class ProductData {
  String? name;
  String? pID;
  double? rating;
  int? ratingCount;
  String? image;
  int? quantity;
  String? category;

  ProductData({
    required this.name,
    required this.pID,
    required this.rating,
    required this.ratingCount,
    required this.image,
    required this.quantity,
    required this.category,
  });

  ProductData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pID = json['pID'],
        rating = json['rating'],
        ratingCount = json['ratingCount'],
        image = json['image'],
        quantity = json['quantity'],
        category = json['category'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'pID': pID,
    'rating': rating,
    'ratingCount': ratingCount,
    'image': image,
    'quantity': quantity,
    'category': category,
  };

  @override
  String toString() {
    return "name: $name, "
        "rating: $rating,"
        "rating count: $ratingCount,"
        "image: $image,"
        "quantity: $quantity,"
        "category: $category";
  }

  static CategoryType getCategoryType(String categoryText) {
    switch(categoryText) {
      case "electronics":
        return CategoryType.electronics;
      case "sports":
        return CategoryType.sportEquipment;
      case "books":
        return CategoryType.books;
      case "homeAppliances":
        return CategoryType.homeAppliances;
      case "healthAndPersonalCare":
        return CategoryType.healthAndPersonalCare;
      default:
        return CategoryType.allProducts;
    }
  }

  static String getCategoryText(CategoryType categoryType) {
    switch(categoryType) {
      case CategoryType.electronics:
        return "electronics";
      case CategoryType.sportEquipment:
        return "sports";
      case CategoryType.books:
        return "books";
      case CategoryType.homeAppliances:
        return "homeAppliances";
      case CategoryType.healthAndPersonalCare:
        return "healthAndPersonalCare";
      default:
        return "allProducts";
    }
  }
}