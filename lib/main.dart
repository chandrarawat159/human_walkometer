import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:humanwalkometer_app/onboard/onboard.dart';
import 'screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:humanwalkometer_app/home.dart';




int? isviewed;
void main()   async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(0, 136, 65, 65),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('OnBoard')??0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Human Walkometer',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isviewed != 0 ? OnBoard() : Home(),
      initialRoute: 'OnBoard',
      routes: {
        'login': (context) => LoginScreen(),
        'ForgotPassword': (context) => ForgotPassword(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        'OnBoard':(context) => OnBoard(),
        
        
        
      },
    );
  }
}
