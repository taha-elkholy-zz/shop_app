import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  // constructor match super with initial state of app
  ShopCubit() : super(ShopInitialState());

  // create a static object from the ShopCubit
  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  // light & dark mode
  // true because the first time run
  // the fromShared optional value = null
  // and the changeAppMode enter to the else statement
  // and reverse the value of isDark
  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared == null) {
      // first time open app the isDark from shared = null
      // her we just toggle between the 2 possibles
      isDark = !isDark;
      // save isDark value in shared preferences after edit the new value
      CashHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    } else {
      // her we get saved data from shared preferences
      isDark = fromShared;
      emit(ShopChangeModeState());
    }
  }
}
