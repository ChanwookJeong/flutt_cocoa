import 'dart:io';

class Api_saleroom_php {
  static const hostConnect = "http://localhost:3000/api_saleroom";
  static const hostConnectUser = "$hostConnect/room";

  static const makeroom = "$hostConnect/room/makeroom.php";
  static const validate_subjects = "$hostConnect/room/validate_subjects.php";
}
