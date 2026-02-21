import 'dart:io';

class Report {
  final String title;
  final String type; // "مفقود" أو "موجود"
  final String description;
  final String? imageUrl;
  final File? imageFile;

  Report({
    required this.title,
    required this.type,
    required this.description,
    this.imageUrl,
    this.imageFile,
  });
}
