import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/Screens/home_screen.dart';
import '../../pages/Screens/reset_password.dart';
import '../../pages/Screens/signup_screen.dart';
import '../../utils/color_utils.dart';
import '../../widgets/reusable_widgets.dart';
import '../../utils/database_connection.dart';

//Draft  unfinished
class PendingVerification extends StatefulWidget {
  const PendingVerification({Key? key}) : super(key: key);

  @override
  State<PendingVerification> createState() => _PendingVerificationState();
}

class _PendingVerificationState extends State<PendingVerification> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("E97777"),
          hexStringToColor("FF9F9F"),
          hexStringToColor("FCDDB0")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                const Text(
                    "To be able to use your account, please verify your email"
                    " address using the link sent to your email email@email.com",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat.bold',
                        color: Colors.white70)),
                const SizedBox(
                  height: 370,
                ),
                const SizedBox(
                  height: 20,
                ),
                resendEmailOpt(),
                changeEmailOpt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row changeEmailOpt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Not your email?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DatabaseConnection()));
          },
          child: const Text(
            "Click to change email",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row resendEmailOpt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Didn't receive an email?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DatabaseConnection()));
          },
          child: const Text(
            "Click to resend",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
