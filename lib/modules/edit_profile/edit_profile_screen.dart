import 'package:ecommerce_app/modules/edit_profile/cubit.dart';
import 'package:ecommerce_app/modules/edit_profile/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if(state is EditProfileUpdateDataSuccessState) {
            showToast(context, "Profile Updated Successfully", ToastType.success);
          }
          if(state is EditProfileUpdateDataErrorState) {
            showToast(context, "Could not Update Profile", ToastType.error);
          }
        },
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);
          cubit.init();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              title: Text(
                "Edit Profile",
                style: TextStyle(
                    fontFamily: "QuickSand"
                ),
              ),
              actions: [
                if(state is! EditProfileGetDataErrorState &&
                state is! EditProfileInitialState &&
                state is! EditProfileUpdateDataLoadingState)
                TextButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      cubit.updateUserData();
                    }
                    else {
                      cubit.emitInvalidInput();
                    }
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if(state is EditProfileUpdateDataLoadingState)
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                SizedBox(width: 10.0,),
              ],
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                if(state is! EditProfileInitialState)...[
                  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTFF(
                            controller: cubit.nameController,
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person),
                            keyboardType: TextInputType.text,
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
                        SizedBox(
                          height: 20.0,
                        ),
                        MyTFF(
                            controller: cubit.phoneController,
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
                            controller: cubit.dobController,
                            prefixIcon: Icon(Icons.date_range),
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
                                cubit.dobController.text = "${value.year}-${value.month}-${value.day}";
                              });
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                ] else
                  Center(
                    child: CircularProgressIndicator(
                      color: myOrange,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
