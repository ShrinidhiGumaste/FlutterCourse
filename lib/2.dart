import 'package:flutter/material.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {

  List<Map<String, String>> users = [];

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();


  void addUser() {

    setState(() {

      users.add({

        "name": nameController.text,
        "age": ageController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "city": cityController.text,

      });

    });

    nameController.clear();
    ageController.clear();
    emailController.clear();
    phoneController.clear();
    cityController.clear();

    Navigator.pop(context);

  }


  void showDialogBox() {

    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(

          title: const Text("Add User"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  controller: nameController,
                  decoration:
                  const InputDecoration(labelText: "Name"),
                ),

                TextField(
                  controller: ageController,
                  decoration:
                  const InputDecoration(labelText: "Age"),
                ),

                TextField(
                  controller: emailController,
                  decoration:
                  const InputDecoration(labelText: "Email"),
                ),

                TextField(
                  controller: phoneController,
                  decoration:
                  const InputDecoration(labelText: "Phone Number"),
                ),

                TextField(
                  controller: cityController,
                  decoration:
                  const InputDecoration(labelText: "City"),
                ),
              ],
            ),
          ),

          actions: [

            ElevatedButton(
              onPressed: addUser,
              child: const Text("ADD USER"),
            )

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "User List Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showDialogBox,
        child: const Icon(Icons.add),
      ),

      body: users.isEmpty
          ? const Center(
        child: Text(
          "No Users Added",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      )

          : ListView.builder(

        itemCount: users.length,

        itemBuilder: (context, index) {

          final user = users[index];

          return Card(

            elevation: 5,
            margin: const EdgeInsets.all(10),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: ListTile(

              leading: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person,size: 30),
              ),

              title: Text(
                user["name"]!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text("Age : ${user["age"]}"),
                  Text(user["email"]!),
                  Text(user["phone"]!),
                  Text("Lives in ${user["city"]}"),

                ],
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.design_services,
                ),
                onPressed: () {

                  setState(() {
                    users.removeAt(index);
                  });

                },
              ),
            ),
          );
        },
      ),
    );
  }
}