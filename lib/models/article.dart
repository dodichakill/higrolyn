import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class Article {

  const Article({
    required this.data,
    required this.status,
  });

  final Data data;
  final String status;

  factory Article.fromJson(Map<String,dynamic> json) => Article(
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'data': data.toJson(),
    'status': status
  };

  Article clone() => Article(
    data: data.clone(),
    status: status
  );


  Article copyWith({
    Data? data,
    String? status
  }) => Article(
    data: data ?? this.data,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Article && data == other.data && status == other.status;

  @override
  int get hashCode => data.hashCode ^ status.hashCode;
}

@immutable
class Data {

  const Data({
    required this.description,
    required this.id,
    required this.location,
    required this.releasedDate,
    required this.thumbnail,
    required this.title,
  });

  final String description;
  final int id;
  final String location;
  final String releasedDate;
  final String thumbnail;
  final String title;

  factory Data.fromJson(Map<String,dynamic> json) => Data(
    description: json['description'].toString(),
    id: json['id'] as int,
    location: json['location'].toString(),
    releasedDate: json['released_date'].toString(),
    thumbnail: json['thumbnail'].toString(),
    title: json['title'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'description': description,
    'id': id,
    'location': location,
    'released_date': releasedDate,
    'thumbnail': thumbnail,
    'title': title
  };

  Data clone() => Data(
    description: description,
    id: id,
    location: location,
    releasedDate: releasedDate,
    thumbnail: thumbnail,
    title: title
  );


  Data copyWith({
    String? description,
    int? id,
    String? location,
    String? releasedDate,
    String? thumbnail,
    String? title
  }) => Data(
    description: description ?? this.description,
    id: id ?? this.id,
    location: location ?? this.location,
    releasedDate: releasedDate ?? this.releasedDate,
    thumbnail: thumbnail ?? this.thumbnail,
    title: title ?? this.title,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Data && description == other.description && id == other.id && location == other.location && releasedDate == other.releasedDate && thumbnail == other.thumbnail && title == other.title;

  @override
  int get hashCode => description.hashCode ^ id.hashCode ^ location.hashCode ^ releasedDate.hashCode ^ thumbnail.hashCode ^ title.hashCode;
}
