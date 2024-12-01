import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions({
    required int amount,
    String? category,
    String difficulty = 'easy', // Default difficulty
    String type = 'multiple',
  }) async {
    final url = Uri.parse(
        'https://opentdb.com/api.php?amount=$amount' // API endpoint
        '${category != null ? '&category=$category' : ''}'
        '&difficulty=$difficulty'
        '&type=$type');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Question> questions = (data['results'] as List)
          .map((questionData) => Question.fromJson(questionData))
          .toList();
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

static Future<List<Map<String, String>>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://opentdb.com/api_category.php')); // API endpoint
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Map<String, String>> categories = (data['trivia_categories'] as List)
        .map((category) => {
              'id': category['id'].toString(), // Convert to string
              'name': category['name'].toString(),
            })
        .toList();
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}
}
