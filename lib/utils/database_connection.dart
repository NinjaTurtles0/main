import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Screens/home_screen.dart';
import 'package:myapp/pages/Screens/reset_password.dart';
import 'package:myapp/pages/Screens/signup_screen.dart';
import 'package:myapp/utils/color_utils.dart';
import 'package:myapp/utils/reusable_widgets.dart';
import 'package:postgres/postgres.dart';

//To connect to the database
//unneeded for now but keep for reference later on.
class DatabaseConnection extends StatefulWidget {
  const DatabaseConnection({Key? key}) : super(key: key);

  @override
  State<DatabaseConnection> createState() => _DatabaseConnectionState();
}

class _DatabaseConnectionState extends State<DatabaseConnection> {
  @override
  Future operation() async {
    var databaseConnection = PostgreSQLConnection(
        "ec2-52-1-17-228.compute-1.amazonaws.com"
        , 5432, "d41mpmk9818d6f",
        queryTimeoutInSeconds: 3600,
        timeoutInSeconds: 3600,
        username: "ljxrkszpegbojk",
        password: "5ae7a61a7bbb6bbcb2e8a6235a4c91d0b7446817787e04afc4676147c60909e1");
    try {
      await databaseConnection.open();
      print("Connected");
    } catch (e) {
      print("error");
      print(e.toString());
    }
    await databaseConnection.query("INSERT INTO users (id,FName,Email,Password)"
        "Values ('3','Inserted from Flutter','Flutter@gmail.com','flutterishard'");
  }
  Widget build(BuildContext context) {
    return Container();
  }
}

