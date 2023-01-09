import 'dart:convert';

import 'package:bubble/model/sailroom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../commons/baseAppbar.dart';
import '../commons/bottmoNavigationaEx2.dart';
import 'package:http/http.dart' as http;

class TestNodeJs extends StatefulWidget {
  const TestNodeJs({super.key});

  @override
  State<TestNodeJs> createState() => _TestNodeJsState();
}

class _TestNodeJsState extends State<TestNodeJs> {
  //ex1)
  // Future fetch() async {
  //   var res = await http.get(
  //     Uri.parse('http://192.168.0.13:3000/'),
  //     headers: {"user-header": "1234"},
  //   );
  //   var body = await jsonDecode(res.body);
  //   print(body['key']);
  //   return body['key'];
  // }

  //ex2)
  // Uri.parse('http://192.168.100.148:3000/saleroom/'),
  Future<List<Sailroom>>? info;
  Future<List<Sailroom>> fetchInfo() async {
    var url = 'http://192.168.219.156:3000/saleroom/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //만약 서버가 ok응답을 반환하면, json을 파싱합니다
      print('응답했다');
      print(json.decode(response.body));
      List<dynamic> body = json.decode(response.body);
      List<Sailroom> sailroom =
          body.map((dynamic item) => Sailroom.fromJson(item)).toList();

      return sailroom;
    } else {
      //만약 응답이 ok가 아니면 에러를 던집니다.
      print('불러오는데 실패했습니다');
      throw Exception('불러오는데 실패했습니다');
    }
  }

  @override
  void initState() {
    super.initState();
    info = fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: 'nodeJsTest ', center: true),
      body: Container(
        child: FutureBuilder<List<Sailroom>>(
          // future: this.fetch(),
          future: info,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}에러!!");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: bottmoNavigationaEx2(0),
    );
  }

  Widget buildList(snapshot) {
    return SizedBox(
      // height: 150,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: ListView.builder(
            itemCount: snapshot.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 1),
                  height: 120,
                  child: Row(
                    children: [
                      SizedBox(height: 120, width: 20),
                      Container(
                        width: 250,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('id:' + snapshot[i].room_root_id.toString(),
                                style: TextStyle(fontSize: 15)),
                            Text('제목:' + snapshot[i].subjects.toString(),
                                style: TextStyle(fontSize: 15)),
                            Text('내용:' + snapshot[i].content.toString(),
                                style: TextStyle(fontSize: 15)),
                            Text('번호:' + snapshot[i].callnumber.toString(),
                                style: TextStyle(fontSize: 15)),
                            Text(
                                'youtubeLink:' +
                                    snapshot[i].youtubeLink.toString(),
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          print(snapshot[i].subjects.toString());
                          //sales chat room -> ms sql connection Expected
                          Navigator.pushNamed(context, '/saleroomChat');
                        },
                        style:
                            IconButton.styleFrom(foregroundColor: Colors.blue),
                        icon: Icon(Icons.chat, size: 18),
                        label: Text("[채팅입장]"),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
