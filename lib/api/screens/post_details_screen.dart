import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/models/post.dart';
import 'package:path/path.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${post.id}'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.yellowAccent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              post.body,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
            const SizedBox(height: 30),
            Chip(
              label: Text('User ${post.userId}'),
              avatar: const Icon(Icons.add_box_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
