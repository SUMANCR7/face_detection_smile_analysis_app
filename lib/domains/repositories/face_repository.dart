
import 'dart:io';

import 'package:face_detection_application/domains/entities/face_entity.dart';

abstract class FaceRepository {
  Future<List<FaceEntity>> analyzeFaces(File imageFile);
}
