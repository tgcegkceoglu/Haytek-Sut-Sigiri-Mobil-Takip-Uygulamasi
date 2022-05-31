import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hayvantakipsistemi/model/asilamaekle.dart';
import 'package:hayvantakipsistemi/model/bilgiler.dart';
import 'package:hayvantakipsistemi/model/floatingactionbutton.dart';
import 'package:hayvantakipsistemi/model/hastalikbilgileri/hastalikekle.dart';
import 'package:hayvantakipsistemi/model/header.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';
import 'package:hayvantakipsistemi/view/asilamasayfasi.dart';
import 'package:hayvantakipsistemi/view/notekle.dart';
import 'package:hayvantakipsistemi/view/tohumlamasayfasi.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:truncate/truncate.dart';

class Notlar extends StatefulWidget {
  const Notlar({Key? key}) : super(key: key);

  @override
  State<Notlar> createState() => _NotlarState();
}

kelime(String metin) {
  String text = metin;
  String yenimetin =
      truncate(text, 40, omission: "...", position: TruncatePosition.end);
  return yenimetin;
}

//asilama
TextEditingController _asikupeno = TextEditingController();
TextEditingController _yapilanasi = TextEditingController();
TextEditingController _asilayankisi = TextEditingController();
TextEditingController _asilamabaslangic = TextEditingController();
TextEditingController _asilamabitis = TextEditingController();
//hastalik
TextEditingController _hastalikkupeno = TextEditingController();
TextEditingController _hastalikismi = TextEditingController();
TextEditingController _hastalikbaslangic = TextEditingController();
TextEditingController _hastalikbitis = TextEditingController();
//tohumlama
TextEditingController _tohumlamakupeno = TextEditingController();
TextEditingController _tohumlamahayvanirkno = TextEditingController();
TextEditingController _tohumlamabogairkno = TextEditingController();
TextEditingController _tohumlamabogakupeno = TextEditingController();
TextEditingController _tohumlamatohumlamayapanvet = TextEditingController();
TextEditingController _tohumlamabaslangic = TextEditingController();
TextEditingController _tohumlamabitis = TextEditingController();

Veriler veri = Veriler();
final dateFormat = DateFormat('dd/MM/yyyy');
CalendarFormat format = CalendarFormat.month;

class _NotlarState extends State<Notlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonClass(
        baslik: "Not Ekle",
        sayfa: NotEkle(),
        height: MediaQuery.of(context).size.height * 0.9,
        bottomtext: "Notu Ekle",
        hinttext: "Not Eklendi",
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: ListView(
          children: [
            Header(baslik: "Notlar"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFFECECEC)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3),
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
                    hintText: "Notları Ara"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            
            olusturAsi(
                selectedday: DateTime.now(),
                focusedday: DateTime.now(),
                index: 1,
                asilamabaslangic: _asilamabaslangic,
                asilamabitis: _asilamabitis,
                asilayankisi: _asilayankisi,
                kupeno: _asikupeno,
                yapilanasi: _yapilanasi),
            olusturhastalik(
                selectedDay: DateTime.now(),
                focusedDay: DateTime.now(),
                index: 2,
                kupeno: _hastalikkupeno,
                hastalikismi: _hastalikismi,
                hastalikbaslangic: _hastalikbaslangic,
                hastalikbitis: _hastalikbitis),
            olusturtohumlama(
                index: 3,
                kupeno: _tohumlamakupeno,
                selectedDay: DateTime.now(),
                focusedDay: DateTime.now(),
                hayvanirkno:_tohumlamahayvanirkno,
                bogairkno:_tohumlamabogairkno,
                tohumlamayapanvet: _tohumlamatohumlamayapanvet,
                bogakupeno: _tohumlamabogakupeno,
                tohumlamabaslangic: _tohumlamabaslangic,
                tohumlamabitis: _tohumlamabitis),
                olusturAsi(
                selectedday: DateTime.now(),
                focusedday: DateTime.now(),
                index: 4,
                asilamabaslangic: _asilamabaslangic,
                asilamabitis: _asilamabitis,
                asilayankisi: _asilayankisi,
                kupeno: _asikupeno,
                yapilanasi: _yapilanasi),
            olusturhastalik(
                selectedDay: DateTime.now(),
                focusedDay: DateTime.now(),
                index: 5,
                kupeno: _hastalikkupeno,
                hastalikismi: _hastalikismi,
                hastalikbaslangic: _hastalikbaslangic,
                hastalikbitis: _hastalikbitis),
            olusturtohumlama(
                index: 0,
                kupeno: _tohumlamakupeno,
                selectedDay: DateTime.now(),
                focusedDay: DateTime.now(),
                hayvanirkno:_tohumlamahayvanirkno,
                bogairkno:_tohumlamabogairkno,
                tohumlamayapanvet: _tohumlamatohumlamayapanvet,
                bogakupeno: _tohumlamabogakupeno,
                tohumlamabaslangic: _tohumlamabaslangic,
                tohumlamabitis: _tohumlamabitis),
          ],
        ),
      ),
    );
  }

  olusturtohumlama({
    required int index,
    required DateTime focusedDay,
    required DateTime selectedDay,
    required TextEditingController kupeno,
    required TextEditingController hayvanirkno,
    required TextEditingController bogairkno,
    required TextEditingController tohumlamayapanvet,
    required TextEditingController bogakupeno,
    required TextEditingController tohumlamabaslangic,
    required TextEditingController tohumlamabitis,
  }) {
  return  GestureDetector(
      onTap: () {
        kupeno.text = veri.kupeno[index].toString();
        hayvanirkno.text = veri.irk[index].toString();
        bogairkno.text = veri.bogairk[index].toString();
        tohumlamayapanvet.text = veri.asilayankisi[index].toString();
        bogakupeno.text = veri.bogakupeno[index].toString();
        tohumlamabaslangic.text = veri.asilamatarihi[index].toString();
        tohumlamabitis.text = veri.asilamatarihison[index].toString();
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            builder: (context) {
              return Scaffold(
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16, top: 16),
                    child: Container(
                        padding: EdgeInsets.only(right: 35, left: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF375BA3),
                              Color(0xFF29E3D7)
                            ],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
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
                                fontSize: 15, color: Colors.white),
                          ),
                        ))),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: kupeno,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: hayvanirkno,
                            decoration: InputDecoration(
                              labelText: "Hayvanın Irkı",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: bogakupeno,
                            decoration: InputDecoration(
                              labelText: "Boğa Küpe No",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: bogairkno,
                            decoration: InputDecoration(
                              labelText: "Boğanın Irkı",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: tohumlamayapanvet,
                            decoration: InputDecoration(
                              labelText: "Tohumlama Yapan Veteriner",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            inputFormatters: [maskFormatter],
                            controller: tohumlamabaslangic,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: focusedDay,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedDay, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectedDay = selectDay;
                                                    focusedDay = focusDay;
                                                    tohumlamabaslangic.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Tohumlama Başlangıç Tarihi",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            inputFormatters: [maskFormatter],
                            cursorColor: Colors.black,
                            controller: tohumlamabitis,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: focusedDay,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedDay, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectedDay = selectDay;
                                                    focusedDay = focusDay;
                                                    tohumlamabitis.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Tohumlama Bitiş Tarihi",
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
      },
      child: Bilgiler(
        deger: false,
        resim: veri.resimyolu[index],
        icon: FaIcon(FontAwesomeIcons.seedling, color: Color(0xFF375BA3)),
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
                      child: Text(tohumlamakelime(veri.kupeno[index]))),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Hayvanın Irkı",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(tohumlamakelime(veri.irk[index])),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Boğanın Irkı",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(tohumlamakelime(veri.bogairk[index])),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Boğanın Küpe Numarası",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(tohumlamakelime(veri.bogakupeno[index])),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tohumlama Yapan Veteriner",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(tohumlamakelime(veri.asilayankisi[index])),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tohumlama Başlangıç Tarihi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(veri.asilamatarihi[index]),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tohumlama Bitiş Tarihi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(veri.asilamatarihison[index]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  olusturhastalik({
    required DateTime focusedDay,
    required DateTime selectedDay,
    required int index,
    required TextEditingController kupeno,
    required TextEditingController hastalikismi,
    required TextEditingController hastalikbaslangic,
    required TextEditingController hastalikbitis,
  }) {
  return  GestureDetector(
      onTap: () {
        kupeno.text = veri.kupeno[index].toString();
        hastalikismi.text = veri.hastalikismi[index].toString();
        hastalikbaslangic.text = veri.asilamatarihi[index].toString();
        hastalikbitis.text = veri.asilamatarihison[index].toString();
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            builder: (context) {
              return Scaffold(
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16, top: 16),
                    child: Container(
                        padding: EdgeInsets.only(right: 35, left: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF375BA3),
                              Color(0xFF29E3D7)
                            ],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
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
                                fontSize: 15, color: Colors.white),
                          ),
                        ))),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: kupeno,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: hastalikismi,
                            decoration: InputDecoration(
                              labelText: "Hastalık ismi",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: hastalikbaslangic,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: focusedDay,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedDay, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectedDay = selectDay;
                                                    focusedDay = focusDay;
                                                    hastalikbaslangic.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Hastalık Başlangıç Tarihi",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: hastalikbitis,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: focusedDay,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedDay, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectedDay = selectDay;
                                                    focusedDay = focusDay;
                                                    hastalikbitis.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Hastalık Bitiş Tarihi",
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
      },
      child: Bilgiler(
        deger: false,
        resim: veri.resimyolu[index],
        icon: Icon(Icons.sick_rounded, color: Color(0xFF375BA3)),
        icerik: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Text(asilamakelime(veri.kupeno[index]))),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Hastalık İsmi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(asilamakelime(veri.hastalikismi[index]))),
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
                  Text(veri.asilamatarihi[index]),
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
                  Text(veri.asilamatarihison[index]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  olusturAsi(
      {required DateTime selectedday,
      required DateTime focusedday,
      required int index,
      required TextEditingController kupeno,
      required TextEditingController yapilanasi,
      required TextEditingController asilayankisi,
      required TextEditingController asilamabaslangic,
      required TextEditingController asilamabitis}) {
    return GestureDetector(
      onTap: () {
        kupeno.text = veri.kupeno[index].toString();
        yapilanasi.text = veri.asiismi[index].toString();
        asilayankisi.text = veri.asilayankisi[index].toString();
        asilamabaslangic.text = veri.asilamatarihi[index].toString();
        asilamabitis.text = veri.asilamatarihison[index].toString();

        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            builder: (context) {
              return Scaffold(
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16, top: 16),
                    child: Container(
                        padding: EdgeInsets.only(right: 35, left: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF375BA3),
                              Color(0xFF29E3D7)
                            ],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
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
                                fontSize: 15, color: Colors.white),
                          ),
                        ))),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: kupeno,
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: yapilanasi,
                            decoration: InputDecoration(
                              labelText: "Yapılan Aşı",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            controller: asilayankisi,
                            decoration: InputDecoration(
                              labelText: "Aşılayan Kişi",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.black,
                            inputFormatters: [maskFormatter],
                            controller: asilamabaslangic,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: focusedday,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedday, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectDay = selectDay;
                                                    selectDay = focusDay;
                                                    asilamabaslangic.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Aşılama Başlangıç Tarihi",
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            enabled: false,
                            inputFormatters: [maskFormatter],
                            cursorColor: Colors.black,
                            controller: asilamabitis,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF375BA3),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Scaffold(
                                              body: TableCalendar(
                                                 locale: 'tr_TR',
                                                focusedDay: selectedday,
                                                firstDay: DateTime(1990),
                                                lastDay: DateTime(2050),
                                                calendarFormat: format,
                                                onFormatChanged:
                                                    (CalendarFormat _format) {
                                                  setState(() {
                                                    format =
                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                  });
                                                },
                                                calendarStyle: CalendarStyle(
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 123, 203, 198),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    isTodayHighlighted: true,
                                                    selectedDecoration:
                                                        BoxDecoration(
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
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white)),
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekendStyle: TextStyle(
                                                      color: Colors.black),
                                                  weekdayStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                headerStyle: HeaderStyle(
                                                  formatButtonVisible: true,
                                                  titleCentered: true,
                                                  formatButtonShowsNext: false,
                                                  formatButtonDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF375BA3)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            34),
                                                  ),
                                                ),
                                                selectedDayPredicate:
                                                    (DateTime date) {
                                                  return isSameDay(
                                                      selectedday, date);
                                                },
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekVisible: true,
                                                onDaySelected:
                                                    (DateTime selectDay,
                                                        DateTime focusDay) {
                                                  setState(() {
                                                    selectDay = selectDay;
                                                    selectDay = focusDay;
                                                    asilamabitis.text =
                                                        dateFormat
                                                            .format(selectDay);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              labelText: "Aşılama Bitiş Tarihi",
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
      },
      child: Bilgiler(
        deger: false,
        resim: veri.resimyolu[index],
        icon: FaIcon(FontAwesomeIcons.syringe, color: Color(0xFF375BA3)),
        icerik: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Text(asilamakelime(veri.kupeno[index]))),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Yapılan Aşı",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(asilamakelime(veri.asiismi[index]))),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Aşılayan Kişi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(asilamakelime(veri.asilayankisi[index])),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Aşılama Başlangıç Tarihi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(veri.asilamatarihi[index]),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Aşılama Bitiş Tarihi",
                    style: TextStyle(
                        color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(veri.asilamatarihison[index]),
                ],
              ),
            ],
          ),
        ),
      ),
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
                              fontSize: 12,
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
