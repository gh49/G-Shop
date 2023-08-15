import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modules/previous_orders/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());
  static OrdersCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init() {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    getOrders();
  }

  List<String> ordersIDList = [];
  List<Map<String, dynamic>> orders = [];

  void getOrders() {
    var firestore = FirebaseFirestore.instance;
    var ordersCollection = firestore.collection("orders");

    ordersCollection.orderBy("dateTime", descending: true).get().then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = value.docs;
      for(var doc in docs) {
        if(doc.data()["uID"] != FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }

        Map<String, dynamic> orderDetails = doc.data();
        orderDetails["orderID"] = doc.id;
        ordersIDList.add(doc.id);
        orders.add(orderDetails);
      }
      print(ordersIDList.length);
      emit(OrdersGetOrdersSuccessState());
    }).catchError((error) {
      emit(OrdersGetOrdersErrorState());
    });
  }
}