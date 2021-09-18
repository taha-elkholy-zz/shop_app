import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

// app token
String token = '';

// signOut from the app
void signOut(context) {
  CashHelper.removeData(key: 'token').then((value) {
    if (value) {
      token = '';
      // if value == true
      navigateAndFinish(context, LoginScreen());
    }
  });
}

// print Full Text from json
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}
