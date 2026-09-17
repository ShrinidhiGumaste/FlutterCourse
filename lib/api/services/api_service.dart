import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttercourse/api/models/api_user.dart';
import 'package:fluttercourse/api/models/comment.dart';
import 'package:fluttercourse/api/models/photo.dart';
import 'package:fluttercourse/api/models/post.dart';
import 'package:fluttercourse/api/models/todo.dart';
import 'package:http/http.dart' as http;

// This Function is used to return List of Photo Objects.
List<Photo> parsePhotos(String responseBody) {
  // jsonDecode this is the Heavy Work.
  final List<dynamic> jsonData = jsonDecode(responseBody);

  return jsonData.map((json) {
    return Photo.fromJson(json);
  }).toList();
}

// This Function is used to return List of Photo Objects.
List<Comment> parseComments(String responseBody) {
  // jsonDecode this is the Heavy Work.
  final List<dynamic> jsonData = jsonDecode(responseBody);

  return jsonData.map((json) {
    return Comment.fromJson(json);
  }).toList();
}

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts!");
    }
  }

  // For POSTS....
  Future<Post> getPost(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/posts/$id"));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load post!");
    }
  }

  // For USERS....
  Future<List<ApiUser>> fetchUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((u) => ApiUser.fromJson(u)).toList();
    } else {
      throw Exception("Failed to load users!");
    }
  }

  // For TODOS....
  // FUTURE is used Because we're getting data from an internet API, and the internet takes some time to respond.
  // This Function will return me the List of Todo Objects in FUTURE.

  Future<List<Todo>> fetchTodos() async {
    // Here the Data coming from Internet will be Stored in Response.
    // We should Convert URL to URI because http.get() can use it.
    final response = await http.get(Uri.parse("$baseUrl/todos"));

    // This is Checked to see that the Server will successfully give Data or not.
    if (response.statusCode == 200) {
      // jsonDecode() => Converts JSON String into Dart data.
      // response.body => Because Body contains actual data Returned by API.
      final List<dynamic> jsonData = jsonDecode(response.body);

      // Take every JSON Todo, convert it into a Todo object, and put all those Todo objects into a List.
      return jsonData.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to Load Todos🙄');
    }
  }

  Future<List<Photo>> getPhotos() async {
    final response = await http.get(Uri.parse("$baseUrl/photos"));

    if (response.statusCode == 200) {
      // jsonDecode this is the Heavy Work Previously performed in Main Isolate.
      // So sometimes Main isolate get Blocked because of this heavy Work.
      // For that we are using this COMPUTE.
      // COMPUTE => It is used to perform heavy work in another Isolate.
      // It creates another Memory to perform so that tha Main Isolate dosen't get Blocked.
      final photos = await compute(parsePhotos, response.body);
      return photos;
    } else {
      throw Exception("Failed to load Photos 😑");
    }
  }

  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    if (response.statusCode == 200) {
      // jsonDecode this is the Heavy Work Previously performed in Main Isolate.
      // So sometimes Main isolate get Blocked because of this heavy Work.
      // For that we are using this COMPUTE.
      // COMPUTE => It is used to perform heavy work in another Isolate.
      // It creates another Memory to perform so that tha Main Isolate dosen't get Blocked.
      final comments = await compute(parseComments, response.body);
      return comments;
    } else {
      throw Exception('Failed to Load Comments 😑');
    }
  }
}
