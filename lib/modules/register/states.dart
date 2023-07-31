abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterToggleGenderState extends RegisterStates {}

class RegisterTogglePasswordVisibility extends RegisterStates {}

class RegisterInvalidInputState extends RegisterStates {}