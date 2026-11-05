import 'package:face_detection_application/presentation/providers/face_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection & Smile Analysis'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: provider.isLoading
                    ? null
                    : () => provider.pickAndAnalyzeImage(),
                icon: Icon(
                  provider.selectedImage == null ? Icons.image : Icons.refresh,
                ),
                label: Text(
                  provider.selectedImage == null
                      ? 'Upload Image from Gallery'
                      : 'Upload Another Image',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),

              if (provider.selectedImage != null)
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      provider.selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (provider.isLoading)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Total Faces',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${provider.totalFaces}',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text(
                              'Smiling %',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${provider.smilingPercentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              const Text('Individual Face Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),

              provider.faces.isEmpty
              ? const Text('No faces detected or image not uploaded yet.',
              style: TextStyle(color: Colors.grey),)
                  : ListView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.faces.length,
                  itemBuilder: (context, index){
                  final face = provider.faces[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: face.isSmiling? Colors.green : Colors.orange,
                        child: Text('F${face.faceNumber}',
                        style: const TextStyle(color: Colors.white),),),
                      title: Text('Face ${face.faceNumber}'),
                      subtitle: Text('Probability: ${(face.smileProbability * 100).toStringAsFixed(1)}%'),
                      trailing: Chip(
                          label: Text(face.isSmiling
                          ? 'Smiling' : 'Not Smiling',
                          style: const TextStyle(color: Colors.white),),
                      backgroundColor: face.isSmiling ? Colors.green : Colors.redAccent,
                      ),
                    ),
                  );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
