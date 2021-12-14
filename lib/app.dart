import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tineviland/Widgets/colors.dart';
import 'package:tineviland/Views/auth/signup.dart';
import 'package:tineviland/Views/map.dart';
import 'package:tineviland/blocs/user_bloc.dart';
import 'package:tineviland/utils/authmethod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:tineviland/views/home.dart';
import 'package:tineviland/views/posts/add_post.dart';
import 'package:tineviland/views/auth/signin.dart';

import 'blocs/application_bloc.dart';
import 'views/news/add_new.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String? userDocument ;
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  Map map = Map();
  AuthMethods authMethod = AuthMethods();
  Widget currentPage = const SignUp();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => ApplicationBloc()),
        ChangeNotifierProvider(
          create : (context)=> UserBloc()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: currentPage,
        theme: _kAppTheme,
      ),
    );

  }

  void checkLogin() async {

    String? token = await authMethod.getToken();
    if (token != null)  {
      setState(() async {
        currentPage = const Home();
        userDocument = await authMethod.getUserId();
        print("hehe");
        print(userDocument);
      });
    }
  }

}

final ThemeData _kAppTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kAppGreen1,
      onPrimary: kAppGreen2,
      secondary: kAppGreen3,
      error: kAppErrorRed,
    ),

    textTheme: _buildAppTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kAppGreen1,
    ),

  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1!.copyWith(
          fontSize: 30.0,
        ),
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Montsterrat',
        displayColor: Colors.black,
        bodyColor: Colors.black,
      );
}
