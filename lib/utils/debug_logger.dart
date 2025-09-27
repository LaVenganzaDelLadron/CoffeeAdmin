import 'package:logger/logger.dart';

class DebugLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // show stack trace depth
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void info(String message) => _logger.i(message);
  static void debug(String message) => _logger.d(message);
  static void warn(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
