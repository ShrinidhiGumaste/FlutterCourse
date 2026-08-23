import 'package:flutter/material.dart%20';
import 'package:shared_preferences/shared_preferences.dart';

class SHPHomePage extends StatefulWidget {
  const SHPHomePage({super.key});

  @override
  State<SHPHomePage> createState() => _SHPHomePageState();
}

class _SHPHomePageState extends State<SHPHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  String savedName = '';
  String? pin;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Read and get Data from SharedPreferences.
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedName = prefs.getString('name') ?? '';
      pin = prefs.getString('pin');
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  // Saving Data within the SharedPreferences.
  // For LOGIN
  Future<void> login() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("!! Name can't be Empty !!")));
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', nameController.text.trim());
    await prefs.setString('pin', pinController.text.trim());
    await prefs.setBool('isLoggedIn', true);

    setState(() {
      savedName = nameController.text.trim();
      pin = pinController.text.trim();
      isLoggedIn = true;
    });
    nameController.clear();
    pinController.clear();
  }

  // For LOGOUT.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('name');
    await prefs.remove('pin');
    await prefs.setBool('isLoggedIn', false);

    setState(() {
      savedName = '';
      pin = null;
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SH_HomePage',
          style: TextStyle(fontStyle: FontStyle.normal, color: Colors.blue),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome $savedName Your PIN is $pin',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(onPressed: logout, child: Text('LogOut')),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: '** Enter Your Name **',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '** Enter Your 4 Digit PIN **',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(onPressed: login, child: const Text('Login')),
                ],
              ),
      ),
    );
  }
}
