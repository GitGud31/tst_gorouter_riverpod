import 'package:logger/logger.dart';

class L {
  static void log(dynamic msg) {
    final _l = Logger();
    _l.i(msg);
  }
}
