
import 'package:dio/dio.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrlTest,
        receiveDataWhenStatusError: true,

      ),
    );
  }

  //
  // User related requests
  //
  static Future<Response> getUserDetails() async {
    String? decodedToken = await getToken();
    Map<String, dynamic> data = {"decodedToken": decodedToken};
    print("Getting details");
    return await dio!.get("users/get_details", queryParameters: data);
  }

  static Future<Response> updateUser(Map<String, dynamic> data) async {
    data["decodedToken"] = await getToken();
    return await dio!.post("users/update_user", data: data);
  }

  static Future<Response> addToCart(String pID) async {
    Map<String, dynamic> data = {"pID": pID};
    data["decodedToken"] = await getToken();

    return await dio!.post("users/add_to_cart", data: data);
  }

  //
  // Product related requests
  //
  static Future<Response> getProducts(String category) async {
    Map<String, dynamic> data = {"category": category};
    return await dio!.get("products/get_by_category", queryParameters: data);
  }

  static Future<String?> getToken() async {
    return await FirebaseAuth.instance.currentUser!.getIdToken();
  }
}