import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume PDF Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = await generateResume();
            final directory = await getTemporaryDirectory();
            final path = '${directory.path}/resume.pdf';
            final file = File(path);
            await file.writeAsBytes(pdf);
            await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
          },
          child: Text('View Resume PDF'),
        ),
      ),
    );
  }

  Future<Uint8List> generateResume() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('ABHIJITH SAJJU', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('abhijithsajju@gmail.com   |   +91 9747844196   |   Alappuzha, Kerala, India'),
              pw.SizedBox(height: 5),

              pw.UrlLink(
                child: pw.Text('LinkedIn: linkedin.com/in/abhijith-sajju', style: pw.TextStyle(color: PdfColors.blue)),
                destination: 'https://www.linkedin.com/in/abhijith-sajju',
              ),
              pw.SizedBox(height: 5),

              pw.UrlLink(
                child: pw.Text('GitHub: github.com/Abhijith06546', style: pw.TextStyle(color: PdfColors.blue)),
                destination: 'https://github.com/Abhijith06546',
              ),
              pw.SizedBox(height: 20),
              pw.Text('PROFESSIONAL SUMMARY', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),

              pw.Text(
                  'Certified Flutter Developer with a proven track record in building and deploying high-performance mobile and web applications. '
                      'Expertise in Flutter, Firebase, REST API integration, and Dart, with hands-on experience in managing state using Riverpod. '
                      'Crafted and optimized user interfaces that enhance user experience. Consistently implemented secure, scalable solutions in Firebase '
                      'to handle complex data flows. Recognized for a proactive approach to problem-solving and dedication to continuous improvement in both '
                      'technical and team environments.'),
              pw.SizedBox(height: 20),
              pw.Text('PROJECTS', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),

              _buildProjectSection(
                  'Comprehensive Educational Platform',
                  'GitHub: github.com/Abhijith06546/Scope_India_Project',
                  'Contributed to a comprehensive educational platform aimed at enhancing student learning experiences. The project includes:\n'
                      '- Course Management: Engineered features for course enrollment, management, and tracking progress for students.\n'
                      '- User Authentication: Implemented Firebase Authentication for secure access to the platform.\n'
                      '- Data Storage: Used Firebase Realtime Database for storing and retrieving course details, user information, and progress data.\n'
                      '- UI/UX Enhancements: Focused on delivering a responsive and user-friendly interface with modern design principles.\n'
                      'Technologies used: Flutter, Dart, Firebase Realtime Database, Firebase Authentication'),
              pw.SizedBox(height: 5),

              _buildProjectSection(
                  'Expense Tracker',
                  'GitHub: github.com/Abhijith06546/Expense_Tracker',
                  'Engineered an expense tracking application using Flutter to help users manage personal finances. The project includes:\n'
                      '- Core features for adding, viewing, and deleting expenses, organized by categories (e.g., food, transportation, and utilities).\n'
                      '- Data visualization charts to track and analyze spending patterns over time.\n'
                      '- Firebase Authentication for secure user sign-up, login, and profile management.\n'
                      '- Dark and light theme support to enhance accessibility and user experience.\n'
                      'Technologies used: Flutter, Dart, Firebase Authentication, UI/UX Design, Theming'),
              pw.SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildProjectSection(
                  'Meal App',
                  'GitHub: github.com/Abhijith06546/Meal_App',
                  'Created a Flutter-based meal planning application, enabling users to explore, filter, and save recipes. The project includes:\n'
                      '- Category-based meal browsing with detailed ingredient lists, preparation steps, and duration times.\n'
                      '- Integrated dietary filters (gluten-free, lactose-free, vegetarian, vegan) to enhance user personalization.\n'
                      '- Functionality for users to mark meals as favorites for easy retrieval.\n'
                      '- Utilized Navigator 2.0 for advanced navigation management and Riverpod for efficient state management.\n'
                      'Technologies used: Flutter, Dart, Riverpod, Navigator 2.0, UI/UX Design'),
              pw.SizedBox(height: 20),
              pw.Text('EDUCATION', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),

              pw.Text('B.Tech in Computer Science and Engineering, Carmel College of Engineering & Technology'),
              pw.SizedBox(height: 10),
              pw.Text('Higher Secondary Education, Matha Senior Secondary School, Alappuzha'),
              pw.SizedBox(height: 20),
              pw.Text('SKILLS', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),

              _buildSkillsSection(),
              pw.SizedBox(height: 20),
              pw.Text('CERTIFICATES AND INTERNSHIPS', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),

              pw.Text('Architecting with Google Compute Engine - June 2021'),
              pw.SizedBox(height: 5),

              pw.Text('Flutter Internship Program, FEB 24 - July 24'),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildProjectSection(String title, String link, String description) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.UrlLink(child: pw.Text(link, style: pw.TextStyle(color: PdfColors.blue)), destination: link),
        pw.Text(description),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildSkillsSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Bullet(text: 'Programming Languages: Dart, JavaScript, HTML, CSS, SQL'),
        pw.Bullet(text: 'Mobile Development: Flutter, Firebase, REST API Integration, Riverpod'),
        pw.Bullet(text: 'Web Development: HTML, CSS, JavaScript'),
        pw.Bullet(text: 'Tools & Technologies: Firebase Authentication, Firebase Realtime Database, Git'),
        pw.Bullet(text: 'Core Skills: Problem Solving, Time Management, Self-Learner'),
        pw.Bullet(text: 'Languages: Malayalam, English, Tamil, Hindi'),
      ],
    );
  }
}
