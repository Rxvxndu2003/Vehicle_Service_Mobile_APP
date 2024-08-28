import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/privacy_policy.dart';

class PrivacyService {
  final String url = 'https://rxvxndu2003.github.io/privacy/privacy.json'; // Replace with your jsonbin.io URL

  Future<PrivacyPolicy> fetchPrivacyPolicy() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Fetched JSON data: $data'); // Debugging line
      return PrivacyPolicy.fromJson(data);
    } else {
      throw Exception('Failed to load privacy policy');
    }
  }
}