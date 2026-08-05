
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoHomeScreen extends StatefulWidget{
  const TodoHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoHomeScreen>{
   TextEditingController controller=TextEditingController();
   TextEditingController descriptionController=TextEditingController();

  List<String> task = [];
  List<String> taskDescription = [];

  void addTask(){
    if(controller.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty){
      setState(() {
        task.add(controller.text.trim());
        taskDescription.add(descriptionController.text.trim());
        controller.clear();
        descriptionController.clear();
      });
    }
  }

  void deleteTask(int index){
    setState(() {
      task.removeAt(index);
      taskDescription.removeAt(index);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Home', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic ,decoration: TextDecoration.underline ),),backgroundColor: Colors.limeAccent,
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Today's Tasks",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5,),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: "Something about Your Task",
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: addTask, child: Text('-- ADD --',
                        style: TextStyle(color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),),),
          SizedBox(height: 4,),
          Divider(thickness: 1.5,),
          SizedBox(height: 32,),
          task.isNotEmpty
              ?

          Text(
            "Your Pending Tasks",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
              :
          SizedBox(height: 8,),

          Expanded(child: task.isEmpty ?
              const Center(child: Text('=) NO TASKS! (='),)
              : ListView.builder(itemCount: task.length,
                itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.deck_outlined),
                    title: Text(task[index]),
                    subtitle: Text(taskDescription[index]),
                    trailing: IconButton(onPressed: (){
                      deleteTask(index);
                    }, icon: Icon(Icons.design_services_outlined)),
                  ),
                );
                },)
          )
        ],
      ),
    );
  }
}