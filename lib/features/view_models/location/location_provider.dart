
import 'package:charteur/sk_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LocationProvider extends ChangeNotifier {
  List<Map<String, String>> suggestionsLocation = [];
  final Dio _dio = Dio();
  Timer? _debounce;
  CancelToken? _cancelToken;

  Future<void> fetchSuggestions(String input) async {
    // Cancel previous request
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    // Debounce
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await _performSearch(input, _cancelToken!);
    });
  }

  Future<void> _performSearch(String input, CancelToken cancelToken) async {
    final encodedInput = Uri.encodeComponent(input);
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedInput&key=${SKey.googleApiKey}&language=en';

    try {
      final response = await _dio.get(url, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final jsonData = response.data;
        final List predictions = jsonData['predictions'] ?? [];

        suggestionsLocation = predictions.map<Map<String, String>>((item) {
          final formatting = item['structured_formatting'] as Map<String, dynamic>?;
          return {
            'title': formatting?['main_text']?.toString() ?? '',
            'subtitle': formatting?['secondary_text']?.toString() ?? '',
            'description': item['description']?.toString() ?? '',
          };
        }).toList();
        notifyListeners();
      }
    } on DioException catch (e) {
      if (e.type != DioExceptionType.cancel) {
        suggestionsLocation.clear();
        debugPrint('Error fetching suggestions: $e');
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    _dio.close();
    super.dispose();
  }
}