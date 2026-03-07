import 'package:flutter/material.dart';

class PinData {
  final int page;
  final double pdfX;    // PDF page coordinate (used for burning into PDF)
  final double pdfY;    // PDF page coordinate (used for burning into PDF)
  final double screenX; // Screen coordinate (used for overlay preview)
  final double screenY; // Screen coordinate (used for overlay preview)
  final Color color;

  const PinData({
    required this.page,
    required this.pdfX,
    required this.pdfY,
    required this.screenX,
    required this.screenY,
    required this.color,
  });
}
