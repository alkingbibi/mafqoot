import 'package:flutter/material.dart';
import '../models/report.dart';
import 'package:share_plus/share_plus.dart';

class ReportDetailsPage extends StatelessWidget {
  final Report report;
  final String heroTag;

  ReportDetailsPage({
    required this.report,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل البلاغ"),
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
          child: Column(
            children: [
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: report.imageFile != null
                      ? Image.file(
                          report.imageFile!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          report.imageUrl ??
                              "https://via.placeholder.com/300",
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                report.title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Chip(
                label: Text(report.type),
                backgroundColor: report.type == "مفقود"
                    ? Colors.red.shade100
                    : Colors.green.shade100,
              ),
              SizedBox(height: 16),
              Text(
                report.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share(
                      "بلاغ: ${report.title}\n${report.description}");
                },
                icon: Icon(Icons.share),
                label: Text("مشاركة البلاغ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C63FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
