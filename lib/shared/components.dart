import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

Widget MyTFF({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String labelText = '',
  String hintText = '',
  bool obscureText = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  void Function()? onTapped,
  bool readOnly = false,
}) => TextFormField(
  controller: controller,
  validator: validator,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  keyboardType: keyboardType,
  obscureText: obscureText,
  onTap: onTapped,
  readOnly: readOnly,
  decoration: InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  ),
);

Widget MyButton({
  required String text,
  required void Function()? onPressed,
  double width = double.infinity,
  double height = 50.0,
  TextAlign textAlign = TextAlign.center,
  FontWeight fontWeight = FontWeight.normal,
  Color color = myOrange,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(30.0),
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "QuickSand",
        fontSize: 30.0,
        fontWeight: fontWeight,
      ),
    ),
  ),
);

void simulateServiceCall(int seconds) {
  Future.delayed(Duration(seconds: seconds)).
  then((value) {
    print("Service Call Completed");
  });
}

enum ToastType {
  success,
  error,
  message,
}

void showToast(BuildContext context, String text, ToastType toastType) {
  late Color toastColor;
  switch (toastType) {
    case ToastType.success:
      toastColor = Colors.green;
      break;
    case ToastType.error:
      toastColor = Colors.red;
      break;
    case ToastType.message:
      toastColor = Colors.yellow;
      break;
    default:
      toastColor = Colors.yellow;
  }
  var snackBar = SnackBar(content: Text(text), backgroundColor: toastColor, );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget MyElevatedButton({
  required void Function()? onPressed,
  required IconData iconData,
  required String text,
  Color color = Colors.blue,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 10.0,
      backgroundColor: color,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Icon(
            iconData,
            size: 70,
          ),
          SizedBox(height: 15.0,),
          Text(
            text,
            style: TextStyle(
              fontFamily: "QuickSand",
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CategoryItem({
  required void Function()? onPressed,
  required IconData iconData,
  required String text,
  Color color = Colors.blue,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 70,
              color: Colors.white,
            ),
            SizedBox(height: 15.0,),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "QuickSand",
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ProductItem({
  required String image,
  required String name,
  required double rating,
  required int ratersNumber,
  required double price,
}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    //color: Colors.pink.withOpacity(0.6),
    elevation: 10.0,
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: NetworkImage(image),
                width: 130.0,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "QuickSand",
                          ),
                        ),
                        Row(
                          children: [
                            //Rating value
                            Text(
                              "${rating.toStringAsFixed(1)}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "QuickSand",
                              ),
                            ),
                            SizedBox(width: 3.0,),
                            RatingBar.builder(
                              initialRating: rating,
                              ignoreGestures: true,
                              minRating: 0,
                              maxRating: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                              },
                            ),
                            SizedBox(width: 3.0,),
                            //Rating number
                            Text(
                              "($ratersNumber)",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "QuickSand",
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontSize: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "JD",
                                  style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void categoryItemOnPressed(CategoryType category) {

}