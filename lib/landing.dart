import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 350),
                child:
                Image.asset('images/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'BarangKu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      height: 0,
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,top: 280),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child:
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => (Home())),
                        );
                      },
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      color: Colors.black,

                      child: Text(
                        'Mulai sekarang',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            height: 1,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}