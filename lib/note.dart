import 'package:flutter/foundation.dart';

class Note {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isPriority;
  bool isDone;

  Note({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isPriority,
    this.isDone = false,
  });

  void markAsDone() {
    isDone = true;
  }

  void markAsUndone() {
    isDone = false;
  }

  static Note createNew({
    required String title,
    required String description,
    required DateTime dueDate,
    required bool isPriority,
  }) {
    return Note(
      title: title,
      description: description,
      dueDate: dueDate,
      isPriority: isPriority,
    );
  }
}
