import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عن التطبيق"),
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 30),
            Icon(
              Icons.search_rounded,
              size: 80,
              color: Color(0xFF6C63FF),
            ),
            SizedBox(height: 20),
            Text(
              "مفقوداتي",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "تطبيق فاخر لإدارة البلاغات الخاصة بالأشياء المفقودة والموجودة بطريقة حديثة وأنيقة.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Text(
              "تطوير وحقوق النشر © النبراس البعداني",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
