import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../succ.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();

}


class _SignUpState extends State<SignUp>{
  final myController = TextEditingController();
  final myControllerConfirm = TextEditingController();
  final Age = TextEditingController();
  final Number = TextEditingController();
  final Name = TextEditingController();
  final Email = TextEditingController();
  
  bool checkbutt = false;
  var _text = '';

   bool obscureTextPassword = true;
   bool obscureTextPassword2 = true;
   final _focusNodeName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
   final _focusNodeNumber = FocusNode();
    final _focusNodeAge = FocusNode();
     final _focusNodeConfirm = FocusNode();
  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeNumber.dispose();
    _focusNodeAge.dispose();
    _focusNodeConfirm.dispose();
    myController.dispose();
    myControllerConfirm.dispose();
    Age.dispose();
    Number.dispose();
    Name.dispose();
    super.dispose();
  }
  Future signUp() async{
    try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email.text.trim(), password: myControllerConfirm.text.trim());}
    on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
      const snackBar = SnackBar(content: Text("hey questa e-mail è già registrata!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else{
          const snackBar = SnackBar(content: Text("errore generico"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        
        
    }
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.updateDisplayName(Name.text);
      print('registrato con successo');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const succ()));
    }
  }
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 14),
      child: SingleChildScrollView(
        child:
          Stack(
            alignment: Alignment.bottomCenter,
            children: [_formWidget(), _signOutButton()],
          ),
          
        
      ));

  Widget _formWidget() => Padding(
      padding: const EdgeInsets.only(bottom: 23),
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: const EdgeInsets.only(top: 8,),
          
          width: 300,
          child: Column(
            
            children: [
                _nameField(),
                 const Divider(
                height: 0,
              ),
              _emailField(),
               const Divider(
                height: 0,
              ),
              _numberField(),
               const Divider(
                height: 0,
              ),
              _ageField(),
              const Divider(
                height: 0,
              ),
              _passwordField(),
               const Divider(
                height: 0,
              ),
              _confirmPassword()

            ],
          ),
        ),
      ));

  Widget _nameField()=> Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: Name,
        focusNode: _focusNodeName,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration:  const InputDecoration(
          
            border: InputBorder.none,
            hintText: 'Nome',
            hintStyle: TextStyle(fontSize: 15.0),
            icon:  Icon(
              FontAwesomeIcons.userAstronaut,
              color: Colors.black,
              size: 12,
            )),
            onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
          _focusNodeEmail.requestFocus();
        },
      ));


  Widget _emailField() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: Email,
        focusNode: _focusNodeEmail,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration:   InputDecoration(
            errorText: _emailerror,
            border: InputBorder.none,
            hintText: 'E-mail',
            hintStyle: const TextStyle(fontSize: 15.0),
            icon:  const Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 12,
            )),
          onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
          _focusNodeNumber.requestFocus();
        },
      ));

      Widget _numberField() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: Number,
        focusNode: _focusNodeNumber,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: const InputDecoration(
          
            border: InputBorder.none,
            hintText: 'Tel:',
            hintStyle: TextStyle(fontSize: 15.0),
            icon:  Icon(
              FontAwesomeIcons.phone,
              color: Colors.black,
              size: 12,
            )),
          onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
          _focusNodeAge.requestFocus();
        },
      ));

      Widget _ageField() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: Age,
        focusNode: _focusNodeAge,
        keyboardType: TextInputType.datetime,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration:  const InputDecoration(
          
            border: InputBorder.none,
            hintText: 'Data di Nascita',
            hintStyle: TextStyle(fontSize: 15.0),
            icon:  Icon(
              FontAwesomeIcons.calendarDay,
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
        controller: myController,
        focusNode: _focusNodePassword,
        obscureText: obscureTextPassword,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
            errorText: _errorText,
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
          _focusNodeConfirm.requestFocus();
        },
       
      ));

      Widget _confirmPassword() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
        controller: myControllerConfirm,
        
        focusNode: _focusNodeConfirm,
        obscureText: obscureTextPassword2,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
            
            border: InputBorder.none,
            hintText: 'conferma password',
            hintStyle: const TextStyle(fontSize: 15.0),
            icon: const Icon(
              FontAwesomeIcons.key,
              color: Colors.black,
              size: 15,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  if (obscureTextPassword2 == true) {
                    obscureTextPassword2 = false;
                  } else {
                    obscureTextPassword2 = true;
                  }
                });
              },
              child: Icon(
                obscureTextPassword2
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 12.0,
                color: Colors.black,
              ),
            )),
      onChanged: (text) => setState(() => _text),
        onSubmitted: (_) {
        
          // ignore: todo
          //TODO: Register
        },
        textInputAction: TextInputAction.go,
      ));

  Widget _signOutButton() => ElevatedButton(
      
      onPressed: button() == true && _errorText == null && _emailerror == null
      ? () {signUp();}
      : null,
      child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
          child: Text(
            'Registrati',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )));



  

  bool button(){
    if(Name.text.isEmpty || Number.text.isEmpty || Email.text.isEmpty || Age.text.isEmpty || myController.text.isEmpty || myControllerConfirm.text.isEmpty ) {
      return false;
    } else {
      return true;
    }
  }

  String? get _emailerror{
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(Email.text) ){
        return null;
      }else
      if( Email.text.isNotEmpty) {
        return 'e-mail non valida';
      }
    
      
  }

  String? get _errorText {
  // at any time, we can get the text from _controller.value.text
  final text = myController.value.text;
  final text2 = myControllerConfirm.value.text;
  // Note: you can do your own custom validation here
  // Move this logic this outside the widget for more testable code
  if (text != text2) {
    return 'Le password non corrispondono';
  }
  
  if (text.length < 6 && text.length > 1 ) {
    
    return 'Hey scegli una password più difficile';
  }
  // return null if the text is valid
  return null;
}






}

