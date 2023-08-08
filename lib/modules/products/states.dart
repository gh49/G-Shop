abstract class ProductsViewStates {}

class ProductsViewInitialState extends ProductsViewStates {}

class ProductsViewLoadingState extends ProductsViewStates {}

class ProductsViewSuccessState extends ProductsViewStates {}

class ProductsViewErrorState extends ProductsViewStates {
  final String error;

  ProductsViewErrorState(this.error);
}

class ProductsViewInvalidInputState extends ProductsViewStates {}

class ProductsViewUpdateProductsListState extends ProductsViewStates {}

class ProductsViewUpdateProductsState extends ProductsViewStates {}

class ProductsViewUpdateFloatingButtonState extends ProductsViewStates {}