import 'package:app/misc/bubble_indicator_painter.dart';
import 'package:app/pages/Widgets/sign_in.dart';
import 'package:app/pages/Widgets/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:app/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PageController _pageController;
   Color signIn = Color.fromARGB(255, 73, 73, 73);
   Color signUp = Colors.white;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
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
              _logoWidget(),
              _selectorWidget(),
              _pageViewWidget(),
            ],
          ),
        ),)
      );

  Widget _logoWidget() => const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Image(
        image: AssetImage('assets/images/login_logo.png'),
        height: 90.0,
      ));

  Widget _selectorWidget() => Container(
        width: 300.0,
        height: 50.0,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            color: Color(0x552B2B2B),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: CustomPaint(
          painter: BubbleIndicatorPainter(pageController: _pageController),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              child:  Text('Accedi',
                  style: TextStyle(color: signIn, fontSize: 16.0)),
              onPressed: () => _pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate),
            )),
            Expanded(
                child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              child:  Text('Registrati',
                  style: TextStyle(color: signUp, fontSize: 16.0)),
              onPressed: () => _pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate),
            ))
          ],
        ),)
      );

  Widget _pageViewWidget() => Expanded(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                signIn = index == 0 ? Color.fromARGB(255, 73, 73, 73) : Colors.white ;
                signUp = index == 1 ? Color.fromARGB(255, 73, 73, 73) : Colors.white ;
              });
            },
        controller: _pageController,
        children: const [
          SignIn(),
          SignUp(),
        ],
      ));
}
