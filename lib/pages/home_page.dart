import 'package:flutter/material.dart';
import '../models/report.dart';
import 'report_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Report> reports = [
    Report(title: "محفظة ضاعت", type: "مفقود", description: "محفظتي لونها أسود", imageUrl: "https://via.placeholder.com/150"),
    Report(title: "هاتف وجدت", type: "موجود", description: "هاتف iPhone 13", imageUrl: "https://via.placeholder.com/150"),
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCard(Report report, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => ReportDetailsPage(report: report, heroTag: 'reportHero$index'),
        ));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.4),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: report.type == "مفقود"
                  ? [Colors.red.shade400, Colors.red.shade200]
                  : [Colors.green.shade400, Colors.green.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Hero(
              tag: 'reportHero$index',
              child: CircleAvatar(
                radius: 28,
                backgroundImage: report.imageFile != null
                    ? FileImage(report.imageFile!) as ImageProvider
                    : NetworkImage(report.imageUrl!),
              ),
            ),
            title: Text(report.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            subtitle: Text(report.type, style: TextStyle(color: Colors.white70)),
            trailing: Icon(
              report.type == "مفقود" ? Icons.warning_amber_rounded : Icons.check_circle,
              color: Colors.white,
              size: 28,
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
        title: Text("مفقوداتي"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
        backgroundColor: Color(0xFF6C63FF),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0E0FF), Color(0xFFF5F5FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return buildCard(reports[index], index);
          },
        ),
      ),
    );
  }
}
