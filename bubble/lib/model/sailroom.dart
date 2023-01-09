import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Sailroom {
  String room_root_id;
  String subjects;
  String content;
  String callnumber;
  String youtubeLink;
  String delyn;

  Sailroom(this.room_root_id, this.subjects, this.content, this.callnumber,
      this.youtubeLink, this.delyn);

  Map<String, dynamic> toJason() => {
        'room_root_id': room_root_id.toString(),
        'subjects': subjects.toString(),
        'content': content.toString(),
        'callnumber': callnumber.toString(),
        'youtubeLink': youtubeLink.toString(),
        'delyn': delyn.toString()
      };

  factory Sailroom.fromJson(Map<String, dynamic> json) {
    return Sailroom(json['room_root_id'], json['subjects'], json['content'],
        json['callnumber'], json['youtubeLink'], json['delyn']);
  }
}
