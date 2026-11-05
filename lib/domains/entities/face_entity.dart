class FaceEntity {
  final int faceNumber;
  final bool isSmiling;
  final double smileProbability;
  final dynamic boundingBox;

FaceEntity({
    required this.faceNumber,
  required this.isSmiling,
  required this.smileProbability,
  required this.boundingBox,
});
}