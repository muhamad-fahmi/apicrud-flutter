import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class InsertData extends StatefulWidget {
  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerkategori = new TextEditingController();
  TextEditingController controllerBuatan = new TextEditingController();
  TextEditingController controllerSisa = new TextEditingController();

//add data method
  void addData() {
    var url = "http://192.168.1.11:3000/admin/insert";
    http.post(url, body: {
      "nama_barang": controllerNama.text,
      "harga": controllerHarga.text,
      "kategori": controllerkategori.text,
      "buatan": controllerBuatan.text,
      "sisa": controllerSisa.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data Barang"),
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
                child: new Text("Submit"),
                color: Colors.blue,
                onPressed: () {
                  addData();
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
