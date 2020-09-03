import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

import 'main.dart';

class EditForm extends StatefulWidget {
  List list;
  int index;

  EditForm({this.index, this.list});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController controllerNama;
  TextEditingController controllerHarga;
  TextEditingController controllerkategori;
  TextEditingController controllerBuatan;
  TextEditingController controllerSisa;

  void editData() {
    String id = widget.list[widget.index]['_id'];
    var url = "http://192.168.1.11:3000/admin/update/$id";
    print(url);
    http.put(url, body: {
      "nama_barang": controllerNama.text,
      "harga": controllerHarga.text,
      "kategori": controllerkategori.text,
      "buatan": controllerBuatan.text,
      "sisa": controllerSisa.text
    });
  }

  @override
  void initState() {
    controllerNama = new TextEditingController(
        text: widget.list[widget.index]['nama_barang']);
    controllerHarga = new TextEditingController(
        text: widget.list[widget.index]['harga'].toString());
    controllerkategori =
        new TextEditingController(text: widget.list[widget.index]['kategori']);
    controllerBuatan =
        new TextEditingController(text: widget.list[widget.index]['buatan']);
    controllerSisa = new TextEditingController(
        text: widget.list[widget.index]['sisa'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
        backgroundColor: Colors.red[900],
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(children: [
          new Column(
            children: [
              TextField(
                controller: controllerNama,
                decoration: new InputDecoration(
                  hintText: "Masukan Nama Barang",
                  labelText: "Nama Barang",
                ),
              ),
              TextField(
                controller: controllerHarga,
                decoration: new InputDecoration(
                  hintText: "Masukan Harga Barang",
                  labelText: "Harga Barang",
                ),
              ),
              TextField(
                controller: controllerkategori,
                decoration: new InputDecoration(
                  hintText: "Masukan Kategori Barang",
                  labelText: "Kategori Barang",
                ),
              ),
              TextField(
                controller: controllerBuatan,
                decoration: new InputDecoration(
                  hintText: "Masukan Asal Pembuat",
                  labelText: "Barang Buatan",
                ),
              ),
              TextField(
                controller: controllerSisa,
                decoration: new InputDecoration(
                  hintText: "Masukan Sisa Barang",
                  labelText: "Sisa Barang",
                ),
              ),
              new Padding(padding: EdgeInsets.all(10.0)),
              new RaisedButton(
                child: new Text("Edit Data"),
                color: Colors.blue,
                onPressed: () {
                  editData();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Home()));
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}
