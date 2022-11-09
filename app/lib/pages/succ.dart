import 'package:app/pages/login_page.dart';
import 'package:app/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class succ extends StatefulWidget {
  const succ({super.key});

  @override
  State<StatefulWidget> createState() => _SuccState();
}

class _SuccState extends State<succ> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) => Container(
          child: Column(children: [
        Text('welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
        ElevatedButton(onPressed: () async{
           
    await FirebaseAuth.instance.signOut();

    if(FirebaseAuth.instance.currentUser == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomePage()));
    }

        }, child: Text('Logout'))
      ]));
}
