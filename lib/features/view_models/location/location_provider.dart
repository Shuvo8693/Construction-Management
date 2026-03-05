import 'package:charteur/sk_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final suggestions = <Map<String, String>>[].obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;

  final Dio _dio = Dio();
  Timer? _debounce;
  CancelToken? _cancelToken;

  // ── Step 1: Autocomplete → returns placeId ────────────────────────────────
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
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
        '?input=$encodedInput'
        '&key=${SKey.googleApiKey}'
        '&language=en';

    try {
      final response = await _dio.get(url, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final List predictions = response.data['predictions'] ?? [];

        suggestions.assignAll(
          predictions.map<Map<String, String>>((item) {
            final formatting =
            item['structured_formatting'] as Map<String, dynamic>?;
            return {
              'title': formatting?['main_text']?.toString() ?? '',
              'subtitle': formatting?['secondary_text']?.toString() ?? '',
              'description': item['description']?.toString() ?? '',
              'placeId': item['place_id']?.toString() ?? '', // ← store placeId
              'lat': '',   // filled lazily in fetchLatLng()
              'lng': '',
            };
          }).toList(),
        );
      }
    } on DioException catch (e) {
      if (e.type != DioExceptionType.cancel) {
        suggestions.clear();
        debugPrint('Autocomplete error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Step 2: Place Details → returns lat/lng for a chosen suggestion ───────
  Future<({double lat, double lng})?> fetchLatLng(String placeId) async {
    if (placeId.isEmpty) return null;

    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId'
        '&fields=geometry'           // only fetch what we need (saves quota)
        '&key=${SKey.googleApiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final location =
        response.data['result']?['geometry']?['location'];
        if (location != null) {
          final lat = (location['lat'] as num).toDouble();
          final lng = (location['lng'] as num).toDouble();

          // Optionally cache back into the suggestions list
          final idx = suggestions.indexWhere((s) => s['placeId'] == placeId);
          if (idx != -1) {
            final updated = Map<String, String>.from(suggestions[idx]);
            updated['lat'] = lat.toString();
            updated['lng'] = lng.toString();
            suggestions[idx] = updated;
          }

          return (lat: lat, lng: lng);
        }
      }
    } on DioException catch (e) {
      debugPrint('Place details error: $e');
    }

    return null;
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
    super.onClose();
  }
}