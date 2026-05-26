import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get razorpayKey => dotenv.env['RAZORPAY_KEY'] ?? '';

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  static String get baseUrlApi => dotenv.env['BASE_URL_Api'] ?? '';

  static String get imgCutoff => dotenv.env['IMG_URL_Cutoff'] ?? '';
}
