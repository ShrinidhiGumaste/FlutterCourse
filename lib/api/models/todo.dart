class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  // Todo.fromJson => This is the name of our Factory Constructor(Method).
  // Map<String, dynamic> => This Represents JSON Object.
  // fromJson => It converts from JSON to DART MODELS.
  // Getting the Data from JSON.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // Here MAP is used Again Because JSON Objects are Represented as MAPS in Dart.
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'completed': completed};
  }
}
