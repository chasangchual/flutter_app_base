import 'package:logger/web.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Log {
  static final Logger _simpleLogger = Logger(printer: SimplePrinter(colors: false));
  static final Logger _prettyLogger = Logger(printer: PrettyPrinter(colors: false));
  static final TalkLogger _talker = TalkLogger(TalkerFlutter.init());

  static Logger get s => _simpleLogger;

  static Logger get p => _prettyLogger;

  static TalkLogger get t => _talker;
}

class TalkLogger {
  final Talker talker;

  TalkLogger(this.talker);

  void d(
    dynamic message, {
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    talker.debug(message, exception, stackTrace);
  }

  void i(
    dynamic message, {
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    talker.info(message, exception, stackTrace);
  }

  void w(
    dynamic message, {
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    talker.warning(message, exception, stackTrace);
  }

  void e(
    dynamic message, {
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    talker.error(message, exception, stackTrace);
  }

  /// Log a message at level [Level.fatal].
  void f(
    dynamic message, {
    DateTime? time,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    talker.critical(message, exception, stackTrace);
  }
}
