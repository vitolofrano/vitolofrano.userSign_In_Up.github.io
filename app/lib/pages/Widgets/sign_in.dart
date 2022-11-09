import 'package:app/pages/succ.dart';
import 'package:app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
String  errore = "";
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

 static Future<User?> loginUsingEmailPassword({required String email , required String password , required BuildContext context}) async{
 FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
  } on FirebaseAuthException catch (e){
    if (e.code == 'user-not-found'){
      errore = "Ops utente non trovato";
    }
  }
 return user;
 }
  


  bool obscureTextPassword = true;
  final pasword = TextEditingController();
  final email = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  
  var _text = '';
  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [_formWidget(), _SignInButton()],
          ),
          _forgotPassword(),
          
        ],
      ));

  Widget _formWidget() => Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          width: 300,
          child: Column(
            children: [
              _emailField(),
              const Divider(
                height: 0,
              ),
              _passwordField(),
            ],
          ),
        ),
      ));

  Widget _emailField() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: email,
        focusNode: _focusNodeEmail,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration:  InputDecoration(
          errorText: _emailerror,
            border: InputBorder.none,
            hintText: 'E-mail',
            hintStyle: TextStyle(fontSize: 15.0),
            icon: const Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 12,
            )),
            onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
          _focusNodePassword.requestFocus();
        },
      ));

  Widget _passwordField() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: pasword,
        focusNode: _focusNodePassword,
        obscureText: obscureTextPassword,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'password',
            hintStyle: const TextStyle(fontSize: 15.0),
            icon: const Icon(
              FontAwesomeIcons.key,
              color: Colors.black,
              size: 15,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  if (obscureTextPassword == true) {
                    obscureTextPassword = false;
                  } else {
                    obscureTextPassword = true;
                  }
                });
              },
              child: Icon(
                obscureTextPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 12.0,
                color: Colors.black,
              ),
            )),
            onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
          //TODO: Login
        },
        textInputAction: TextInputAction.go,
      ));

  Widget _SignInButton() => ElevatedButton(
      onPressed: button() == true  && _emailerror == null?() async { User ? user = await loginUsingEmailPassword(email: email.text, password: pasword.text, context: context);
      
      if(user != null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => succ()));
      }else{
        const snackBar = SnackBar(content: Text('ops Utente non trovato'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      }: null,
      child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
          child: Text(
            'ACCEDI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )));

  Widget _forgotPassword() => Padding(
    padding: const EdgeInsets.only(top: 10),
    child:TextButton(
      
      onPressed: () {},
      child: const Text(
        'Password Dimenticata?',
        style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            decoration: TextDecoration.underline),
      )));




      
String? get _emailerror{
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email.text) ){
        return null;
      }else
      if( email.text.isNotEmpty) {
        return 'e-mail non valida';
      }
      
  }

bool button(){
    if(email.text.isEmpty || pasword.text.isEmpty  || pasword.text.length < 6) {
      return false;
    } else {
      return true;
    }
  }


}
