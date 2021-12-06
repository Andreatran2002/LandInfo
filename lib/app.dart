import 'package:flutter/material.dart';
import 'package:tineviland/Widgets/colors.dart';
import 'package:tineviland/Views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tineviland/Views/Map.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  firebase_auth.FirebaseAuth firebaseAuth =  firebase_auth.FirebaseAuth.instance;
  @override



  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'TINEVY',
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
      theme : _kAppTheme,
    );
  }
  void signup() async {
    try
    {
      await firebaseAuth.createUserWithEmailAndPassword(email: "andreatran200@gmail.com", password: "123Phuongvy");
    }
    catch (e){
      print(e);
    }
  }
  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const Map(),
      fullscreenDialog: true,
    );
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

    // TODO: Add the text themes (103)
    textTheme: _buildAppTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kAppGreen1,
    ),
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
    // inputDecorationTheme: const InputDecorationTheme(
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       width: 2.0,
    //       color: kAppGreen2,
    //     ),
    //   ),
    //   border: OutlineInputBorder(),
    // ),
  );
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kAppGreen1,
      onPrimary: kAppGreen2,
      secondary: kAppGreen3,
      error: kAppErrorRed,
    ),

    // TODO: Add the text themes (103)
    textTheme: _buildAppTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kAppGreen1,
    ),

    // inputDecorationTheme: const InputDecorationTheme(
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       width: 2.0,
    //       color: kAppGreen2,
    //     ),
    //   ),
    //   border: OutlineInputBorder(),
    // ),
  );
}
// TODO: Build a Shrine Text Theme (103)
TextTheme _buildAppTextTheme(TextTheme base){
  return base.copyWith(
    headline1: base.headline1!.copyWith(
      fontSize : 30.0,
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
  ).apply(
    fontFamily: 'Rubik',
    displayColor: Colors.black,
    bodyColor: Colors.black,
  );
}
