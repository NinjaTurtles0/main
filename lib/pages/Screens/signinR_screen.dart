import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Screens/home_screen.dart';
import 'package:myapp/pages/Screens/pending_verification.dart';
import 'package:myapp/pages/Screens/reset_password.dart';
import 'package:myapp/pages/Screens/signupR_screen.dart';
import 'package:myapp/pages/Screens/signup_screen.dart';
import 'package:myapp/utils/color_utils.dart';
import 'package:myapp/utils/reusable_widgets.dart';
import 'package:myapp/main.dart';
import 'package:postgres/postgres.dart';
import 'package:myapp/pages/Screens/signin_screen.dart';


//Draft Unfinished
class SignInRScreen extends StatefulWidget {
  const SignInRScreen({Key? key}) : super(key: key);

  @override
  State<SignInRScreen> createState() => _SignInRScreenState();
}


class _SignInRScreenState extends State<SignInRScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
      hexStringToColor("E97777"),
      hexStringToColor("FF9F9F"),
      hexStringToColor("FCDDB0")
    ],begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/Logo1.png"),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Your Email", Icons.email_outlined, false, _emailTextController),
              const SizedBox(
                height:20,
              ),
              reusableTextField("Enter Your Password", Icons.password_outlined, true, _passwordTextController),
              const SizedBox(
                height: 5,
              ),
              forgetPassword(context),
              const SizedBox(
                height: 20,
              ),
              firebaseButton(context, "Sign in",() {
                try{
                   FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  });
                } on FirebaseAuthException catch (e){
                  print("12345");
                  print(e.message);
                }

              }),
              signUpOption(),
              const SizedBox(
                height: 10,
              ),
              normalUser()
    ],
    ),
    ),
    ),
    ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
          style: TextStyle(color: Colors.white70)),
    GestureDetector(
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignUpRScreen())); //change PendingVerification to SignUpScreen
    },
    child: const Text(
      "Sign Up",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    )
    ],
    );
  }
  Row normalUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Normal User?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            "Press here!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      )
    );
  }
}