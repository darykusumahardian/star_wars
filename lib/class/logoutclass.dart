import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:star_wars/splashscreen/splashscreen.dart';

class LogoutClass {
  BuildContext? context;
  LogoutClass({required this.context});

  Future logOut() async {
    AwesomeDialog(
      context: context!,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Info',
      desc: 'Yakin Ingin Keluar?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context!,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
          );
        } catch (e) {
          // ignore: avoid_print
          print("Gagal Login ${e.toString()}");
        }
      },
    ).show();
  }
}