import 'dart:convert';
import 'package:flutter/services.dart';

class BibleService {
  static Future<Map<String, dynamic>> carregarBiblia(String idioma) async {
    String path;

    if (idioma == "pt") {
      path = "assets/bible/bible_pt.json";
    } else {
      path = "assets/bible/bible_en.json";
    }

    final jsonString = await rootBundle.loadString(path);
    return jsonDecode(jsonString);
  }
}
