import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> getPrediction(List<double> features) async {
  final url = Uri.parse('http://10.0.2.2:5001/predict');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'features': features}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prediction = data['prediction'][0].toString();
      return prediction;
    } else {
      print("❌ Server error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Exception: $e");
    return null;
  }
}
