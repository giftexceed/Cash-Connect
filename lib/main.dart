import 'package:cash_connect/auth/reset_password.dart';
import 'package:cash_connect/pages/transactions.dart';
import 'package:cash_connect/provider/account_provider.dart';
import 'package:cash_connect/screens/main_page.dart';
import 'package:cash_connect/screens/splash_screen.dart';
import 'package:cash_connect/services/api_services/shared_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/sign_up.dart';
import 'pages/home_page.dart';

Widget _defaultHome = LoginScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const MainScreen(
      index: 0,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VeeBank: Your cash anywhere you go',
        theme: ThemeData(
          fontFamily: "OpenSans",
          primarySwatch: Colors.deepOrange,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // routes: Routes.route(),
        routes: {
          '/': (context) => _defaultHome,
          SplashScreen.id: (BuildContext context) => SplashScreen(),
          LoginScreen.id: (BuildContext context) => LoginScreen(),
          Signup.id: (BuildContext context) => Signup(),
          MainScreen.id: (BuildContext context) => MainScreen(),
          HomePage.id: (BuildContext context) => HomePage(),
          Transactions.id: (BuildContext context) => Transactions(),
          ResetPassword.id: (BuildContext context) => ResetPassword(),
        },
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
