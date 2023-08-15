abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartGetDataSuccessState extends CartStates {}

class CartGetDataErrorState extends CartStates {}

class CartRemoveProductSuccessState extends CartStates {}

class CartRemoveProductErrorState extends CartStates {}

class CartCheckoutLoadingState extends CartStates {}

class CartCheckoutSuccessState extends CartStates {}

class CartCheckoutErrorState extends CartStates {}