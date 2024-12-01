import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> { 
  int _numberOfQuestions = 10;
  String? _selectedCategory; 
  String _selectedDifficulty = 'easy';  
  String _selectedType = 'multiple';
  List<Map<String, String>> _categories = [];

  @override
  void initState() { 
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async { // Fetches the categories from the API
    final categories = await ApiService.fetchCategories();
    setState(() {
      _categories = categories;
      _selectedCategory = categories.first['id'];
    });
  }

  void _startQuiz() { // Navigates to the QuizScreen with the selected quiz options`
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          numberOfQuestions: _numberOfQuestions,
          category: _selectedCategory,
          difficulty: _selectedDifficulty,
          type: _selectedType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Setup')),
      body: _categories.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator while fetching categories
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Select Number of Questions:'),
                  DropdownButton<int>(
                    value: _numberOfQuestions,
                    items: [5, 10, 15]
                        .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                        .toList(),
                    onChanged: (value) => setState(() {
                      _numberOfQuestions = value!;
                    }),
                  ),
                  SizedBox(height: 16),
                  Text('Select Category:'),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    items: _categories // Use the fetched categories to populate the dropdown
                        .map((e) => DropdownMenuItem(
                              value: e['id'],
                              child: Text(e['name']!),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      _selectedCategory = value;
                    }),
                  ),
                  SizedBox(height: 16),
                  Text('Select Difficulty:'),
                  DropdownButton<String>(
                    value: _selectedDifficulty,
                    items: ['easy', 'medium', 'hard'] // Add the difficulty levels
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      _selectedDifficulty = value!;
                    }),
                  ),
                  SizedBox(height: 16), 
                  Text('Select Question Type:'), 
                  DropdownButton<String>(
                    value: _selectedType, 
                    items: ['multiple', 'boolean'] // Add the question types
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      _selectedType = value!;
                    }),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _startQuiz,
                    child: Text('Start Quiz'),
                  ),
                ],
              ),
            ),
    );
  }
}
