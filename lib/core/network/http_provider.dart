import 'package:http/http.dart' as http;

class HttpProvider {
  HttpProvider._();

  static final http.Client client = http.Client();
}
