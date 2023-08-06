abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class AddProductLoadingState extends AddProductStates {}

class AddProductSuccessState extends AddProductStates {}

class AddProductErrorState extends AddProductStates {
  final String error;

  AddProductErrorState(this.error);
}

class AddProductToggleGenderState extends AddProductStates {}

class AddProductTogglePasswordVisibility extends AddProductStates {}

class AddProductInvalidInputState extends AddProductStates {}