import 'dart:convert';
import 'dart:io';
import 'package:bubble/api/api_saleroom_php.dart';
import 'package:bubble/model/sailroom.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../commons/baseAppbar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class MakeStore extends StatefulWidget {
  const MakeStore({super.key});

  @override
  State<MakeStore> createState() => _MakeStoreState();
}

class _MakeStoreState extends State<MakeStore> {
  // 폼에 부여할 수 있는 유니크한 글로벌 키를 생성한다.
  // MyCustomFormState의 키가 아닌 FormState의 키를 생성해야함을 유의
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  var subjectCtl = TextEditingController();
  var contentCtl = TextEditingController();
  var callnumberCtl = TextEditingController();
  var youtubeLinkCtl = TextEditingController();
  String callnumber = '';
  String youtubeLink = '';
  String subject = '';
  String content = '';
  String myEmail = 'test@email.com';
  String delyn = '0';

  checkSubject() async {
    try {
      var response = await http.post(
          Uri.parse(Api_saleroom_php.validate_subjects),
          body: {'subjects': subject});

      print('response.statusCode= ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        String jsonsDataString = response.body
            .toString(); // toString of Response's body is assigned to jsonDataString
        print('jsonsDataString=' + jsonsDataString);
        var resBody = await jsonDecode(response.body);
        if (resBody['existSubjects'] == true) {
          Fluttertoast.showToast(msg: '이미 존재하는 제목입니다');
        } else {
          print("saveinfo start");
          saveInfo();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  saveInfo() async {
    Sailroom sailmd = Sailroom(
        myEmail.toString().trim(),
        subject.toString().trim(),
        content.toString().trim(),
        callnumber.toString().trim(),
        youtubeLink.toString().trim(),
        delyn.toString().trim());

    try {
      print('sailmd.toJason=' + sailmd.toJason.toString());
      // var x = await json.encode({
      //   'room_root_id': sailmd.room_root_id.toString(),
      //   'subjects': sailmd.subjects.toString(),
      //   'content': sailmd.content.toString(),
      //   'callnumber': sailmd.callnumber.toString(),
      //   'youtubeLink': sailmd.youtubeLink.toString(),
      //   'delyn': sailmd.delyn.toString()
      // });
      // print('x= ' + x);
      var tempx = sailmd.toJason();
      print('tempx= ' + tempx.toString());
      var res =
          await http.post(Uri.parse(Api_saleroom_php.makeroom), body: tempx);
      if (res.statusCode == 200) {
        String jsonsDataString = res.body
            .toString(); // toString of Response's body is assigned to jsonDataString
        print('jsonsDataString2=' + jsonsDataString);

        var resok = await jsonDecode(res.body);
        if (resok['success'] == true) {
          Fluttertoast.showToast(msg: '완료~');
          setState(() {
            subjectCtl.clear();
            contentCtl.clear();
            callnumberCtl.clear();
            youtubeLinkCtl.clear();
            callnumber = '';
            youtubeLink = '';
            subject = '';
            content = '';
          });
        } else {
          Fluttertoast.showToast(msg: '이미 존재하는 제목 입니다.');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar:
          BaseAppBar(appBar: AppBar(), title: 'Make your Sale !', center: true),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: subjectCtl,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.brush),
                          // prefixIcon: Icon(Icons.phone),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          suffixIcon: Icon(Icons.brush),
                          hintText: ' 제목',
                          labelText: ' 제목',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        key: ValueKey(1),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 1) {
                            return '필수 : 제목을 입력해 주세요.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          subject = value!;
                        },
                        onChanged: (value) {
                          subject = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: contentCtl,
                        keyboardType: TextInputType.multiline,
                        minLines: 1, //Normal textInputField will be displayed
                        maxLines:
                            5, // when user presses enter it will adapt to it

                        decoration: const InputDecoration(
                          // icon: Icon(Icons.brush),
                          // prefixIcon: Icon(Icons.phone),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          suffixIcon: Icon(Icons.brush),
                          hintText: ' 내용',
                          labelText: ' 내용',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        key: ValueKey(2),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 1) {
                            return '필수 : 내용을 입력해주세요.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          content = value!;
                        },
                        onChanged: (value) {
                          content = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: callnumberCtl,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.brush),
                          // prefixIcon: Icon(Icons.phone),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          suffixIcon: Icon(Icons.brush),
                          hintText: ' 연락처',
                          labelText: ' 연락처',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        key: ValueKey(3),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 1) {
                            callnumber = '';
                            return null;
                          }
                          callnumber = value;
                          return null;
                        },
                        onSaved: (value) {
                          callnumber = value!;
                        },
                        onChanged: (value) {
                          callnumber = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: youtubeLinkCtl,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.brush),
                          // prefixIcon: Icon(Icons.phone),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          suffixIcon: Icon(Icons.brush),
                          hintText: ' your Youtube link',
                          labelText: ' your Youtube link',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        key: ValueKey(4),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 1) {
                            youtubeLink = '';
                            return null;
                          }
                          youtubeLink = value;
                          return null;
                        },
                        onSaved: (value) {
                          youtubeLink = value!;
                        },
                        onChanged: (value) {
                          youtubeLink = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            //open button ----------------
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  openImages();
                                },
                                child: Text("Open Images")),
                            Divider(),
                            Text("Picked Files:"),
                            Divider(),
                            imagefiles != null
                                ? Wrap(
                                    children: imagefiles!.map((imageone) {
                                      return Container(
                                          child: Card(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child:
                                              Image.file(File(imageone.path)),
                                        ),
                                      ));
                                    }).toList(),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _tryValidation();
                              if (_formKey.currentState!.validate()) {
                                checkSubject();
                              }
                            },
                            child: Text(
                              'Done !',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
