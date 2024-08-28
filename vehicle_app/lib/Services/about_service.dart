import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vehicle_app/models/about.dart';


class AboutService {
  Future<AboutData> loadAboutData() async {
    final String response = await rootBundle.loadString('assets/about.json');
    final data = await json.decode(response);
    return AboutData.fromJson(data);
  }
}