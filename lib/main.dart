import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/users/authentication/login_screen.dart';
import 'package:travel_app/users/fragments/dashboard.dart';
import 'package:travel_app/users/userPreferences/user_preferences.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Travel Planner App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot)
        {
          if(dataSnapShot.data == null)
          {
            return LoginScreen();
          }
          else
          {
            return Dashboard();
          }
        },
      ),
    );
  }
}

