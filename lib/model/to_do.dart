import 'dart:convert';

class ToDo {
  String? title;
  String? note;
  bool done;

  ToDo({
    required this.title,
    required this.note,
    this.done = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'done': done,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      title: map['title'] != null ? map['title'] : null,
      note: map['note'] != null ? map['note'] : null,
      done: map['done'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));
}
