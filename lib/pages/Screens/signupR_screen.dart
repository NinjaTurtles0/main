import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm/pages/Screens/home_screen.dart';
import 'package:utm/utils/reusable_widgets.dart';
import 'package:utm/utils/color_utils.dart';
import 'package:utm/main.dart';
//import 'package:postgres/postgres.dart';

//Draft Unfinished

class SignUpRScreen extends StatefulWidget {
  const SignUpRScreen({Key? key}) : super(key: key);

  @override
  State<SignUpRScreen> createState() => _SignUpRScreenState();
}

class _SignUpRScreenState extends State<SignUpRScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _arkedName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  int arkedCode = 0;
  //Database variable
  dbEntity databaseConn = new dbEntity(
      'dpg-ce3jvearrk02ufiodd6g-a.oregon-postgres.render.com',
      5432,
      'utmfood',
      'utmfood_user',
      'T3h0gWNRCpBkEZbnPqmrDgt2zXRJshJw');
  //await databaseConn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Signup",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: _key,
          child: Container(
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
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Restaurant Name",
                        Icons.person_outline, false, _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email ", Icons.email_outlined,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.password_outlined,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Arked Name",
                        Icons.apartment_outlined, false, _arkedName),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseButton(context, "Sign up", () {
                      String usernameTemp = _userNameTextController.text;
                      String emailTemp = _emailTextController.text;
                      String passTemp = _passwordTextController.text;
                      String arkedTemp = _arkedName.text;

                      if (arkedTemp == "Meranti") {
                        arkedCode = 1;
                      } else if (arkedTemp == "Cengal") {
                        arkedCode = 2;
                      } else {
                        print("Invalid Arked");
                      }
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        databaseConn.insertRestaurant(
                            usernameTemp, emailTemp, passTemp, arkedCode);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    })
                  ],
                ),
              ))),
        ));
  }
}

class dbEntity {
  //can be used later to pass the connection details as variables
  String server = "";
  String dbName = "";
  int port = 0;
  String userName = "";
  String password = "";

  dbEntity(String server, int port, String dbName, String userName,
      String password) {
    this.server = server;
    this.dbName = dbName;
    this.port = port;
    this.userName = userName;
    this.password = password;
  }

  //it's implemented in the worst way possible but we can fix that later on c:
  Future<void> query(String query) async {
    //database connection
    final databaseConn = PostgreSQLConnection(
      'dpg-ce3jvearrk02ufiodd6g-a.oregon-postgres.render.com',
      5432,
      'utmfood',
      username: 'utmfood_user',
      password: 'T3h0gWNRCpBkEZbnPqmrDgt2zXRJshJw',
      useSSL: true, //needed or else the connection wont work
    );
    await databaseConn.open();

    await databaseConn.query(query);
  }

  Future<void> insertRestaurant(
      String nameR, String emailR, String passR, int arkedCode) async {
    int count = 0; //because of null saftey c:
    //database connection
    final databaseConn = PostgreSQLConnection(
      'dpg-ce3jvearrk02ufiodd6g-a.oregon-postgres.render.com',
      5432,
      'utmfood',
      username: 'utmfood_user',
      password: 'T3h0gWNRCpBkEZbnPqmrDgt2zXRJshJw',
      useSSL: true, //needed or else the connection wont work
    );
    await databaseConn.open();
    PostgreSQLResult x = await databaseConn.query('''SELECT * from
        "Restaurants"''');
    count = await x.affectedRowCount;
    count = count + 2;
    databaseConn.query(
        '''INSERT INTO "Restaurants" ("ID","Name","Email","Password","ArkedID")
                          VALUES ('$count','$nameR','$emailR','$passR','$arkedCode')''');
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address Format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required';

  return null;
}
