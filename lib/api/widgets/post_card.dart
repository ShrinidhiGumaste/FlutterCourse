import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text('${post.id}')),
        title: Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16),
        onTap: onTap,
      ),
    );
  }
}
