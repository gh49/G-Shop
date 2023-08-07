import 'package:ecommerce_app/shared/constants.dart';

enum CompareType {
  increasing,
  decreasing,
}

enum CompareBy {
  name,
  rating,
  price,
}

class ProductData {
  String? name;
  String? pID;
  double? rating;
  int? ratingCount;
  String? image;
  int? quantity;
  String? category;
  String? description;
  double? price;

  ProductData({
    required this.name,
    required this.pID,
    required this.rating,
    required this.ratingCount,
    required this.image,
    required this.quantity,
    required this.category,
    required this.description,
    required this.price,
  });

  // ProductData.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       pID = json['pID'],
  //       rating = json['rating'],
  //       ratingCount = json['ratingCount'],
  //       image = json['image'],
  //       quantity = json['quantity'],
  //       category = json['category'],
  //       description = json['description'],
  //       price = json['price'] as double;

  ProductData.fromJson(Map<String, dynamic> json) {
    if(json['rating'] is int) {
      json['rating'] = (json['rating'] as int).toDouble();
    }
    if(json['price'] is int) {
      json['price'] = (json['price'] as int).toDouble();
    }
    name = json['name'];
    pID = json['pID'];
    rating = json['rating'];
    ratingCount = json['ratingCount'];
    image = json['image'];
    quantity = json['quantity'];
    category = json['category'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'pID': pID,
    'rating': rating,
    'ratingCount': ratingCount,
    'image': image,
    'quantity': quantity,
    'category': category,
    'description': description,
    'price': price,
  };

  @override
  String toString() {
    return "name: $name, "
        "rating: $rating,"
        "rating count: $ratingCount, "
        "image: $image, "
        "quantity: $quantity, "
        "category: $category, "
        "description: $description, "
        "price: $price";
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

  int compareTo(ProductData productData, CompareType compareType, CompareBy compareBy) {
    int result = 0;
    switch(compareBy) {
      case CompareBy.price:
        double price1 = price??0.0;
        double price2 = productData.price??0.0;
        if(price1 > price2) {
          result = 1;
        }
        else if(price1 < price2) {
          result = -1;
        }
        if(compareType == CompareType.decreasing) {
          result *= -1;
        }
        break;
      case CompareBy.rating:
        double rating1 = rating??0.0;
        double rating2 = productData.rating??0.0;
        if(rating1 > rating2) {
          result = 1;
        }
        else if(rating1 < rating2) {
          result = -1;
        }
        if(compareType == CompareType.decreasing) {
          result *= -1;
        }
        break;
      default:
        String name1 = name??"";
        String name2 = productData.name??"";
        result = name1.compareTo(name2);
        if(compareType == CompareType.decreasing) {
          result *= -1;
        }
        break;
    }

    return result;
  }
}