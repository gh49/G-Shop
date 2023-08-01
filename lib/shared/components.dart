import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

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
    border: const OutlineInputBorder(),
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
}) => Container(
  width: width,
  height: height,
  color: myOrange,
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

void categoryItemOnPressed(CategoryType category) {

}