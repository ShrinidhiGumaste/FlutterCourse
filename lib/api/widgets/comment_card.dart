import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  // CONSTRUCTOR....
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      // Used for Shadow for the Card.
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      // EdgeInsets => Gives the Space Inside the Card so that the Text dosen't Touch the Edges.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: Padding(
        padding: const EdgeInsetsGeometry.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // For TOP ROW....
            Row(
              children: [
                // For USER ICON....
                CircleAvatar(
                  // CircleAvatar => Creates the round user icon/profile area.So the comment ID appears inside the circle.
                  radius: 25,
                  backgroundColor: Colors.deepPurple.shade100,

                  child: Text(
                    comment.id.toString(),
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  // Expanded => Used to Prevent Overflow.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        comment.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //TextOverflow.ellipsis => When the Text is too Long it is used to prevent from Overflow.
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        comment.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // For COMMENT ID....
                Container(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '#${comment.id}',
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // DIVIDER....
            const Divider(), //Creates a horizontal line to separate sections.

            const SizedBox(height: 10),

            // For COMMENT....
            Text(
              comment.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

            const SizedBox(height: 14),

            // For BOTTOM ROW....
            Row(
              children: [
                const Icon(
                  Icons.article_outlined,
                  size: 19,
                  color: Colors.deepPurple,
                ),

                const SizedBox(width: 6),

                Text(
                  'Post ${comment.postId}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(), //Pushes the View button to the right.

                // For VIEW BUTTON....
                TextButton.icon(
                  onPressed: () {
                    showDialog( // Opens a popup window when we click View.
                      context: context,
                      builder: (context) {
                        return AlertDialog( // Used to Design the PopUp Box.
                          title: const Text('Comment Details'),

                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                comment.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                comment.email,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),

                              const SizedBox(height: 15),

                              Text(
                                comment.body,
                                style: TextStyle(fontSize: 15, height: 1.4),
                              ),

                              const SizedBox(height: 15),

                              Text('Comment ID: ${comment.id}'),

                              Text('Post ID: ${comment.postId}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 18),

                  label: const Text('View'), // this Displays the Text on the Button.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
