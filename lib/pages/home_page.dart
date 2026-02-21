import 'package:flutter/material.dart';
import '../models/report.dart';
import 'add_report_page.dart';
import 'report_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Report> reports = [];

  void _navigateToAddReport() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddReportPage()),
    );

    if (result != null && result is Report) {
      setState(() {
        reports.add(result);
      });
    }
  }

  Widget buildCard(Report report, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ReportDetailsPage(
                      report: report,
                      heroTag: 'report_$index',
                    )));
      },
      child: Hero(
        tag: 'report_$index',
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 6,
          shadowColor: Colors.grey.withOpacity(0.3),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: report.imageFile != null
                      ? Image.file(
                          report.imageFile!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          report.imageUrl ??
                              'https://via.placeholder.com/80',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Chip(
                        label: Text(report.type),
                        backgroundColor: report.type == 'مفقود'
                            ? Colors.red.shade100
                            : Colors.green.shade100,
                      ),
                      SizedBox(height: 4),
                      Text(
                        report.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مفقوداتي'),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: reports.isEmpty
          ? Center(
              child: Text(
                'لا توجد بلاغات بعد',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return buildCard(reports[index], index);
              },
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF8E7FFF)]),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10)],
        ),
        child: FloatingActionButton(
          onPressed: _navigateToAddReport,
          child: Icon(Icons.add, size: 30),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
