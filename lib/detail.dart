import 'package:flutter/material.dart';
import './editForm.dart' as edit;
import 'package:http/http.dart' as http;
import './main.dart';
import 'main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.list, this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    String id = widget.list[widget.index]['_id'];
    String url = "http://192.168.1.11:3000/admin/delete/$id";
    http.delete(url);
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Apakah anda yakin ingin menghapus data ini ?"),
      actions: [
        new RaisedButton(
          child: new Text("Iya"),
          color: Colors.red[700],
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Home()));
          },
        ),
        new RaisedButton(
          child: new Text("Tidak"),
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        // leading: Icon(Icons.store),
        title: new Text(
            widget.list[widget.index]['nama_barang'].toString().toUpperCase()),
        backgroundColor: Colors.red[900],
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        width: 400.0,
        height: 270.0,
        child: new Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Padding(padding: EdgeInsets.only(top: 10.0)),
                new Text(
                  widget.list[widget.index]['nama_barang']
                      .toString()
                      .toUpperCase(),
                  style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                Row(
                  children: [
                    Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Padding(padding: EdgeInsets.all(8.0)),
                          new Text("Harga"),
                          new Text("Kategori"),
                          new Text("Buatan"),
                          new Text("Sisa")
                        ],
                      ),
                    ),
                    Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Padding(padding: EdgeInsets.all(8.0)),
                          new Text(
                              widget.list[widget.index]['harga'].toString()),
                          new Text(widget.list[widget.index]['kategori']),
                          new Text(widget.list[widget.index]['buatan']),
                          new Text(widget.list[widget.index]['sisa'].toString())
                        ],
                      ),
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.only(top: 25.0)),
                new Center(
                  child: new Row(
                    children: [
                      new RaisedButton(
                        child: new Text("Edit"),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new edit.EditForm(
                                    list: widget.list,
                                    index: widget.index,
                                  )));
                        },
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      new RaisedButton(
                        child: new Text("Delete"),
                        color: Colors.red,
                        onPressed: () => confirm(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
