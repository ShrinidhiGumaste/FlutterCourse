import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/services/api_service.dart';
import 'package:fluttercourse/api/widgets/todo_card.dart';

import '../models/todo.dart';

// creating HomeScreen.
// Used StatefulWidget Because this screen has changing information.
class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final ApiService apiService = ApiService(); // Creating an Object of ApiService.

  // In the future, I will receive a list of Todo objects.
  late Future<List<Todo>> todosFuture; // getting data from the internet takes time, so Future is Used.

  // initState() runs once when the StatefulWidget is first created.
  @override
  void initState() {
    // Just UnderStanding like "First let Flutter perform its initialization, then do my initialization."
    super.initState();

    todosFuture = apiService.fetchTodos(); // fetching Todos Data from ApiService.
  }

  // Used to Fetch Todo Data Again.
  // Void Because this function performs an asynchronous operation but doesn't return any useful value.
  Future<void> refreshTodos() async {
    setState(() { // Understanding just like "Something has changed. Please rebuild this screen."
      todosFuture = apiService.fetchTodos();
    });
    await todosFuture; // Just Understanding like "Wait until the new Todo API request finishes."
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold provides the basic structure of a Material app screen
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'My TODOS😊',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // FutureBuilder is used when it have a Future and want to show different UI depending on its state.
      body: FutureBuilder<List<Todo>>(
        future: todosFuture,

        // For LOADING State....
        // context => Location in the Widget Tree(where it is Located).
        // snapshot => contains information about the Future.
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // For ERROR....
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.error_sharp,
                      size: 65,
                      color: Colors.redAccent,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Something went Wrong 🙄',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Unable to load Todo data 🙄',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: refreshTodos,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry 😑'),
                    ),
                  ],
                ),
              ),
            );
          }

          // For EMPTY DATA....
          // checks whether the Todo list contains zero items.
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No Todos Found 🙄',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          }
          final todos = snapshot.data!;

          // For SUCCESS....
          return RefreshIndicator(
            onRefresh: refreshTodos,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              // Tells ListView.builder how many items to create. And prevents from the Error of Overflow from Screen.
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return TodoCard(todo: todo);
              },
            ),
          );
        },
      ),
    );
  }
}
