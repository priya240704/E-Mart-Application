import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'consts/firebase_consts.dart';
import 'consts/string.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkuser();
  }

  var isLoggedin=false;
  checkuser()async{
    auth.authStateChanges().listen((User? user) {
      if(user==null&& mounted){
        isLoggedin=false;
      }else{
        isLoggedin=true;
      }
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home:isLoggedin ? Home(): LoginScreen(),
     theme: ThemeData(
       appBarTheme: AppBarTheme(
         backgroundColor: Colors.transparent,
         elevation: 0.0,

       ),
     ),
     // home: LoginScreen(),
    );
  }
}

