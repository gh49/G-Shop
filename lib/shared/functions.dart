
import 'package:ecommerce_app/models/product_data.dart';

void sortProducts(List<ProductData> list, CompareBy compareBy,) {
  for(int i=0; i<list.length; i++) {
    int minIndex = i;
    for(int j=0; j<list.length; j++) {
      if(list[minIndex].compareTo(list[j], compareBy) == -1) {
        ProductData tmp = list[minIndex];
        list[minIndex] = list[j];
        list[j] = tmp;
      }
    }
  }
}