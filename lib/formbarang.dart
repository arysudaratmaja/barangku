import 'package:flutter/material.dart';
import 'barang.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:google_fonts/google_fonts.dart';

class FormBarang extends StatefulWidget {
  final Barang barang;
  FormBarang(this.barang);
  @override
  FormBarangState createState() => FormBarangState(this.barang);
}
//class controller
class FormBarangState extends State<FormBarang> {
  Barang barang;
  FormBarangState(this.barang);
  TextEditingController namaController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  String result = "-";
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (barang != null) {
      namaController.text = barang.nama;
      kodeController.text = barang.kode;
      hargaController.text = barang.harga;
    }
    //ubah
    return Scaffold(
        body: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Container(
                color: Colors.black,
                child: Image.asset(
                  'images/2.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          barang == null
                              ? "Tambah Data Barang"
                              : "Ubah Data Barang",
                          style: GoogleFonts.poppins(
                            textStyle:TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          )),
                        ),
                      ])),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50,right: 50,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding (
                            padding: EdgeInsets.only(top:20.0, bottom:20.0),
                            child: TextField(
                              controller: kodeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelStyle: GoogleFonts.poppins(
                                    textStyle:TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                labelText: 'Kode',
                                suffixIcon: IconButton(
                                  onPressed:(_scanQR),
                                  icon: Icon(Icons.linked_camera),
                                ),
                                contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onChanged: (value) {
                                //
                              },
                            ),
                          ),
                          Padding (
                            padding: EdgeInsets.only(top:20.0, bottom:20.0),
                            child: TextField(
                              controller: namaController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Nama Barang',
                                labelStyle: GoogleFonts.poppins(
                                    textStyle:TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onChanged: (value) {
                                //
                              },
                            ),
                          ),
                          // telepon
                          Padding (
                            padding: EdgeInsets.only(top:20.0, bottom:20.0),
                            child: TextField(
                              controller: hargaController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Harga',
                                labelStyle: GoogleFonts.poppins(
                                    textStyle:TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onChanged: (value) {
                                //
                              },
                            ),
                          ),
                          Padding (
                            padding: EdgeInsets.only(top:20.0, bottom:20.0),
                            child: Row(
                              children: <Widget> [
                                Expanded(
                                  child: RaisedButton(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                    color: Colors.white60,
                                    child: Text(
                                      'Batal',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          height: 1,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Container(width: 20.0,),
                                Expanded(
                                  child: RaisedButton(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                    child: Text(
                                      'Simpan',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          height: 1,
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (barang == null) {
                                        // tambah data
                                        barang = Barang(namaController.text, kodeController.text, hargaController.text);
                                      } else {
                                        // ubah data
                                        barang.nama = namaController.text;
                                        barang.kode= kodeController.text;
                                        barang.harga = hargaController.text;
                                      }
                                      // kembali ke layar sebelumnya dengan membawa objek barang
                                      Navigator.pop(context, barang);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]))
    );
  }
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        kodeController.text = result;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
}

