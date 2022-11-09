import 'package:app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
class App extends StatelessWidget {
  const App({super.key});

  
  @override
  Widget build(BuildContext context) =>  const  MaterialApp(
      title: 'Social App',
     
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  
}