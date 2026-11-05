
import 'dart:io';

import 'package:face_detection_application/data/datasources/face_ml_datasource.dart';
import 'package:face_detection_application/domains/entities/face_entity.dart';
import 'package:face_detection_application/domains/repositories/face_repository.dart';

class FaceRepositoryImpl implements FaceRepository{
  final FaceMlDatasource datasource;

  FaceRepositoryImpl(this.datasource);

  @override
  Future<List<FaceEntity>> analyzeFaces(File imageFile) async {
    return await datasource.detectFaces(imageFile);
  }
}