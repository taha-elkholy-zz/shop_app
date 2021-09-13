import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  // wait while the async process finish then run the app
  WidgetsFlutterBinding.ensureInitialized();

  // set Bloc observer of the app
  Bloc.observer = MyBlocObserver();

  //init sharedPreferences from CashHelper
  await CashHelper.init();

  // isDark bool variable came from sharedPreferences
  bool? _isDark = CashHelper.getBoolean(key: 'isDark');

  // init DioHelper
  DioHelper.init();

  runApp(MyApp(_isDark));
}

class MyApp extends StatelessWidget {
  // refer to the dark theme
  final bool? _isDark;

  const MyApp(this._isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // use MultiBlocProvider if we have more than one cubit in the same app
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              // here we call changeAppMode when the app starts
              // isDark will be null in first time open
              ..changeAppMode(fromShared: _isDark),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ShopCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const OnBoardingScreen(),
            );
          },
        ));
  }
}
