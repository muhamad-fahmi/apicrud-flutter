import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import './detail.dart' as detail;
import './insertForm.dart' as insert;

void main() {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getBarang() async {
    final respose = await http.get("http://192.168.1.11:3000");
    return json.decode(respose.body);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String url;

  @override
  void initState() {
    // TODO: implement initState
    url = "http://192.168.1.11:3000";
  }
  
  Future<void> refresh() async {
    setState(() {
      url = "http://192.168.1.11:3000";
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new Icon(Icons.store),
        title: new Text("Kedai Beriman"),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new insert.InsertData()));
          }),
      body: RefreshIndicator(
        color: Colors.red[900],
        onRefresh: refresh,
        key: _refreshIndicatorKey,
        child: new FutureBuilder<List>(
            future: getBarang(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.hasError);
              return snapshot.hasData
                  ? new ItemList(
                      list: snapshot.data,
                    )
                  : new Center(child: new CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new detail.Detail(
                        list: list,
                        index: i,
                      )));
            },
            child: new Card(
              child: new ListTile(
                leading: Icon(Icons.widgets),
                title:
                    new Text(list[i]['nama_barang'].toString().toUpperCase()),
                subtitle: new Text("Harga : ${list[i]['harga'].toString()}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
