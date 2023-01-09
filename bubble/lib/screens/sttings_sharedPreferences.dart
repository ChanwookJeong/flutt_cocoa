import 'package:bubble/commons/baseAppbar.dart';
import 'package:flutter/material.dart';
import '../commons/bottmoNavigationaEx2.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SttingsSharedpreference extends StatefulWidget {
  const SttingsSharedpreference({super.key});

  @override
  State<SttingsSharedpreference> createState() =>
      _SttingsSharedpreferenceState();
}

class _SttingsSharedpreferenceState extends State<SttingsSharedpreference> {
  bool toggle1 = false;
  late SharedPreferences _prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSet();
  }

  _loadSet() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 counter로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      toggle1 = (_prefs.getBool('setToggle1') ?? false);
    });
  }

  setToggle1(bool val) async {
    setState(() {
      toggle1 = (_prefs.getBool('setToggle1') ?? false);
      _prefs.setBool('setToggle1', val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          appBar: AppBar(), title: 'sharedprefer_sttings ', center: true),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('preference toggle test'),
              Switch(
                value: toggle1,
                onChanged: (bool value) {
                  setState(() {
                    toggle1 = value;
                    setToggle1(value);
                    print('Saved state is $toggle1');
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottmoNavigationaEx2(0),
    );
  }
}
