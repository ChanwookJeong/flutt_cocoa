import 'dart:io';

class Api_saleroom_php {
  static const hostConnect = "http://192.168.0.13:8012/api_saleroom";
  static const hostConnectUser = "$hostConnect/room";

  static const makeroom = "$hostConnect/room/makeroom.php";
  static const validate_subjects = "$hostConnect/room/validate_subjects.php";
}
