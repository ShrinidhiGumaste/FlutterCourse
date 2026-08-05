import 'package:flutter/material.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  // CreateState
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {

  // To take Inputs from user.
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();


  String name = "";
  String age = "";
  String email = "";
  String phone = "";
  String city = "";


  // Adding User.
  void addUser() {

    setState(() {

      name = nameController.text;
      age = ageController.text;
      email = emailController.text;
      phone = phoneController.text;
      city = cityController.text;

    });

    nameController.clear();
    ageController.clear();
    emailController.clear();
    phoneController.clear();
    cityController.clear();
  }


  // Deleting User.
  void deleteUser() {

    setState(() {

      name = "";
      age = "";
      email = "";
      phone = "";
      city = "";

    });
  }



  // Using dispose() helps to improve Memory Management.
  @override
  void dispose() {

    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "User Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Center(

          child: Column(

            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(

                onPressed: addUser,

                child: const Text(
                  "ADD USER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),

              const SizedBox(height: 25),


              if (name.isNotEmpty)

                Card(

                  elevation: 10,

                  child: Padding(

                    padding: const EdgeInsets.all(15),

                    child: ListTile(

                      leading: const CircleAvatar(

                        radius: 30,

                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),

                      title: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const SizedBox(height: 10),

                          Text("Age : $age"),

                          Text("Email : $email"),

                          Text("Phone : $phone"),

                          Text("City : $city"),

                        ],
                      ),

                      trailing: IconButton(

                        onPressed: () {
                          deleteUser();
                        },

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}