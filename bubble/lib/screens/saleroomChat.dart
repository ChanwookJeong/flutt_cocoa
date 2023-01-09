import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';
import 'dart:async';

class SaleroomChat extends StatefulWidget {
  const SaleroomChat({super.key});

  @override
  State<SaleroomChat> createState() => _SaleroomChatState();
}

class _SaleroomChatState extends State<SaleroomChat> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  String readData = '';

  void _sendMessage() async {
    _controller.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> connect(BuildContext ctx) async {
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("LOADING"),
            content: CircularProgressIndicator(),
          );
        },
      );
      await SqlConn.connect(
          ip: "192.168.219.156",
          port: "1434",
          databaseName: "testChat",
          username: "sa",
          password: "handb");
      debugPrint("Connected!");
      read('select * from chatroom where masterId="test@email.com";');
    } catch (e) {
      debugPrint('mssql 연결실패이유: ' + e.toString());
    } finally {
      // Navigator.pop(context);
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
    readData = res.toString();
  }

  Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }

  Widget chatmessage() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(labelText: 'send a messsage...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    connect(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SaleroomChat'),
      ),
      body: Column(
        children: [
          Text(readData),
          chatmessage(),
        ],
      ),
    );
  }
}
