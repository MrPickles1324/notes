import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Note extends Equatable {
  final String title;
  final DateTime dateCreated;
  final String content;
  Note({
    required this.title,
    required this.dateCreated,
    required this.content,
  });

  @override
  List<Object> get props => [title, dateCreated, content];

  Note copyWith({
    String? title,
    DateTime? dateCreated,
    String? content,
  }) {
    return Note(
      title: title ?? this.title,
      dateCreated: dateCreated ?? this.dateCreated,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
