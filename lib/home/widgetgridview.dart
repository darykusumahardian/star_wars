import 'package:flutter/material.dart';
import 'package:star_wars/home/profile/profile.dart';

class WidgetGridView extends StatelessWidget {
  const WidgetGridView({ Key? key, required this.data}) : super(key: key);
  final List<dynamic>? data;
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
      primary: false,
      childAspectRatio: (itemWidth / itemHeight),
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: data!.map((e) => 
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wdg("Name", e["name"]),
              wdg("Height", e["height"]),
              wdg("Gender", e["gender"]),
              wdg("Eye Color", e["eye_color"]),
              wdg("Skin Color", e["skin_color"]),
              wdg("Hair Color", e["hair_color"]),
              Expanded(child: Container()),
              // ignore: avoid_unnecessary_containers
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(data: e)),
                    );
                  },
                  child: const Text('Detail'),
                ),
              )
            ],
          ),
        )).toList()
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