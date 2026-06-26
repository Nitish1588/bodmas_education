import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import 'carousel_model.dart';

class CarouselService {
  static Future<List<CarouselModel>> fetchBanners() async {
    final response = await http.get(
      Uri.parse("${Env.baseUrlApi}/hero-banners"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      final banners = data.map((e) => CarouselModel.fromJson(e)).toList();

      // Descending Order (Latest First)
      banners.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return banners;
    }

    throw Exception("Failed to load banners");
  }
}
