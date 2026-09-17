import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/services/api_service.dart';
import 'package:fluttercourse/api/widgets/comment_card.dart';

import '../models/comment.dart';

class CommentHomeScreen extends StatefulWidget {
  //StatefulWidget Because this screen has data that can change.
  const CommentHomeScreen({super.key});

  @override
  // This connects the screen to its State class.
  State<StatefulWidget> createState() => _CommentHomeScreenState();
}

class _CommentHomeScreenState extends State<CommentHomeScreen> {
  final ApiService apiService =
      ApiService(); // This creates an object of ApiService.Because your API code is inside ApiService.

  // To recive Data in List .
  late Future<List<Comment>>
  commentsFuture; // API dosen't gives the Data immediately so it is assigned to late and Future, So thet it can be available in Future.

  @override
  // This runs Firstly when the screen is created.
  void initState() {
    super.initState();
    commentsFuture = apiService.fetchComments();
  }

  Future<void> refreshComments() async {
    setState(() {
      // setState() tells Flutter That Something changed, Build the UI again.
      commentsFuture = apiService.fetchComments();
    });
    await commentsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'Comments 💬',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        // Used to change the Colour of Text/Icons.
        actions: [
          // This creates the refresh icon and refreshComments Runs.
          IconButton(
            onPressed: refreshComments,
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),

      body: FutureBuilder<List<Comment>>(
        future: commentsFuture,
        builder: (context, snapshot) {
          // snapshot contains the current result/state of the Future.
          // For LOADING State....
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // For ERROR....
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Icon(
                    Icons.cloud_off_outlined,
                    size: 65,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    'Something Went Wrong 🙄',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  const SizedBox(height: 8),

                  const Text('Unable to Load Comments'),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: refreshComments,
                    icon: const Icon(Icons.refresh_sharp),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          // No DATA....
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // !snapshot.hasData => There is no Data.
            // snapshot.data!.isEmpty => Data exists, but the list contains zero comments.
            return const Center(
              child: Text(
                'No Comments Found 💬',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          final comments = snapshot
              .data!; // snapshot.data contains the comments received from the API.

          // For DATA....
          return RefreshIndicator(
            onRefresh: refreshComments,
            child: Column(
              children: [
                // For HEADER....
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.deepPurple.shade100,
                        child: const Icon(
                          Icons.forum_outlined,
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Community Comments',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Read what People are Saying',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),

                      Text(
                        '${comments.length}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                // For COMMENTS List....
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      // snapshot.data contains the comments received from the API.
                      final comment =
                          comments[index]; // Getting/Taking one comment from the list.

                      return CommentCard(
                        comment: comment,
                      ); // This sends that one comment to CommentCard.
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
