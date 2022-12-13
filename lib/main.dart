import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/Screens/signin_screen.dart';
import 'package:postgres/postgres.dart';
import 'package:myapp/controllers/popular_product_controller.dart';
import 'package:myapp/pages/Screens/main_food_page.dart';
import 'package:myapp/data/repository/recommended_product_repo.dart';
import 'package:myapp/controllers/recommended_product_controller.dart';
import 'package:myapp/routes/route_helper.dart';
import 'package:myapp/helper/dependencies.dart' as dep;


  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    //Database connection variable (FINALLY!)
    final databaseConn = PostgreSQLConnection(
      'ec2-52-1-17-228.compute-1.amazonaws.com',
      5432,
      'd41mpmk9818d6f',
      username: 'ljxrkszpegbojk',
      password: '5ae7a61a7bbb6bbcb2e8a6235a4c91d0b7446817787e04afc4676147c60909e1',
      useSSL: true, //needed or else the connection wont work
  );
  await databaseConn.open(); //to open the database
  print('Connected to Postgres database..');//just to test, can be deleted later
    await dep.init();
    runApp(const MyApp());

//example query of inserting into a table

// Be careful when typing the name of the tables, first it's case sensitive, also for the tables that's created using
// pgAdmin you have to put it in between "" (idk why it's so dumb and it took me hours to figure it out) or else it wouldn't work.
// However, for tables that's created from the code in here you can just type the name of the table directly (Again idk whyyyyy :c)

  /*await databaseConn.query('''INSERT INTO "Users" ("ID","FName","Email","Password")
      VALUES ('3','Inserted From Flutter', 'Testing@gmail.com','1111')''');
  var results = await databaseConn.query('''Select * FROM "Users"''');
  print(results); */

  //example query of creating a table

    /*await databaseConn.query('''CREATE TABLE TestingF(
      id serial primary key not null,
      name text,
      email text,
      address text,
      country text)
      ''');
  await databaseConn.close(); // close the database
 */
  }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'UTMFood',
    theme:  ThemeData(
    primarySwatch: Colors.blue,
    ),
      home: const MainFoodPage(), //make it SingInScreen()
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
