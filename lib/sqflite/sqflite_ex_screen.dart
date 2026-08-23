import 'package:flutter/material.dart%20';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MySQFLiteApp());
}

class MySQFLiteApp extends StatelessWidget {
  const MySQFLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Student DB Sqflite",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Database? database;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    final dbPath = await getDatabasesPath();

    database = await openDatabase(
      p.join(dbPath, 'student.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE students(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      age INTEGER,
      course TEXT
     )
    ''');
      },
    );

    loadStudents();
  }

  Future<void> loadStudents() async {
    final data = await database!.query('students');

    setState(() {
      students = data;
    });
  }

  // CRUD OP

  // insert student
  Future<void> addStudent() async {
    if (nameController.text.trim().isEmpty ||
        ageController.text.isEmpty ||
        courseController.text.isEmpty) {
      return;
    }

    await database!.insert('students', {
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'course': courseController.text,
    });

    nameController.clear();
    ageController.clear();
    courseController.clear();
    if (mounted) {
      Navigator.pop(context);
    }
    loadStudents();
  }

  // update student
  Future<void> updateStudent(int id) async {
    await database!.update(
      'students',
      {
        'name': nameController.text,
        'age': int.parse(ageController.text),
        'course': courseController.text,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    nameController.clear();
    ageController.clear();
    courseController.clear();
    if (mounted) {
      Navigator.pop(context);
    }
    loadStudents();
  }

  // delete student
  Future<void> deleteStudent(int id) async {
    await database!.delete('students', where: 'id = ?', whereArgs: [id]);

    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_box_outlined),
        onPressed: () {
          showStudentDialog();
        },
      ),
      appBar: AppBar(title: const Text("Student Management")),
      body: students.isEmpty
          ? const Center(child: Text("No students found!"))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(student['name']),
                    leading: Text('${student['id']}'),
                    subtitle: Text(
                      'Age ${student['age']} | Course ${student['course']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showStudentDialog(id: student['id']);
                          },
                          icon: const Icon(Icons.edit_note, color: Colors.cyan),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteStudent(student['id']);
                          },
                          icon: Icon(Icons.delete_forever, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void showStudentDialog({int? id}) {
    if (id != null) {
      final student = students.firstWhere((s) => s['id'] == id);

      nameController.text = student['name'].toString();
      ageController.text = student['age'].toString();
      courseController.text = student['course'].toString();
    } else {
      nameController.clear();
      ageController.clear();
      courseController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Add Student' : 'Update Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameController.clear();
                ageController.clear();
                courseController.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (id == null) {
                  addStudent();
                } else {
                  updateStudent(id);
                }
              },
              child: Text(id == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
