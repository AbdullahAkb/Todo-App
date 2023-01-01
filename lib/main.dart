import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/screens/main_screen.dart';
import 'package:todo_app/screens/new_plan_screen.dart';
import 'package:todo_app/screens/plan_list_screen.dart';
import 'package:todo_app/utils/images.dart';
import 'package:todo_app/utils/projectColors.dart';
import 'config/object_box.dart';

late final ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: ProjectColors.splash_background, // status bar color
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splashIconSize: 150,
            backgroundColor: ProjectColors.splash_background,
            splash: Container(
              // height: ,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(Images.splash_Image),
              )),
              child: Image.asset(
                Images.splash_Image,
              ),
            ),
            centered: true,
            pageTransitionType: PageTransitionType.fade,
            animationDuration: Duration(seconds: 3),
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: MainScreen()));
  }
}
