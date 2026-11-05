import 'package:face_detection_application/data/datasources/face_ml_datasource.dart';
import 'package:face_detection_application/domains/repositories/face_repository_impl.dart';
import 'package:face_detection_application/presentation/providers/face_provider.dart';
import 'package:face_detection_application/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final datasource = FaceMlDatasource();
    final repository = FaceRepositoryImpl(datasource);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FaceProvider(repository)),

      ],
      child: MaterialApp(
        title: 'Face Detection & Smile Analysis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}


