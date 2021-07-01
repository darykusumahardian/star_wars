import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars/class/pvusers.dart';
import 'package:star_wars/home/home.dart';
import 'package:star_wars/model/users.dart';

class LoginClass {
  BuildContext? context;
  LoginClass({required this.context});
  
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("idUser", FirebaseAuth.instance.currentUser!.uid);
        pref.setString("email", FirebaseAuth.instance.currentUser!.email!);
        pref.setString("displayName", FirebaseAuth.instance.currentUser!.displayName!);
      }

      await PvUsers.instance.readDataByID(FirebaseAuth.instance.currentUser!.uid).then((value) async {
        if (value==null) {
          final users = Users(
            id: FirebaseAuth.instance.currentUser!.uid,
            email: FirebaseAuth.instance.currentUser!.email,
            name: FirebaseAuth.instance.currentUser!.displayName,
          );
          await PvUsers.instance.createData(users);
        }else{
          // ignore: avoid_print
          print("Sudah disimpan sebelumnya");
        }
      });
      
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      // ignore: avoid_print
      print("Gagal Login ${e.toString()}");
    }
  }
}