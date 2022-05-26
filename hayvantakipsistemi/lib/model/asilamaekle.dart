import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/model/takvimicon.dart';
import 'package:hayvantakipsistemi/model/textfieldarama.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:truncate/truncate.dart';

class Asilama extends StatefulWidget {
  const Asilama({Key? key}) : super(key: key);

  @override
  State<Asilama> createState() => _AsilamaState();
}
asilamakelime(String metin) {
  String text = metin;
  String yenimetin =
      truncate(text, 15, omission: "...", position: TruncatePosition.end);
  return yenimetin;
}
final _dateFormat = DateFormat('dd/MM/yyyy');
CalendarFormat _format = CalendarFormat.month;
DateTime _selectedDay = DateTime.now();
DateTime _focusedDay = DateTime.now();

class _AsilamaState extends State<Asilama> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  Veriler veri = Veriler();
  String _selectedasiismi = "";
  String _selectedhastalik = "";
  String _selectedkupeno = "";
  String _selectedirkno = "";
  String _selectedbogairkno = "";
  TextEditingController _hayvankupenocontroller = TextEditingController();
  TextEditingController _yapilacakasicontroller = TextEditingController();
  TextEditingController _asilayankisicontroller = TextEditingController();
  TextEditingController _asibaslangiccontroller = TextEditingController();
  TextEditingController _asibitiscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //Hayvanın Küpe Numarası Textfield
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchSelectPage(
                  controller: _hayvankupenocontroller,
                  inputType: TextInputType.number,
                  hinttext: "Hayvanın Küpe Numarasını Seçiniz...",
                  items: veri.kupeno,
                  selectedItem: _selectedkupeno,
                  onSelection: (v) {
                    _selectedkupeno = v;
                    setState(() {});
                  },
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Color(0xFF375BA3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: _selectedkupeno),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Hayvanın Küpe Numarası",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        //Hayvana yapılan aşının Textfield
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchSelectPage(
                  inputType: TextInputType.text,
                  controller: _yapilacakasicontroller,
                  hinttext: "Aşı İsmini Giriniz...",
                  items: veri.asiismi,
                  selectedItem: _selectedasiismi,
                  onSelection: (v) {
                    _selectedasiismi = v;
                    setState(() {});
                  },
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Color(0xFF375BA3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: _selectedasiismi),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Yapılacak Aşıyı Seçiniz",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        //Aşılayan Kişinin Textfield
        Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Color(0xFF375BA3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: _asilayankisicontroller,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
            ),
            onChanged: (value) {},
            decoration: InputDecoration(
                filled: true,
                hintText: "Aşılayan Kişi",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                fillColor: Colors.white,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
        TakvimIcon(
            controller: _asibaslangiccontroller,
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            labeltext: "Aşılama Başlangıç Tarihi"),
       
        TakvimIcon(
            labeltext: "Aşılama Bitiş Tarihi",
            controller: _asibitiscontroller,
            focusedDay: _focusedDay,
            selectedDay: _selectedDay),
      ],
    );
  }

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
            print(_start);
            _start--;
          });
        }
      },
    );
  }
}
