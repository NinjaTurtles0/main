import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Screens/home_screen.dart';
import 'package:myapp/utils/reusable_widgets.dart';
import 'package:myapp/utils/color_utils.dart';
import 'package:postgres/postgres.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  dbEntity databaseConn = new dbEntity('dpg-ce3jvearrk02ufiodd6g-a.oregon-postgres.render.com'
      ,5432,
      'utmfood',
      'utmfood_user',
      'T3h0gWNRCpBkEZbnPqmrDgt2zXRJshJw');
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true, appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Signup",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
      body: Container(
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
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Full Name", Icons.person_outline, false,
                      _userNameTextController),
                  const SizedBox(
                    height:20,
                  ),
                  reusableTextField("Enter Email ", Icons.email_outlined, false,
                      _emailTextController),
                  const SizedBox(
                    height:20,
                  ),
                  reusableTextField("Enter Password", Icons.password_outlined, true,
                      _passwordTextController),
                  const SizedBox(
                    height:20,
                  ),

                  firebaseButton(context, "Sign up", () {
                    String usernameTemp = _userNameTextController.text;
                    String emailTemp = _emailTextController.text;
                    String passTemp = _passwordTextController.text;

                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value) {
                          databaseConn.insertUser(usernameTemp,emailTemp,passTemp);
                          print(
                            'Account Created Successfully!'
                          );
                          print("Created New Account");
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context)=> HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  })
                ],
              ),
            ))),
    );
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
  Future<void> insertUser(String Fname, String email, String pass) async {
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
        "Users"''');
    count = await x.affectedRowCount;
    count = count + 2;
    databaseConn.query('''INSERT INTO "Users" ("ID","FName","Email","Password")
                          VALUES ('$count','$Fname','$email','$pass')''');
  }
}


