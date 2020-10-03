import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/services.dart';
// Copyright 2018 The Chromium Authors. All rights reserved.
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CardReader
{

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

getCard() async
{
  print("Testing GET Card");
  File f = await getImageFileFromAssets('hofcard2.jpg');
  FirebaseVisionImage visionImage = await FirebaseVisionImage.fromFile(f);
  TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  VisionText visionText = await textRecognizer.processImage(visionImage);
  //print(visionText.text);
  String text = visionText.text;
  print(text);
  for (TextBlock block in visionText.blocks) {
    final Rect boundingBox = block.boundingBox;
    final List<Offset> cornerPoints = block.cornerPoints;
    final String text = block.text;
    final List<RecognizedLanguage> languages = block.recognizedLanguages;

    for (TextLine line in block.lines) {
      // Same getters as TextBlock
      for (TextElement element in line.elements) {
        // Same getters as TextBlock
        print(element.text);
      }
    }
  }
}

}

/**
class ScannerUtils {
  ScannerUtils._();

  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
          (List<CameraDescription> cameras) => cameras.firstWhere(
            (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  static Future<dynamic> detect({
    @required CameraImage image,
    @required Future<dynamic> Function(FirebaseVisionImage image) detectInImage,
    @required int imageRotation,
  }) async {
    return detectInImage(
      FirebaseVisionImage.fromBytes(
        _concatenatePlanes(image.planes),
        _buildMetaData(image, _rotationIntToImageRotation(imageRotation)),
      ),
    );
  }

  static Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static FirebaseVisionImageMetadata _buildMetaData(
      CameraImage image,
      ImageRotation rotation,
      ) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
            (Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  static ImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }
}
    **/
