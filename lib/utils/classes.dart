import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screens/signin_screen.dart';
import 'package:postgres/postgres.dart';

//Draft Testing
class restaurantOwner {
  int id = 0;
  String name = "";
  String email = "";
  String password = "";
  int arkedID = 0;
  String logo = "";

   restaurantOwner(int id, String name, String email, String password, int arkedID, String logo){
    this.id = id;
    this.name = name;
    this.email = email;
    this.password = password;
    this.arkedID = arkedID;
    this.logo = logo;
  }

  int getID(){
    return id;
  }
  String getName(){
    return name;
  }
  String getpassword(){
    return password;
  }
  String getEmail(){
    return email;
  }
  int getArkedID(){
    return arkedID;
  }
  String getLogo(){
    return logo;
  }
}