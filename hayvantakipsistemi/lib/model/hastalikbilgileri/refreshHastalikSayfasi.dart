import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:hayvantakipsistemi/model/bilgiler.dart';

class RefreshHastalik extends StatefulWidget {
  const RefreshHastalik({Key? key}) : super(key: key);

  @override
  State<RefreshHastalik> createState() => _RefreshHastalikState();
}

List<HastalikEkleFirebase> _hastalikverileri = [];
List<HayvanEkleFirebase> _hayvanverileri = [];
FirebaseAuth _auth = FirebaseAuth.instance;
bool yuklemeTamamlandimi=false;
class _RefreshHastalikState extends State<RefreshHastalik> {
  
  @override
  void initState() {
    // TODO: implement initState
    _hastalikverileri = [];
    _hayvanverileri = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
       return false;
      },
      child: Column(
        children: [
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
          yuklemeTamamlandimi==true ?
          Expanded(
              child: FutureBuilder(
            builder: _buildListView,
            future: readTumHayvanlar(),
          )) : Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
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
    resim:
        "https://firebasestorage.googleapis.com/v0/b/hayvantakipsistemi1.appspot.com/o/hayvanlar%2Finek.png?alt=media&token=c7dfd97c-42b3-4211-a523-273667d398dd",
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
