import 'package:flutter/material.dart';

class WidgetListView extends StatelessWidget {
  const WidgetListView({ Key? key, required this.data}) : super(key: key);
  final List<dynamic>? data;
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data!.map((e) => 
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: .0),
                          child: Text(e['name'].toString(), style: const TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0, left: .0),
                          child: Text("height : ${e['height'].toString()} cm"),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        )
      ).toList(),
    );
  }
}