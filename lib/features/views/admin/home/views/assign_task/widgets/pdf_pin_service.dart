import 'dart:io';
import 'package:charteur/features/views/admin/home/views/assign_task/models/pin_data.dart';
import 'package:file_save_directory/file_save_directory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_android/open_file_android.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';


/// Handles all PDF loading, pin rendering, and saving.
/// Has no Flutter widget dependencies — fully testable in isolation.
class PdfPinService {
  /// Loads raw bytes from a local file path.
  static Future<Uint8List> loadBytes(String path) =>
      File(path).readAsBytes();

  /// Downloads a PDF from [url] to a temp file and returns its local path.
  /// Subsequent calls with the same URL reuse the cached temp file.
  static Future<String> loadFromUrl(String url) async {
    final dir = await getTemporaryDirectory();
    final fileName = Uri.parse(url).pathSegments.last.isNotEmpty
        ? Uri.parse(url).pathSegments.last
        : 'remote_${url.hashCode}.pdf';
    final file = File('${dir.path}/$fileName');
    if (!file.existsSync()) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF (${response.statusCode})');
      }
      await file.writeAsBytes(response.bodyBytes);
    }
    return file.path;
  }

  /// Burns [pins] into [sourceBytes] and saves the result to Downloads.
  /// Also writes a private copy, opens the file, and returns annotated bytes + fileName.
  static Future<({Uint8List bytes, String fileName})> savePdf({
    required Uint8List sourceBytes,
    required List<PinData> pins,
    required String originalPath,
  }) async {
    final PdfDocument document = PdfDocument(inputBytes: sourceBytes);
    for (final pin in pins) {
      _drawPin(
        page: document.pages[pin.page - 1],
        x: pin.pdfX,
        y: pin.pdfY,
        color: pin.color,
      );
    }
    final List<int> savedBytes = document.saveSync();
    document.dispose();
    final Uint8List annotated = Uint8List.fromList(savedBytes);

    final baseName = originalPath.split('/').last.replaceAll('.pdf', '');
    final ts = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${baseName}_pinned_$ts.pdf';

    await FileSaveDirectory.instance.saveFile(
      fileName: fileName,
      fileBytes: annotated,
      location: SaveLocation.downloads,
      openAfterSave: false,
    );

    final dir = await getApplicationDocumentsDirectory();
    final privatePath = '${dir.path}/$fileName';
    await File(privatePath).writeAsBytes(annotated);
    await OpenFileAndroid().open(privatePath);

    return (bytes: annotated, fileName: fileName);
  }

  /// Burns [pins] into [sourceBytes], saves to app Documents, and returns the
  /// local file path — WITHOUT opening the file or saving to Downloads.
  ///
  /// Use this when the caller owns the result (e.g. HomeController in TaskScreen).
  static Future<String> savePdfSilently({
    required Uint8List sourceBytes,
    required List<PinData> pins,
    required String originalPath,
  }) async {
    final PdfDocument document = PdfDocument(inputBytes: sourceBytes);
    for (final pin in pins) {
      _drawPin(
        page: document.pages[pin.page - 1],
        x: pin.pdfX,
        y: pin.pdfY,
        color: pin.color,
      );
    }
    final List<int> savedBytes = document.saveSync();
    document.dispose();
    final Uint8List annotated = Uint8List.fromList(savedBytes);

    final baseName = originalPath.split('/').last.replaceAll('.pdf', '');
    final ts = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${baseName}_pinned_$ts.pdf';

    final dir = await getApplicationDocumentsDirectory();
    final privatePath = '${dir.path}/$fileName';
    await File(privatePath).writeAsBytes(annotated);
    return privatePath;
  }

  /// Returns all PDF files in the app documents directory, newest first.
  static Future<List<File>> getSavedFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.pdf'))
        .toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
  }

  // ── Private drawing helper ──────────────────────────────────────────────────

  static void _drawPin({
    required PdfPage page,
    required double x,
    required double y,
    required Color color,
    double size = 30,
  }) {
    final g = page.graphics;
    final pinColor = PdfColor(color.red, color.green, color.blue);
    final darkColor = PdfColor(
      (color.red * 0.7).toInt(),
      (color.green * 0.7).toInt(),
      (color.blue * 0.7).toInt(),
    );
    final white = PdfColor(255, 255, 255);

    final headRadius = size * 0.38;
    final headCX = x;
    final headCY = y - size * 0.55;

    g.drawEllipse(
      Rect.fromCircle(center: Offset(headCX, headCY), radius: headRadius),
      pen: PdfPen(darkColor, width: 1.2),
      brush: PdfSolidBrush(pinColor),
    );
    g.drawEllipse(
      Rect.fromCircle(
        center: Offset(headCX - headRadius * 0.25, headCY - headRadius * 0.25),
        radius: headRadius * 0.3,
      ),
      brush: PdfSolidBrush(white),
    );

    final tail = PdfPath();
    tail.addPolygon([
      Offset(headCX - headRadius * 0.55, headCY + headRadius * 0.35),
      Offset(headCX + headRadius * 0.55, headCY + headRadius * 0.35),
      Offset(x, y),
    ]);
    g.drawPath(tail,
        pen: PdfPen(darkColor, width: 1.2), brush: PdfSolidBrush(pinColor));
    g.drawEllipse(
      Rect.fromCircle(center: Offset(x, y), radius: 2),
      brush: PdfSolidBrush(darkColor),
    );
  }
}
