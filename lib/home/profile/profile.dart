
import 'package:flutter/material.dart';
import 'package:star_wars/class/logoutclass.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deatil People"),
        backgroundColor: Colors.grey[900],
        actions: [
          GestureDetector(
            onTap: () async {
              if(!loading){
                setState(() => loading = true);
                await LogoutClass(context: context).logOut().then((value) => setState(() =>loading=false));
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.settings_power_outlined,),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wdg("Name", widget.data["name"]),
              wdg("Height", widget.data["height"]),
              wdg("Gender", widget.data["gender"]),
              wdg("Eye Color", widget.data["eye_color"]),
              wdg("Skin Color", widget.data["skin_color"]),
              wdg("Hair Color", widget.data["hair_color"]),
            ],
          ),
        ),
      ),
      
    );
  }

  Widget wdg(String title, String subtitle)=>Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(title.toString(), style: const TextStyle(color: Colors.grey),),
    ),
    Text(subtitle.toString(), style: TextStyle(color: (subtitle.toString()=="n/a")?Colors.red:Colors.black),),
  ],);
}