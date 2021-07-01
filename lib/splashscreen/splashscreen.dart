import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:star_wars/class/loginclass.dart';
import 'package:star_wars/class/logoutclass.dart';
import 'package:star_wars/home/home.dart';
import 'package:star_wars/model/users.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = false;
  
  @override
  Widget build(BuildContext context) {
    LoginClass loginClass = LoginClass(context: context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo/logo.png", width: 160.0,),
            const Text("STAR WARS APP", style: TextStyle(fontFamily: "Starjedi", color: Colors.orange, fontSize: 20.0)),
            const Text("By. DARY KUSUMA HARDIAN", style: TextStyle(color: Colors.white, fontSize: 11.0)),
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context2, AsyncSnapshot<User?> dataUser){
                return (!dataUser.hasData)?
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: SignInButton(
                    Buttons.Google,
                    // mini: true,
                    onPressed: () async {
                      if(!loading){
                        setState(() => loading = true);
                        await loginClass.signInWithGoogle().then((value) => setState(() =>loading=false));
                      }
                    },
                  ),
                ):Column(
                  children: [
                    Tombol(loading: loading, 
                      icon: Icons.settings_power_outlined,
                      title: "Keluar",
                      onTap: () async {
                        if(!loading){
                          setState(() => loading = true);
                          await LogoutClass(context: context).logOut().then((value) => setState(() =>loading=false));
                        }
                      }),
                    Tombol(loading: loading, 
                      icon: Icons.home,
                      title: "Beranda",
                      onTap: () async {
                        if(!loading){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home()),
                          );
                        }
                      },),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}

class Tombol extends StatelessWidget {
  const Tombol({ Key? key, required this.loading, required this.onTap, required this.icon, required this.title}) : super(key: key);
  final bool loading;
  final Function()? onTap;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220.0,
        height: 35.0,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: const BoxDecoration(color: Colors.white,),
        child: Center(child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange,),
            Text(" ${title.toString()}", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),),
          ],
        )),
      ),
    );
  }
}