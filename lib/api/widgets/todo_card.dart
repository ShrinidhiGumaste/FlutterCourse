import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/models/todo.dart';

class TodoCard extends StatelessWidget {
  // This Variable contains one Todo Object.
  final Todo todo; // This Creates a Variable call todo. This is of type Todo.

  // CONSTRUCTOR.
  TodoCard({super.key, required this.todo});

  @override
  // build => It tells Flutter what UI must be Displayed.
  Widget build(BuildContext context) {
    // This Creates a Boolean Variable.
    final bool completed = todo.completed;

    return Card( // Used to create a Style Card.
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 14),// Used to create the Space outside the CArd.
      elevation: 3, // Used to create a Shadow Effect.
      shape: RoundedRectangleBorder( // Shape Defines the shape of Card.
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      clipBehavior: Clip.antiAlias, // Used to make the Clipping Edges Smoothly.

      child: ExpansionTile( // This makes Todo card expand and collapse.
        // tilePadding => Adds Space inside the Expansion Tile.
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // leading => Used to Show Widget at the beginning/left side of the tile.
        leading: CircleAvatar(
          radius: 26,
          // Checking the Condition that, If the Task is COMPLETED or PENDING.
          backgroundColor: completed
              ? Colors.green.shade100
              : Colors.orange.shade100,

          // Changing the Icons according to Condition.
          child: Icon(
            completed ? Icons.check_circle : Icons.pending_actions_sharp,

            color: completed ? Colors.green : Colors.orange,

            size: 28,
          ),
        ),
        title: Text(
          todo.title,
          maxLines: 2, // Used Because that the Title can Occupy maximum Two Lines.
          overflow: TextOverflow.ellipsis, // If Text is too Long this is used to display(....).
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.redAccent,
          ),
        ),

        subtitle: Padding( // Used to display Smaller Information Below the Title.
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'Todo ID: ${todo.id}',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ),

        children: [
          const Divider(height: 1),

          // Information of TODO....
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.task_alt_sharp, color: Colors.blue),

                    const SizedBox(width: 8),

                    const Text(
                      'TODO Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // For ID....
                _infoRow(Icons.numbers, 'Todo ID', todo.id.toString()),

                // For USERID....
                _infoRow(Icons.person, 'User ID', todo.userId.toString()),

                // For TITLE....
                _infoRow(Icons.title_sharp, 'Title', todo.title),

                const SizedBox(height: 12),

                // STATUS....
                Row(
                  children: [
                    const Icon(Icons.info_sharp, size: 21),

                    const SizedBox(width: 12),

                    const Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const Spacer(),

                    Chip( // Used to display Information.
                      avatar: Icon( //avatar => Used to add an Icon Inside the chip.
                        completed ? Icons.check_circle : Icons.pending,

                        size: 18,

                        color: completed ? Colors.green : Colors.orange,
                      ),
                      label: Text(completed ? 'Completed' : 'Pending'),

                      backgroundColor: completed
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, size: 21, color: Colors.grey.shade500),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),

                const SizedBox(height: 3),

                Text(value, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
