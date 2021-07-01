import 'package:flutter/material.dart';
import 'package:star_wars/class/logoutclass.dart';
import 'package:star_wars/class/peoplesclass.dart';
import 'package:star_wars/home/widgetgridview.dart';
import 'package:star_wars/home/widgetlistview.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  List<dynamic>? data;
  int page = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await PeoplesClass.connectToAPI(page).then((value) {
      if(value!=null){
        setState(()=>data=value);
      }else{
        setState(()=>data=[]);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BERANDA"),
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
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.list_alt), child: Text("List View"),),
            Tab(icon: Icon(Icons.grid_view_sharp), child: Text("Grid View"),),
          ]),
        ),
        body: TabBarView(children: [
          (data==null)?loadingWdg():(data!.isEmpty)?kosongWdg():widgetListView(),
          (data==null)?loadingWdg():(data!.isEmpty)?kosongWdg():widgetGridView(),
        ]),
      ),
    );
  }

  Widget kosongWdg() => const Center(child: Text("Data Kosong"));
  Widget loadingWdg() => const Center(child: Text("Loading..."));
  Widget widgetListView() => WidgetListView(data: data,);
  Widget widgetGridView() => WidgetGridView(data: data,);
}

