class TodoModel {
  String title;
  bool completed;
  int id;
  int userId;

  TodoModel(
      {required this.title,
      required this.completed,
      required this.id,
      required this.userId});

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        title: map["title"],
        completed: map['completed'],
        id: map["id"],
        userId: map["userid"]);
  }
}
