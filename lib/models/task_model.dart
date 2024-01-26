import 'dart:convert';

class TaskModel {
  String id;
  bool? completed;
  String? title;
  String? description;
  DateTime? dueDate;
  String? owner;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TaskModel({
    required this.id,
    this.completed,
    this.title,
    this.description,
    this.dueDate,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data) => TaskModel(
        completed: data['completed'] as bool?,
        id: data['_id'] as String,
        title: data['title'] as String?,
        description: data['description'] as String?,
        dueDate: data['dueDate'] == null
            ? null
            : DateTime.parse(data['dueDate'] as String),
        owner: data['owner'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'completed': completed,
        '_id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate?.toIso8601String(),
        'owner': owner,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TaskModel].
  factory TaskModel.fromJson(String data) {
    return TaskModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TaskModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
