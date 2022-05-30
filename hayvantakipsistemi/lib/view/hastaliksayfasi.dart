import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:hayvantakipsistemi/model/bilgiler.dart';
import 'package:hayvantakipsistemi/model/hastalikekle.dart';
import 'package:hayvantakipsistemi/model/header.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HastalikSayfasi extends StatefulWidget {
  const HastalikSayfasi({Key? key}) : super(key: key);

  @override
  State<HastalikSayfasi> createState() => _HastalikSayfasiState();
}

List<HastalikEkleFirebase> _hastalikverileri = [];
List<HayvanEkleFirebase> _hayvanverileri = [];
FirebaseAuth _auth = FirebaseAuth.instance;
final _dateFormat = DateFormat('dd/MM/yyyy');
CalendarFormat _format = CalendarFormat.month;
TextEditingController _hastalikkupeno = TextEditingController();
TextEditingController _hastalikismi = TextEditingController();
TextEditingController _hastalikbaslangictarihi = TextEditingController();
TextEditingController _hastalikbitistarihi = TextEditingController();
TextEditingController _hastaliknotbilgisi = TextEditingController();

class _HastalikSayfasiState extends State<HastalikSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    _hastalikverileri=[];
    _hayvanverileri=[];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: GestureDetector(
          onTap: (() {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.9),
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          automaticallyImplyLeading: false,
                          title: Text(
                            "Hastalık Ekle",
                            style: TextStyle(
                              color: Color(0xFF375BA3),
                            ),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                              color: Color(0xFF375BA3),
                            )
                          ],
                          elevation: 0,
                        ),
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: HastalikEkleModal(),
                        ),
                      ),
                    ));
          }),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(34),
              gradient: LinearGradient(
                colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white.withOpacity(0.8),
              size: 35,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 31),
            child: Column(children: [
              Header(baslik: "Hastalık"),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Color(0xFFECECEC)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 15),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF375BA3),
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Hastalık Bilgisi Ara"),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  builder: _buildListView,
                  future: readTumHayvanlar(),
                )
              ),
              Text("Stream Verileri"),
               Expanded(
                          child: StreamBuilder<List<HastalikEkleFirebase>>(
                            stream: readTumHayvanlarstream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Bir Hata Oluştu - ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final _hayvanlar = snapshot.data!;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: _hayvanlar
                                          .map(_buildhayvanlar)
                                          .toList(),
                                    ),
                                  ),
                                );
                              } 
                              else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
              
            ])));
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapshot) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _hayvanverileri.length,
            itemBuilder: _buildListTile,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    return Bilgiler(
      deger: false,
      resim:"https://firebasestorage.googleapis.com/v0/b/hayvantakipsistemi1.appspot.com/o/hayvanlar%2Finek.png?alt=media&token=c7dfd97c-42b3-4211-a523-273667d398dd",
      icon: Icon(Icons.sick_rounded, color: Color(0xFF375BA3)),
      icerik: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Küpe Numarası",
                  style: TextStyle(
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(_hastalikverileri[index].hayvaninkupeno)),
              ],
            ),
            Row(
              children: [
                Text(
                  "Hastalik İsmi",
                  style: TextStyle(
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(_hastalikverileri[index].hastalikismi),
              ],
            ),
            Row(
              children: [
                Text(
                  "Hastalık Başlangıç Tarihi",
                  style: TextStyle(
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(_hastalikverileri[index].hastalikbaslangic.toString()),
              ],
            ),
            Row(
              children: [
                Text(
                  "Hastalık Bitiş Tarihi",
                  style: TextStyle(
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(_hastalikverileri[index].hastalikbitis.toString()),
              ],
            ),
            _hastalikverileri[index] != null
                ? Row(
                    children: [
                      Text(
                        "Not",
                        style: TextStyle(
                            color: Color(0xFF375BA3),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_hastalikverileri[index].hastaliknot),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar');
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();
    if (snapshot.docs.isNotEmpty && sorgu != null) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {

        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          Query<Map<String, dynamic>> sorgu1 = FirebaseFirestore.instance
              .collection('kullanicilar')
              .doc(_auth.currentUser!.uid)
              .collection('hayvanlar')
              .doc(dokuman.id)
              .collection('hastalik');
          if (sorgu1 != null) {
            QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
            if (snapshot1.docs.isNotEmpty) {
              for (DocumentSnapshot<Map<String, dynamic>> dokuman1
                  in snapshot1.docs) {
                Map<String, dynamic>? hastalikMap = dokuman1.data();
                hastalikMap?["id"] = dokuman1.id;
                if (hastalikMap != null) {
                  HayvanEkleFirebase hayvan =
                      HayvanEkleFirebase.fromJson(hayvanMap);
                  _hayvanverileri.add(hayvan);
                  HastalikEkleFirebase hastalik =
                      HastalikEkleFirebase.fromJson(hastalikMap);
                  _hastalikverileri.add(hastalik);
                }
              }
            }
          }
        }
      }
    }
    return _hayvanverileri;
  }
  Stream<List<HastalikEkleFirebase>> readTumHayvanlarstream() async* {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar');
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();
    if (snapshot.docs.isNotEmpty && sorgu != null) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {

        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          Query<Map<String, dynamic>> sorgu1 = FirebaseFirestore.instance
              .collection('kullanicilar')
              .doc(_auth.currentUser!.uid)
              .collection('hayvanlar')
              .doc(dokuman.id)
              .collection('hastalik');
          if (sorgu1 != null) {
            QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
            if (snapshot1.docs.isNotEmpty) {
              for (DocumentSnapshot<Map<String, dynamic>> dokuman1
                  in snapshot1.docs) {
                Map<String, dynamic>? hastalikMap = dokuman1.data();
                hastalikMap?["id"] = dokuman1.id;
                if (hastalikMap != null) {
                  _readHayvanlarstream(sorgu1);
                }
              }
            }
          }
        }
      }
    }
  }


   Stream<List<HastalikEkleFirebase>> _readHayvanlarstream(Query<Map<String, dynamic>> sorgu ) {
    return sorgu.snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => HastalikEkleFirebase.fromJson(doc.data()))
            .toList());   
  }
    Widget _buildhayvanlar(HastalikEkleFirebase hastalik) => Container(
        margin: EdgeInsets.only(top: 14),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/hayvantakipsistemi1.appspot.com/o/hayvanlar%2Finek.png?alt=media&token=c7dfd97c-42b3-4211-a523-273667d398dd")),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Küpe Numarası",
                          style: TextStyle(color: Color(0xFF2EFFF1)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          hastalik.hayvanId,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Hastalık İsmi",
                          style: TextStyle(color: Color(0xFF2EFFF1)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                           hastalik.hastalikismi,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Color(0xFF2EFFF1),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Bilgileri Görüntüle",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Color(0xFF2EFFF1),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );


  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 50;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 50) {
          _start--;
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            hinttext,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "lucida",
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
