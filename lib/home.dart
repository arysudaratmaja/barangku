import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'barang.dart';
import 'dbhelper.dart';
import 'formbarang.dart';
import 'package:google_fonts/google_fonts.dart';

//pendukung program asinkron

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  int totalharga =0;
  List<Barang> barangList;
  @override
  Widget build(BuildContext context) {
    if (barangList == null) {
      barangList = List<Barang>();
    }
    updateListView();
    return Scaffold(
        body: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Container(
                  margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Data Barang',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          )),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.add_box,
                              size: 35,
                            ),
                          onPressed: () async {
                            var barang = await navigateToEntryForm(context, null);
                            if (barang != null) addBarang(barang);
                          },),
                      ])),
              Container(
                  child: Column(children: <Widget>[
                    createListView()
                  ])),
            ])),
    );
  }
  Future<Barang> navigateToEntryForm(BuildContext context, Barang barang) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return FormBarang(barang);
            }
        )
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(right: 20)),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(this.barangList[index].kode,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w900,
                                          )),
                                      Text(this.barangList[index].nama,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700,
                                          ))),
                                      Text('Rp. ' +
                                        this.barangList[index].harga,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0,
                                        )),
                                      ),
                                    ],
                                  ),
                                ])),
                        Padding(padding: EdgeInsets.only(right: 30)),
                        Container(
                            child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteBarang(barangList[index]);
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async{
                                        var barang = await navigateToEntryForm(context, this.barangList[index]);
                                        if (barang != null) editBarang(barang);
                                      }),
                                ])),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
  //buat barang
  void addBarang(Barang object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }
  //edit barang
  void editBarang(Barang object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }
  //delete barang
  void deleteBarang(Barang object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }
  //update barang
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Barang>> barangListFuture = dbHelper.getBarangList();
      barangListFuture.then((barangList) {
        setState(() {
          this.barangList = barangList;
          this.count = barangList.length;
        });
      });
    });
  }
}


