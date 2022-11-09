import 'package:app/pages/login_page.dart';
import 'package:app/pages/succ.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();

 
}

class _WelcomeState extends State<WelcomePage>{
   Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp =  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
); 
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done ) {
          if (FirebaseAuth.instance.currentUser == null)
          return welcomeScreen();
          else
          return succ();
          
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      );
  

}



class welcomeScreen extends StatelessWidget{
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(144.0),
          decoration: const BoxDecoration(
            
              gradient: LinearGradient(
            colors: [
              CustomTheme.gradientStart,
              CustomTheme.gradientEnd,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
          )),
          child: Column(
            
            children: [
              _welcomeWidget(),
              _social(),
              _signInButton(context),
            ],
          ),
        
      );


 








Widget _welcomeWidget() => Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children:  [
        const Image(
          image: AssetImage('assets/images/login_logo.png'),
          
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(children:[Text(
            "L'ets Get Started",
            style: GoogleFonts.roboto(
              fontSize: 60,
              fontWeight: FontWeight.w600,
              color:  Colors.white,
            )),
            
            Text(
            "Simple Login and Register Page developed with flutter and firebase by Vito Lofrano",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color:  Colors.white,
            )),
            
            ]
          ),
        ),
      ],
    ));



    Widget _social()=>Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () { launchUrl(Uri.parse('https://www.linkedin.com/in/vito-lofrano-979527236/')); }, icon: const Icon(FontAwesomeIcons.linkedin , color: Colors.white , size: 40,)),
          const SizedBox(width: 10,),
          IconButton(onPressed: () {launchUrl(Uri.parse('https://www.instagram.com/vito_lofrano_non/')); }, icon: const Icon(FontAwesomeIcons.instagram , color: Colors.white, size: 40,)),
          const SizedBox(width: 10,),
          IconButton(onPressed: () { launchUrl(Uri.parse('https://github.com/vitolofrano'));}, icon: const Icon(FontAwesomeIcons.github, color: Colors.white, size: 40,))


        ],
    ));



Widget _signInButton(BuildContext context) => ElevatedButton(
  style: ElevatedButton.styleFrom( backgroundColor: const Color.fromARGB(255, 255, 42, 27), shadowColor: Colors.white),
    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const LoginPage()))),
    child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 188.0),
        child: Text(
          'Inizia',
          style: TextStyle( 
            fontSize: 25.0,
          ),
        )));

  

}

