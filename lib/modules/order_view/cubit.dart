import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/order_view/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderViewCubit extends Cubit<OrderViewStates> {
  OrderViewCubit() : super(OrderViewInitialState());
  static OrderViewCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init(Map<String, dynamic> orderDetails) {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    getProducts(orderDetails);
  }

  List<Map<String, dynamic>> products = [];

  Future<void> getProducts(Map<String, dynamic> orderDetails) async {
    List<dynamic> productIDList = orderDetails["products"];
    var firestore = FirebaseFirestore.instance;
    var productCollection = firestore.collection("products");
    print("IM HEHEHEHE");
    for(String pID in productIDList) {
      try {
        Query<Map<String, dynamic>> query = productCollection.where(
            "pID", isEqualTo: pID);
        QuerySnapshot<Map<String, dynamic>> result = await query.get();
        products.add(result.docs[0].data());
      }
      catch (e) {
        emit(OrderViewGetOrderViewErrorState());
        return;
      }
    }
    emit(OrderViewGetOrderViewSuccessState());
  }

}