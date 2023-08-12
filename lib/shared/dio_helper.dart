
import 'package:dio/dio.dart';
import 'package:ecommerce_app/shared/constants.dart';

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

  static Future<Response> getUserDetails(Map<String, dynamic> data) async {
    return await dio!.get("users/get_details", queryParameters: data);
  }

  static Future<Response> getUserVerify(Map<String, dynamic> data) async {
    return await dio!.get("users/verify", queryParameters: data);
  }

  static Future<Response> updateUser(Map<String, dynamic> data) async {
    return await dio!.post("users/update_user", data: data);
  }
}