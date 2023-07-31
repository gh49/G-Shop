import 'package:ecommerce_app/layouts/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCubit extends Cubit<ShoppingStates> {
  ShoppingCubit() : super(ShoppingInitialState());
  static ShoppingCubit get(context) => BlocProvider.of(context);
}