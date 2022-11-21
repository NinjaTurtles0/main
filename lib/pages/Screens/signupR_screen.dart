import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Screens/home_screen.dart';
import 'package:myapp/utils/reusable_widgets.dart';
import 'package:myapp/utils/color_utils.dart';
import 'package:myapp/main.dart';
import 'package:postgres/postgres.dart';


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
  TextEditingController _arkedCode = TextEditingController();
  //Database variable
  dbEntity databaseConn = new dbEntity('ec2-52-1-17-228.compute-1.amazonaws.com'
      ,5432,
      'd41mpmk9818d6f',
      'ljxrkszpegbojk',
      '5ae7a61a7bbb6bbcb2e8a6235a4c91d0b7446817787e04afc4676147c60909e1');
  //await databaseConn;
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
                  reusableTextField("Enter Restaurant Name", Icons.person_outline, false,
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
                  reusableTextField("Enter Arked Name", Icons.apartment_outlined, false,
                      _arkedName),
                  const SizedBox(
                    height:20,
                  ),
                  firebaseButton(context, "Sign up", () {
                    String usernameTemp = _userNameTextController.text;
                    String emailTemp = _emailTextController.text;
                    String passTemp = _passwordTextController.text;
                    /*var counterTemp = databaseConn.query('''SELECT COUNT(*) FROM "Restaurants"
                                      ''');
                    print(counterTemp);*/ //Testing
                    // Error : I/flutter ( 7207): Instance of 'Future<int>'
                    Future<int> counterTemp = databaseConn.getCount('''"Restaurants"'''); //trying to get count of rows for index
                    print(counterTemp); //for testing
                    print("koko wawa kokowawa"); //for testing

                    /*databaseConn.query('''INSERT INTO "Restaurants" ("ID","Name","Email","Password","ArkedID")
                    VALUES ('1',_userNameTextController.text,_emailTextController.text,_passwordTextController.text,1)''');*/


                    //,substitutionValues:{ "username":_userNameTextController.text,
                     //"email":_emailTextController.text,
                     //"password"_passwordTextController.text''');
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value) {
                          //Insert data into database
                          databaseConn.query('''INSERT INTO "Restaurants" ("ID","Name","Email","Password","ArkedID")
                          VALUES ('7','$usernameTemp','$emailTemp','$passTemp',3)'''); //index and arked needs to be variables
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
      'ec2-52-1-17-228.compute-1.amazonaws.com',
      5432,
      'd41mpmk9818d6f',
      username: 'ljxrkszpegbojk',
      password: '5ae7a61a7bbb6bbcb2e8a6235a4c91d0b7446817787e04afc4676147c60909e1',
      useSSL: true, //needed or else the connection wont work
    );
    await databaseConn.open();

    await databaseConn.query(query);
  }

  Future<int> getCount(String table) async {
    int count = 0;
    //database connection
    final databaseConn = PostgreSQLConnection(
      'ec2-52-1-17-228.compute-1.amazonaws.com',
      5432,
      'd41mpmk9818d6f',
      username: 'ljxrkszpegbojk',
      password: '5ae7a61a7bbb6bbcb2e8a6235a4c91d0b7446817787e04afc4676147c60909e1',
      useSSL: true, //needed or else the connection wont work
    );
    await databaseConn.open();
    //PostgreSQLResult x = await databaseConn.query(''' ''');
    PostgreSQLResult x = await databaseConn.query('''SELECT COUNT (*) from
        $table''');
    count = x.affectedRowCount;
    return count;
  }
}