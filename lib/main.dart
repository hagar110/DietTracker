// @dart=2.9
//null safety problem solved by previous line
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/providers/buttonProviders.dart';
import 'package:firstgp/providers/mainPageProvider.dart';
import 'package:firstgp/screens/loginandregister.dart';
import 'package:firstgp/shared/bloc_observer.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:firstgp/shared/cubit/cubit.dart';
import 'package:firstgp/shared/cubit/states.dart';
import 'package:firstgp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'layout/social_app/cubit/cubit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
    () {
      AppCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();


  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit(),
        ),
      ],
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => mainProvider()),
            ChangeNotifierProvider(create: (_) => buttonProvider()),
          ],
          child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
            debugPrint('Current state: ' + state.toString());
          }, builder: (context, state) {
            return MyApp(
              startWidget: SocialLayout(),
            );
          }))));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
  Widget startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFEFEFF6),
            primarySwatch: Colors.green,
            textTheme: const TextTheme(
                bodyText2: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                bodyText1: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))),
        home: //SocialLayout()
        LoginScreen());
  }
}