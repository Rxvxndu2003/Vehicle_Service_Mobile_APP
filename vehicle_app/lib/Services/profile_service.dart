import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/models/profile_details.dart';
import '../models/privacy_policy.dart';

class ProfileService {
  final String url = 'https://rxvxndu2003.github.io/privacy/privacy.json'; // Replace with your jsonbin.io URL

  Future<Profile> fetchPrivacyPolicy() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Fetched JSON data: $data'); // Debugging line
      return Profile.fromJson(data);
    } else {
      throw Exception('Failed to load privacy policy');
    }
  }
}