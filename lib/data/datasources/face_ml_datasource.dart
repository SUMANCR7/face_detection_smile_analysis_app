
import 'dart:io';

import 'package:face_detection_application/domains/entities/face_entity.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceMlDatasource {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  Future<List<FaceEntity>> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final List<Face> faces = await _faceDetector.processImage(inputImage);

    List<FaceEntity> faceEntities = [];
    for(int i = 0; i < faces.length; i++){
      final face = faces[i];
      final double smileProb = face.smilingProbability ?? 0.0;

      final bool isSmiling = smileProb >= 0.7;

      faceEntities.add(
        FaceEntity(
            faceNumber: i + 1,
            isSmiling: isSmiling,
            smileProbability: smileProb,
            boundingBox: face.boundingBox),
      );
    }
    return faceEntities;
  }

  void dispose(){
    _faceDetector.close();
  }
}