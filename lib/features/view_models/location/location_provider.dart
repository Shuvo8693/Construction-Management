import 'package:charteur/sk_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class LocationController extends GetxController {
  // ── Make it observable ────────────────────────────────
  final suggestions   = <Map<String, String>>[].obs;
  final searchQuery   = ''.obs;
  final isLoading     = false.obs;

  final Dio _dio = Dio();
  Timer? _debounce;
  CancelToken? _cancelToken;

  Future<void> fetchSuggestions(String input) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await _performSearch(input, _cancelToken!);
    });
  }

  Future<void> _performSearch(String input, CancelToken cancelToken) async {
    isLoading.value = true;

    final encodedInput = Uri.encodeComponent(input);
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedInput&key=${SKey.googleApiKey}&language=en';

    try {
      final response = await _dio.get(url, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final List predictions = response.data['predictions'] ?? [];

        suggestions.assignAll(                          // ← assignAll instead of =
          predictions.map<Map<String, String>>((item) {
            final formatting = item['structured_formatting'] as Map<String, dynamic>?;
            return {
              'title':       formatting?['main_text']?.toString() ?? '',
              'subtitle':    formatting?['secondary_text']?.toString() ?? '',
              'description': item['description']?.toString() ?? '',
            };
          }).toList(),
        );
      }
    } on DioException catch (e) {
      if (e.type != DioExceptionType.cancel) {
        suggestions.clear();
        debugPrint('Error fetching suggestions: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void clearSuggestions() {
    suggestions.clear();
    searchQuery.value = '';
  }

  @override
  void onClose() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    _dio.close();
    super.onClose();                                    // ← onClose not dispose
  }
}