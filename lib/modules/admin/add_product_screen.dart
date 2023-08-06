import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/admin/cubit.dart';
import 'package:ecommerce_app/modules/admin/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = AddProductCubit.get(context);
          cubit.init();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage("https://store.sony.com.au/dw/image/v2/ABBC_PRD/on/demandware.static/-/Sites-sony-master-catalog/default/dw88febf25/images/PS5GOWRAGNAROKBUND/PS5GOWRAGNAROKBUND.png"),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 60.0,
                                child: Image(
                                  image: AssetImage("assets/shopping_cart.png"),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Add product",
                                style: TextStyle(
                                  fontSize: 36.0,
                                  fontFamily: "QuickSand",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      MyTFF(
                          controller: nameController,
                          labelText: "Product Name",
                          validator: (String? value) {
                            if(value == null || value.length < 5) {
                              return "Please enter a valid name";
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                          controller: priceController,
                          labelText: "Price",
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if(value == null || value.isEmpty) {
                              return "Please enter a valid rating";
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                          controller: imageController,
                          labelText: "Image",
                          validator: (String? value) {
                            if(value == null || value.isEmpty) {
                              return "Please enter a valid image";
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                        controller: categoryController,
                        labelText: "Category",
                        validator: (String? value) {
                          if(value == null || value.length < 5) {
                            return "Please enter a valid category";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                        controller: quantityController,
                        labelText: "Quantity",
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if(value == null) {
                            return "Please enter a valid quantity";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if(state is! AddProductLoadingState)
                        MyButton(
                          text: "Add Product",
                          fontWeight: FontWeight.bold,
                          onPressed: () {
                            if(formKey.currentState!.validate()) {
                              ProductData newProduct = ProductData(
                                  name: nameController.text,
                                  pID: "",
                                  rating: 0,
                                  ratingCount: 0,
                                  image: imageController.text,
                                  quantity: int.parse(quantityController.text),
                                  category: categoryController.text,
                              );
                              cubit.addProduct(newProduct);
                            }
                            else {
                              cubit.emitInvalidInput();
                            }
                          },
                        ),
                      if(state is AddProductLoadingState)
                        const Center(child: CircularProgressIndicator(),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}