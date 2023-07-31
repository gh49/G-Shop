import 'package:ecommerce_app/modules/login/cubit.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/modules/register/cubit.dart';
import 'package:ecommerce_app/modules/register/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:ecommerce_app/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterErrorState) {
            String stateError = state.error.toString();
            String error = "Error: ";
            for(int i=0; i<stateError.length; i++) {
              if(stateError[i] == ']' && stateError.length > i + 1) {
                error = "Error: ${stateError.substring(i+1)}";
              }
            }

            showToast(context, error, ToastType.error);
          }
          if(state is RegisterSuccessState) {
            navigateAndFinish(context, LoginScreen(snackBar: const SnackBar(content: Text("Account created successfully"), backgroundColor: Colors.green, ),));
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

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
                                "Register",
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
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if(value == null || value.length < 5) {
                              return "Please enter a valid name";
                            }
                            return null;
                          }
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                  "Male",
                                style: TextStyle(
                                  fontFamily: "QuickSand",
                                  fontSize: 20.0
                                ),
                              ),
                              value: "male",
                              groupValue: cubit.gender,
                              onChanged: (value){
                                cubit.toggleGender("male");
                                print(cubit.gender);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                "Female",
                                style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontSize: 20.0
                                ),
                              ),
                              value: "female",
                              groupValue: cubit.gender,
                              onChanged: (value){
                                cubit.toggleGender("female");
                                print(cubit.gender);
                              },
                            ),
                          ),
                        ],
                      ),
                      MyTFF(
                        controller: emailController,
                        labelText: "Email Address",
                        hintText: "someone@example.com",
                        prefixIcon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                          controller: phoneController,
                          labelText: "Phone Number",
                          hintText: "+962 7X XXX XXXX",
                          prefixIcon: Icon(Icons.phone),
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if(value == null || value.isEmpty) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                        controller: passwordController,
                        labelText: "Password",
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if(value == null || value.length < 6) {
                            return "Please enter a valid password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                        controller: passwordConfirmController,
                        labelText: "Confirm Password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          String password = passwordController.text;
                          if(password.length < 6) {
                            return null;
                          }
                          if(value == null || value != password) {
                            return "Passwords mismatch";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MyTFF(
                        controller: dobController,
                        labelText: "Date of Birth",
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        validator: (String? value) {
                          if(value == null || value.length < 4) {
                            return "Please enter you date of birth.";
                          }
                          else {
                            return null;
                          }
                        },
                        onTapped: () {
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1910), lastDate: DateTime.now()).
                          then((value) {
                            if(value == null) {
                              return;
                            }
                            dobController.text = "${value.year}-${value.month}-${value.day}";
                          });
                        }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if(state is! RegisterLoadingState)
                        MyButton(
                        text: "Register",
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            cubit.register(
                              nameController.text,
                              cubit.gender,
                              emailController.text,
                              phoneController.text,
                              passwordController.text,
                              dobController.text,
                            );
                          }
                          else {
                            cubit.emitInvalidInput();
                          }
                        },
                      ),
                      if(state is RegisterLoadingState)
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
