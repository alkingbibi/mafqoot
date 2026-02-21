import 'package:flutter/material.dart';
import '../models/report.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddReportPage extends StatefulWidget {
  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String type = 'مفقود';
  File? _pickedImage;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: source, imageQuality: 70);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  void saveReport() {
    if (_formKey.currentState!.validate()) {
      final report = Report(
        title: title,
        type: type,
        description: description,
        imageFile: _pickedImage,
      );

      Navigator.pop(context, report);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة بلاغ"),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "العنوان",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => title = val,
                  validator: (val) =>
                      val!.isEmpty ? "الرجاء إدخال العنوان" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "الوصف",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => description = val,
                  validator: (val) =>
                      val!.isEmpty ? "الرجاء إدخال الوصف" : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: type,
                  items: ["مفقود", "موجود"]
                      .map((t) =>
                          DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) => setState(() => type = val!),
                  decoration: InputDecoration(
                    labelText: "نوع البلاغ",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.camera),
                        icon: Icon(Icons.camera_alt),
                        label: Text("كاميرا"),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.gallery),
                        icon: Icon(Icons.photo),
                        label: Text("معرض"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                if (_pickedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _pickedImage!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: saveReport,
                  child: Text("حفظ البلاغ"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
