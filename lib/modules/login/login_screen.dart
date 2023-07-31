import 'package:ecommerce_app/layouts/shopping_layout.dart';
import 'package:ecommerce_app/modules/login/cubit.dart';
import 'package:ecommerce_app/modules/login/states.dart';
import 'package:ecommerce_app/modules/register/register_screen.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:ecommerce_app/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  SnackBar? snackBar;

  LoginScreen({super.key, this.snackBar});

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginInitialState) {
            if(snackBar != null) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar!);
              snackBar = null;
            }
          }
          if(state is LoginErrorState) {
            showToast(context, "Error: Email and/or password is incorrect", ToastType.error);
            print(state.error);
          }
          if(state is LoginSuccessState) {
            navigateAndFinish(context, ShoppingLayout());
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                      SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 100.0,
                                child: Image(
                                  image: AssetImage("assets/shopping_cart.png"),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 36.0,
                                  fontFamily: "QuickSand",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
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
                        controller: passwordController,
                        labelText: "Password",
                        obscureText: !cubit.showPassword,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: cubit.passwordSuffixIcon,
                          onPressed: () {
                            cubit.togglePasswordVisibility();
                          },
                        ),
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
                      if(state is! LoginLoadingState)
                        MyButton(
                        text: "Log In",
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            cubit.emailLogin(emailController.text, passwordController.text);
                          }
                        },
                      ),
                      if(state is LoginLoadingState)
                        const Center(child: CircularProgressIndicator()),
                      Row(
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: SmallText(context),
                          ),
                          TextButton(
                            child: Text(
                              "Register now.",
                              style: SmallText(context, color: Colors.blue),
                            ),
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                          ),
                        ],
                      ),
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
