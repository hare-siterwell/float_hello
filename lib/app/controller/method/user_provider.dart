import 'package:get/get.dart';

class UserProvider extends GetConnect {
  Future<Response> postUser(String url, Map data,
          {Map<String, String>? headers}) =>
      post(url, data, headers: headers);
}
