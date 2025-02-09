import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import "package:flutter/services.dart";
import 'package:tflite_flutter/tflite_flutter.dart' as tf;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class Classifier {
  static const int imageSize = 28; // MNIST image size
  static const int strokeWidth = 2; // Stroke width for drawing
  static const String modelPath =
      "assets/model.tflite"; // Path to the TFLite model

  tf.Interpreter? _interpreter; // Cache the interpreter

  Classifier() {
    _loadModel();
  }

  // Load the TFLite model
  Future<void> _loadModel() async {
    print(await rootBundle.load("assets/model.tflite"));
    print("\n\n\n\n\n\n\n\n");
    try {
      _interpreter = await tf.Interpreter.fromAsset(modelPath);
    } catch (e) {
      if (kDebugMode) {
        print("Error loading model: $e");
      }
    }
  }

  // Classify a drawing represented as a list of points
  Future<int> classifyDrawing(List<Offset?> points) async {
    if (points.isEmpty) {
      throw ArgumentError("Points list cannot be empty.");
    }

    // Convert points to a 28x28 grayscale image
    final picture = _toPicture(points);
    final image = await picture.toImage(imageSize, imageSize);
    final ByteData? imgBytes =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (imgBytes == null) throw Exception("Failed to get image bytes");

    // Preprocess and predict
    return _getPrediction(imgBytes.buffer.asUint8List());
  }

  List<Offset> _normalizePoints(List<Offset> points) {
    // Find the bounds of the drawing
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final point in points) {
      minX = math.min(minX, point.dx);
      minY = math.min(minY, point.dy);
      maxX = math.max(maxX, point.dx);
      maxY = math.max(maxY, point.dy);
    }

    // Calculate scale factors to fit in 20x20 area (leaving margin)
    final width = maxX - minX;
    final height = maxY - minY;
    final scale = math.min(20 / width, 20 / height);

    // Center the drawing
    final centerX = (maxX + minX) / 2;
    final centerY = (maxY + minY) / 2;

    // Normalize and center all points
    return points.map((point) {
      final normalizedX = ((point.dx - centerX) * scale + imageSize / 2);
      final normalizedY = ((point.dy - centerY) * scale + imageSize / 2);
      return Offset(normalizedX, normalizedY);
    }).toList();
  }

  // Convert a list of points to a Picture
  ui.Picture _toPicture(List<Offset?> points) {
    // Define paint for drawing
    final whitePaint = ui.Paint()
      ..strokeCap = ui.StrokeCap.round
      ..color = const ui.Color(0xFFFFFFFF) // White color
      ..strokeWidth = strokeWidth.toDouble();

    final bgPaint = ui.Paint()
      ..color = const ui.Color(0xFF000000); // Black color

    // Define canvas boundaries
    final canvasCullRect = ui.Rect.fromPoints(
      const ui.Offset(0, 0),
      ui.Offset(imageSize.toDouble(), imageSize.toDouble()),
    );

    // Initialize PictureRecorder and Canvas
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder, canvasCullRect);

    // Scale the canvas to fit the drawing
    canvas.scale(imageSize / 372);

    // Draw background
    canvas.drawRect(canvasCullRect, bgPaint);

    // Draw lines between points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, whitePaint);
      }
    }

    // End recording and return the Picture
    return recorder.endRecording();
  }

  // Preprocess image and run inference
  Future<int> _getPrediction(Uint8List imgAsList) async {
    if (_interpreter == null) {
      throw StateError("Model not loaded.");
    }

    // Convert RGBA to grayscale and normalize
    final List<double> normalizedPixels = List.filled(imageSize * imageSize, 0);
    int index = 0;
    for (int i = 0; i < imgAsList.length; i += 4) {
      final r = imgAsList[i];
      final g = imgAsList[i + 1];
      final b = imgAsList[i + 2];
      normalizedPixels[index] = ((r + g + b) / 3.0) / 255.0;
      index++;
    }

    // Reshape input for the model
    final input = normalizedPixels.reshape([1, imageSize, imageSize, 1]);
    final output = List.filled(1 * 10, 0).reshape([1, 10]);

    // Run inference
    final startTime = DateTime.now().millisecondsSinceEpoch;
    try {
      _interpreter!.run(input, output);
    } catch (e) {
      if (kDebugMode) {
        print('Error running model: $e');
      }
      throw Exception("Failed to run inference.");
    }

    if (kDebugMode) {
      final endTime = DateTime.now().millisecondsSinceEpoch;
      print("Inference took ${endTime - startTime} ms");
    }

    // Find the predicted digit
    double highestProb = 0;
    int digitPred = 0;
    for (int i = 0; i < output[0].length; i++) {
      if (output[0][i] > highestProb) {
        highestProb = output[0][i];
        digitPred = i;
      }
    }

    return digitPred;
  }
}
