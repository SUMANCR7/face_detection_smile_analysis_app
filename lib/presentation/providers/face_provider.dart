
import 'dart:io';

import 'package:face_detection_application/domains/entities/face_entity.dart';
import 'package:face_detection_application/domains/repositories/face_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FaceProvider extends ChangeNotifier{
  final FaceRepository repository;
  FaceProvider(this.repository);

  File? _selectedImage;
  List<FaceEntity> _faces = [];
  bool _isLoading = false;
  String? _errorMessage;

File? get selectedImage => _selectedImage;
List<FaceEntity> get faces => _faces;
bool get isLoading => _isLoading;
String? get errorMessage => _errorMessage;

int get totalFaces => _faces.length;
int get smilingFacesCount => _faces.where((f)=>f.isSmiling).length;

double get smilingPercentage{
  if(totalFaces == 0) return 0.0;
  return (smilingFacesCount / totalFaces) * 100;
}
final ImagePicker _picker = ImagePicker();

Future<void> pickAndAnalyzeImage() async {
  try{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
 if(image == null) return;

 _selectedImage = File(image.path);
 _isLoading = true;
 _errorMessage = null;
 notifyListeners();

 _faces = await repository.analyzeFaces(_selectedImage!);
  }catch(e){
    _errorMessage = 'Failed to image: ${e.toString()}';
  _faces = [];
  }finally{
    _isLoading = false;
    notifyListeners();
  }
}
void resetImage(){
  _selectedImage = null;
  _faces = [];
  _errorMessage = null;
  notifyListeners();
}
}