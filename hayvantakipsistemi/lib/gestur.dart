/*import 'package:flutter/material.dart';

class Gestur extends StatefulWidget {
  const Gestur({ Key? key }) : super(key: key);

  @override
  State<Gestur> createState() => _GesturState();
}

class _GesturState extends State<Gestur> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            context: context,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.8),
                            builder: (context) {
                              return Scaffold(
                                bottomNavigationBar: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16,
                                        left: 16,
                                        bottom: 16,
                                        top: 16),
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            right: 35, left: 35),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF375BA3),
                                              Color(0xFF29E3D7)
                                            ],
                                            begin: FractionalOffset
                                                .centerLeft,
                                            end: FractionalOffset
                                                .centerRight,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            "Tamam",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ))),
                                body: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bilgiler",
                                            style: TextStyle(
                                                color: Color(0xFF375BA3),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          IconButton(
                                              color: Color(0xFF375BA3),
                                              constraints: BoxConstraints(),
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            controller: _hastalikkupeno,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelText: "Küpe Numarası",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            enabled: false,
                                            controller:_hastalikismi ,
                                            decoration: InputDecoration(
                                              
                                              labelText: "Hastalık İsmi",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            enabled: false,
                                            cursorColor: Colors.black,
                                            controller: _hastalikbaslangictarihi,
                                            decoration: InputDecoration(
                                              labelText:
                                                  "Hastalık Başlangıç Tarihi",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            enabled: false,
                                            cursorColor: Colors.black,
                                            controller: _hastalikbitistarihi,
                                            decoration: InputDecoration(
                                              labelText:
                                                  "Hastalık Bitiş Tarihi",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      
  
});}}  */